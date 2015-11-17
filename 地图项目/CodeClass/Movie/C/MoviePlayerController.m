//
//  MoviePlayerController.m
//  Eyes
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MoviePlayerController.h"
#import "MoviePlayer.h"
#import "AppDelegate.h"
#import "UIView+Frame.h"

@interface MoviePlayerController ()<MoviePlayerDelegate>

//防止模拟器视频播放不出来，直接设置为属性
@property (strong, nonatomic) MoviePlayer *moviePlayer;

@end

@implementation MoviePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.moviePlayer = [[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width) URL:[NSURL URLWithString:self.url]];
    self.moviePlayer.title = @"返回";
    self.moviePlayer.delegate = self;
    [self.view addSubview:self.moviePlayer];
}

- (void)back{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //设置属性，让它只支持竖屏切换
    appDelegate.isRotation = NO;
    //一定要写在视图消失和加载之前.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
