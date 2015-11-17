//
//  DetailView.h
//  Eyes
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TodayModel.h"

@protocol DetailViewDelegate <NSObject>

//点击视频播放执行的方法
- (void)playMovie:(TodayModel *)model;

@end

@interface DetailView : UIView

@property (strong, nonatomic) TodayModel *model;

@property (strong, nonatomic) UILabel *info;//详情的简介

@property (assign, nonatomic) id<DetailViewDelegate>delegate;

@end
