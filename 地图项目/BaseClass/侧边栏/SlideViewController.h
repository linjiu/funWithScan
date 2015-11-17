//
//  MainViewController.h
//  YSHYSlideController
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface SlideViewController : UINavigationController<UINavigationControllerDelegate>
@property (nonatomic, assign)NSInteger menuWidth;
@property (nonatomic, strong)UIViewController *leftMenu;
@property (nonatomic, assign)BOOL MenuIsOpen;

+(SlideViewController *)shareInstance;
-(void)setMainViewController:(UIViewController *)ViewController;
-(void)GotoViewController:(UIViewController *)viewController;
-(void)GotoRootViewController;
-(void)SwitchMenuState;
-(void)addGesture;
-(void)removeAllGesture;
@end
