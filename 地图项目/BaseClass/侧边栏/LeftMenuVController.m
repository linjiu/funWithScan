//
//  LeftMenuVController.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#define cellHeight   50

#import "LeftMenuVController.h"
#import "SlideViewController.h"

#import "BaseViewController.h"
#import "MainViewController.h"

#import "MovieViewController.h"
#import "RecommandMainVC.h"
#import "TodayController.h"
#import "LiveViewController.h"
@interface LeftMenuVController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftMenuVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view  setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"模糊背景"]]];
    
    
    //菜单选项
    self.tableMenu  = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 200, self.view.frame.size.height)];
    self.tableMenu.delegate = self;
    self.tableMenu.dataSource = self;
    self.currentIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.view addSubview:self.tableMenu];
    
    //覆盖层  选中菜单 回到页面时出现的菜单变暗的效果
    self.coverView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.coverView setBackgroundColor:[UIColor blackColor]];
    self.coverView.alpha = 0.5;
    [self.view addSubview:self.coverView];
    
    self.tableMenu.backgroundColor = [UIColor clearColor];

}

# pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 6;
    CGRect frame  = tableView.frame;
    frame.size.height = cellHeight * row;
    tableView.frame = frame;
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"返回主页";
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"音乐推荐";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"娱乐短片";
    }else if(indexPath.row == 3){
        cell.textLabel.text = @"热映电影";
    }else if(indexPath.row == 4){
        cell.textLabel.text = @"电台直播";
    }else {
        cell.textLabel.text = @"清理缓存";
    }
    cell.backgroundColor = [UIColor clearColor];
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   
    if(indexPath.row == 0)
    {
        MainViewController * vc = [[MainViewController alloc]init];
        [[SlideViewController shareInstance] GotoViewController:vc];
    }
    else if(indexPath.row == 1)
    {
        RecommandMainVC *vc = [[RecommandMainVC alloc]init];
        [[SlideViewController shareInstance] GotoViewController:vc];
    }
    else if ( indexPath.row == 2)
    {
        TodayController *vc = [[TodayController alloc]init];
        [[SlideViewController shareInstance] GotoViewController:vc];
    }
    else if ( indexPath.row == 3)
    {
        MovieViewController *vc = [[MovieViewController alloc]init];
        [[SlideViewController shareInstance] GotoViewController:vc];

    }
    else if ( indexPath.row == 4)
    {
        LiveViewController *vc = [[LiveViewController alloc]init];
        [[SlideViewController shareInstance] GotoViewController:vc];
    }else{
        
        [[SlideViewController shareInstance] SwitchMenuState];
        
        float cache = [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
        NSString *clearCacheName = cache >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",cache] : [NSString stringWithFormat:@"清理缓存(%.2fK)",cache * 1024];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:clearCacheName preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *cleanAction = [UIAlertAction actionWithTitle:@"清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache] clearDisk];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存清理完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }];
        [alertC addAction:cancelAction];
        [alertC addAction:cleanAction];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window.rootViewController presentViewController:alertC animated:YES completion:nil];
        
    //        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(clean) userInfo:nil repeats:NO];
    }
    
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
