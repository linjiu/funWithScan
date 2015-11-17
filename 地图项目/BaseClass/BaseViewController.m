//
//  BaseViewController.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "BaseViewController.h"
#import "SlideViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.customBar = [[navBar alloc] initWithFrame:CGRectMake(0, 0, [navBar barWidth], [navBar barHeight])];
    self.customBar.VC = self;
    [self.view addSubview:self.customBar];
    
    /**
     *  返回按钮及方法
     */
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-liebiao"] forState:UIControlStateNormal];
    [self.customBar setLeftNavButton:leftBtn];

    

}
/**
 *  侧边栏方法
 *
 *  @param animated 
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SlideViewController shareInstance] addGesture];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[SlideViewController shareInstance] removeAllGesture];
}

-(void)leftBtnClick:(UIButton *)button
{
    [[SlideViewController shareInstance]SwitchMenuState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss:(UIAlertController *)alertC
{
    [alertC dismissViewControllerAnimated:YES completion:nil];
}
- (void)setLoading
{
    // UIColor *ballColor = [UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1];
    self.pendulum = [[PendulumView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width - 100) ballColor:[UIColor lightGrayColor]];
    self.pendulum.center = self.view.center;
    [self.view addSubview:self.pendulum];
    
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
