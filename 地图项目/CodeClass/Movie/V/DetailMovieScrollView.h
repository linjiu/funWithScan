//
//  DetailMovieScrollView.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailMovieScrollView : UIScrollView

//电影图片
@property (nonatomic, strong) UIImageView *moviePic;
//电影名称
@property (nonatomic, strong) UILabel *movieName;
//电影的国家、语言、时长
@property (nonatomic, strong) UILabel *movieCountriesLanguageDuration;
//电影类型
@property (nonatomic ,strong) UILabel *movieGenres;
//电影上映时间和地区
@property (nonatomic, strong) UILabel *moviePubdates;
//导演
@property (nonatomic, strong) UIImageView *movieDirectors;
//演员阵容
@property (nonatomic, strong) UIImageView *movieCasts;
//电影简介
@property (nonatomic, strong) UILabel *movieSummary;
//电影收藏数
@property (nonatomic, strong) UILabel *movieCollectcount;
//电影预告片图片
@property (nonatomic, strong) UIButton *movieTrailerPic;
//电影预告片标题
@property (nonatomic, strong) UILabel *movieTrailerTitle;
//演员的scrollView
@property (nonatomic, strong) UIScrollView *castsScrollView;
//所有空间的view
@property (nonatomic, strong) UIView *allView;

// 用model设置详情界面
- (void)setDetailViewWithDetailModel:(DetailModel *)model;
// 给简介的label添加一个手势
- (void)addTapLabelWithTarget:(id)target action:(SEL)action;

@end
