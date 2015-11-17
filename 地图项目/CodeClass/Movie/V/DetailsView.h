//
//  DetailsView.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface DetailsView : UIView

//电影名
@property (nonatomic, strong) UILabel *title;
//电影类型
@property (nonatomic, strong) UILabel *genres;
//评分
@property (nonatomic, strong) UILabel *rating;
//演员表
@property (nonatomic, strong) UILabel *casts;
//时长
@property (nonatomic, strong) UILabel *durations;
//导演
@property (nonatomic, strong) UILabel *directors;
//上映时间
@property (nonatomic, strong) UILabel *pubdates;
@property (nonatomic, strong) UIVisualEffectView *backVisual;
@property (nonatomic, strong) UIImageView *imageView;

@end
