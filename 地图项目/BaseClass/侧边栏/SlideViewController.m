//
//  MainViewController.m
//  YSHYSlideController
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "SlideViewController.h"
static SlideViewController *signletonInstance;

@interface SlideViewController ()

@end

@implementation SlideViewController

+(SlideViewController *)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        signletonInstance = [[self alloc] init];
    });
    return  signletonInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationBar.hidden = YES;
    signletonInstance = self;
    self.delegate = self;
    //禁止NavigationController中的系统自带pop效果
    self.interactivePopGestureRecognizer.enabled = NO;
    self.MenuIsOpen = NO;
    [self ConfigUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addGesture];
}

-(void)ConfigUI
{
    self.menuWidth = 200;
    
    self.view.layer.shadowColor =[UIColor darkGrayColor].CGColor;
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shadowRadius =10;
    self.view.layer.shouldRasterize = YES;
}
-(void)addGesture
{
    //添加手势
    UISwipeGestureRecognizer *swipRightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(PanGestureRespond:)];
    swipRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipRightGesture];
    
    UISwipeGestureRecognizer *swipLeftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(PanGestureRespond:)];
    swipLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipLeftGesture];
}


-(void)removeAllGesture
{
    for (UISwipeGestureRecognizer * gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }

}

#pragma mark - 设置
-(void)setMainViewController:(UIViewController *)ViewController
{
    [super pushViewController:ViewController animated:YES];
}

-(void)PanGestureRespond:(UISwipeGestureRecognizer * )gesture
{
    if(gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self OpenMenu];
    }
    else if(gesture.direction ==UISwipeGestureRecognizerDirectionLeft)
    {
        [self CloseMenu];
    }
}
#pragma mark - 跳转到选中的Controller
-(void)GotoViewController:(UIViewController *)viewController
{
    [self GotoRootViewController];
    [super pushViewController:viewController animated:NO];
}
-(void)GotoRootViewController
{
    [self CloseMenu];
    [super popToRootViewControllerAnimated:NO];
    [self removeAllGesture];
}

-(void)SwitchMenuState
{
    if(self.MenuIsOpen)
    {
        [self CloseMenu];
    }
    else
    {
        [self OpenMenu];
    }
}
-(void)OpenMenu
{
    self.MenuIsOpen = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view setFrame:CGRectMake(self.menuWidth, 100, self.view.frame.size.width, kScreenHeight- 200)];
        [self.view.window insertSubview:self.leftMenu.view atIndex:0];
        UIView *view = self.leftMenu.view.subviews[1];
        view.hidden = YES;
        
    }];
}

-(void)CloseMenu
{
    self.MenuIsOpen = NO;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight)];
        UIView *view = self.leftMenu.view.subviews[1];
        view.hidden = NO;
    } completion:^(BOOL finished) {
            [self.leftMenu.view removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.MenuIsOpen)
    {
        [self CloseMenu];
    }
}

@end
