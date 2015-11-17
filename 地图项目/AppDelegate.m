//
//  AppDelegate.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//
// Button Size
#define kKYButtonInMiniSize   16.f
#define kKYButtonInSmallSize  32.f
#define kKYButtonInNormalSize 64.f

#import "AppDelegate.h"

#import "SlideViewController.h"
#import "LeftMenuVController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIImageView *image;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    /**
     侧边栏作为主控制器
     */
    LeftMenuVController * leftMenu = [[LeftMenuVController alloc]init];
    [SlideViewController shareInstance].leftMenu = leftMenu;
    self.window.rootViewController = [SlideViewController shareInstance];
    //设置mainController
    MainViewController *mainVC = [[MainViewController alloc]init];
    [[SlideViewController shareInstance] setMainViewController:mainVC];
    
    /**
     开场动画
     */
    self.image = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.image.image = [UIImage imageNamed:@"1355812920158.jpg"];
    [self.window addSubview:self.image];
    self.image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage)];
    [tap setNumberOfTouchesRequired:1];
    [self.image addGestureRecognizer:tap];
    [UIView animateWithDuration:3.7f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _image.alpha = 0;
        
    } completion:^(BOOL finished) {
        //结束动画移除
        [_image removeFromSuperview];
    
    }];
    
    return YES;
}

- (void)touchImage{
    [_image removeFromSuperview];
}

#pragma mark - 支持横竖屏切换的方法
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (_isRotation) {
        //如果是YES，只支持横屏
        return UIInterfaceOrientationMaskLandscape;
    }
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
