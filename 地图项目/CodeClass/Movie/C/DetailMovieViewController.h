//
//  DetailMovieViewController.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//


#import "DetailMovieScrollView.h"
#import "DetailModel.h"
#import "MovieDetailModel.h"

#import "BaseViewController.h"

@interface DetailMovieViewController : BaseViewController

@property (nonatomic, strong) DetailModel *model;
@property (nonatomic, strong) DetailMovieScrollView *detailSView;
@property (nonatomic, strong) MovieDetailModel *detailViewModel;

@end
