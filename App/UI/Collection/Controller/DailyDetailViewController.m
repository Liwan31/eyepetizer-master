//
//  DailyDetailViewController.m
//  App
//
//  Created by 张丁豪 on 16/9/7.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址: https://github.com/CalvinCheungCoder/eyepetizer
// 个人博客: http://www.zhangdinghao.cn
// QQ: 984382258 欢迎一起学习交流

#import "DailyDetailViewController.h"
#import "VideoPlayViewController.h"
#import "SVProgressHUD.h"
#import "ShareView.h"
@interface DailyDetailViewController ()

@end

@implementation DailyDetailViewController

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setUI];
    
    [self setUISwipe];
}

- (void)setUISwipe{
    
//    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [[self view] addGestureRecognizer:recognizer];
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [[self view] addGestureRecognizer:recognizer];
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
//    [[self view] addGestureRecognizer:recognizer];
    
    // 向下滑动
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:recognizer];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setUI{
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView sd_setImageWithURL:[NSURL URLWithString:self.model.ImageView] completed:nil];
    [self.view addSubview:backImageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurView.frame = backImageView.bounds;
    [backImageView addSubview:blurView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.ImageView] completed:nil];
    [self.view addSubview:imageView];
    
    UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 35, ScreenWidth/2 - 35, 70, 70)];
    playImage.image = [UIImage imageNamed:@"play"];
    [self.view addSubview:playImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageView.bottom + 10, ScreenWidth - 20, 20)];
    titleLabel.text = self.model.titleLabel;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:MyChinFont size:16.f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.bottom + 10, ScreenWidth - 20, 20)];
    messageLabel.text = [NSString stringWithFormat:@"#%@%@%@",self.model.category,@" / ",[self timeStrFormTime:self.model.duration]];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.font = [UIFont fontWithName:MyChinFontTwo size:12.f];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:messageLabel];
    
    UIButton *Linebtn = [[UIButton alloc]initWithFrame:CGRectMake(10, messageLabel.bottom + 10, ScreenWidth - 10, 1)];
    [Linebtn setBackgroundColor:[UIColor grayColor]];
    Linebtn.userInteractionEnabled = NO;
    [self.view addSubview:Linebtn];
    
    // Desc
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Linebtn.bottom + 10, ScreenWidth - 20, 100)];
    desLabel.text = self.model.desc;
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont fontWithName:MyChinFontTwo size:12.f];
    desLabel.textAlignment = NSTextAlignmentLeft;
    desLabel.numberOfLines = 0;
    
    // 设置Desc行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.model.desc];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.model.desc length])];
    [desLabel setAttributedText:attributedString1];
    [desLabel sizeToFit];
    
    [self.view addSubview:desLabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_backdown_normal@2x"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor grayColor];
    backBtn.layer.cornerRadius = 15;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(BackButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    NSArray *arr = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"collect"],
                    [UIImage imageNamed:@"upload"],
                    [UIImage imageNamed:@"btn_airplay_normal"],
                    [UIImage imageNamed:@"btn_download_normal@2x"], nil];
    
    NSDictionary *dict = self.model.consumption;
    NSArray *messageArr = [NSArray arrayWithObjects:
                           [NSString stringWithFormat:@"%@",dict[@"collectionCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"shareCount"]],
                           [NSString stringWithFormat:@"%@",dict[@"replyCount"]],
                           [NSString stringWithFormat:@"%@",@"缓存"], nil];
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *image = [[UIImageView alloc]init];
        UIButton *Btn = [[UIButton alloc]init];
        image.frame = CGRectMake(ScreenWidth/5 * i + 10, ScreenHeight - 48, 15, 15);
        Btn.frame = CGRectMake(ScreenWidth/5 * i + 25, ScreenHeight - 50, 45, 20);
        image.image = arr[i];
        Btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [Btn setTitle:messageArr[i] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont fontWithName:MyChinFont size:12.f];
        Btn.tag = i;
        [Btn addTarget:self action:@selector(BottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:image];
        [self.view addSubview:Btn];
    }
}

- (void)BottomBtnClicked:(UIButton *)Btn{
    
    NSArray *arr = [NSArray arrayWithObjects:@"收藏",@"分享",@"评论",@"下载", nil];
    NSString *str = [NSString stringWithFormat:@"你点击了%@",arr[Btn.tag]];
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////        ShareView *view = [[ShareView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 300)];
////        [self.view addSubview:view];
//        [self NavHeadToRight];
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    switch (Btn.tag) {
        case 0:
            NSLog(@"%@",str);
            break;
        case 1:
            [self NavHeadToRight];
            break;
        case 2:
            NSLog(@"%@",str);
            break;
        case 3:
            NSLog(@"%@",str);
            break;
        case 4:
            NSLog(@"%@",str);
            break;
        default:
            break;
    }
}
// 右按钮回调
- (void)NavHeadToRight{
    
    NSArray *shareAry = @[@{@"image":@"shareView_wx@2x",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend@2x",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq@2x",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_wb@2x",
                            @"title":@"新浪微博"},
                          @{@"image":@"shareView_qzone@2x",
                            @"title":@"QQ空间"},
                          @{@"image":@"share_copyLink",
                            @"title":@"复制链接"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:MyChinFont size:16.f];
    label.text = @"分享";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headerView.frame.size.height-0.5, headerView.frame.size.width - 40, 0.5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 40, 0.5)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.view addSubview:shareView];
}
- (void)easyCustomShareViewButtonAction:(ShareView *)shareView title:(NSString *)title {
    
    NSLog(@"当前点击:%@",title);
}
- (void)BackButtonDidClicked{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}

- (void)btnClicked{
    
    VideoPlayViewController *videoPlay = [[VideoPlayViewController alloc]init];
    videoPlay.UrlString = self.model.playUrl;
    videoPlay.titleStr = self.model.titleLabel;
    videoPlay.duration = [self.model.duration floatValue];
    [self showDetailViewController:videoPlay sender:nil];
}

@end
