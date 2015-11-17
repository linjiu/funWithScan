//
//  LeftMenuVController.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuVController : UIViewController

@property (nonatomic, strong) UITableView * tableMenu;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, copy) NSIndexPath  *currentIndex;

@end
