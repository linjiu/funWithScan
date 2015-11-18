//
//  LiveViewController.m
//  地图项目
//
//  Created by 09 on 15/11/10.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "LiveViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SlideViewController.h"
#import "DKCircleButton.h"
@interface LiveViewController ()
{
    BOOL buttonState;
    DKCircleButton *button1;
}

@property (nonatomic, strong) AVAsset *movieAsset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;



@end

@implementation LiveViewController

-(void)leftBtnClick:(UIButton *)button
{
    [self.player pause];
    [[SlideViewController shareInstance]SwitchMenuState];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movieName" ofType:@"movie"];
    
    NSURL *url = [NSURL URLWithString:@"http://live.xmcdn.com/192.168.3.138/live/633/24.m3u8"];

    self.movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.view.layer.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:self.playerLayer];
    
    
    
    button1 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
    
    button1.center = CGPointMake(kWidth / 2, kHeight / 2 - 50);
    button1.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
    
    [button1 addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1];

    
    

//    self.player = [[AVPlayer alloc]init];
//    self.playerItem = [[AVPlayerItem alloc]initWithURL:url];
//    
//    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
//    [self.player play];
    
    
    
}

- (void)tapOnButton {
    if (buttonState) {
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
        
        [self.player pause];

        
    } else {
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateSelected];
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateHighlighted];
        [self.player play];

    }
    
    buttonState = !buttonState;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
