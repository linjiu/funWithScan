//
//  BaseViewController.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "navBar.h"
#import "PendulumView.h"
@interface BaseViewController : UIViewController
/**
 *  自定义导航栏
 */
@property (nonatomic, strong) navBar *customBar;
/**
 *  加载中定义
 */
@property (nonatomic, strong) PendulumView *pendulum;
- (void)setLoading;
@end
