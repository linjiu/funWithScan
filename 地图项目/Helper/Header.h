//
//  Header.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#ifndef Header_h
#define Header_h
/**
 *  布局用
 */
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kBounds [UIScreen mainScreen].bounds

#define kFitWidth kWidth/375.0
#define kFitHeight kHeight/667.0
/**
 *  直接引了先
 */
#import "UIImageView+WebCache.h"
#import "BlurImageView.h"
#import "SVProgressHUD.h"
#import "LORequestManger.h"



//首页
#define kHotUrl @"http://api.douban.com/v2/movie/in_theaters?count=100&udid=b6dcdfae53dd3e58ba9610bdf8e2e3cc40e3134b&start=0&client=s%3Amobile%7Cy%3AAndroid+4.4.2%7Co%3AKHHCNBF5.0%7Cf%3A70%7Cv%3A2.7.4%7Cm%3AWanDouJia_Parter%7Cd%3A865983026114430%7Ce%3AXiaomi+HM2014501&apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E4%B8%8A%E6%B5%B7"
//详情
#define kDetailMovieUrl @"http://api.douban.com/v2/movie/subject/电影ID?udid=b6dcdfae53dd3e58ba9610bdf8e2e3cc40e3134b&client=s%3Amobile%7Cy%3AAndroid+4.4.2%7Co%3AKHHCNBF5.0%7Cf%3A70%7Cv%3A2.7.4%7Cm%3AWanDouJia_Parter%7Cd%3A865983026114430%7Ce%3AXiaomi+HM2014501%7Css%3A720x1280&apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC"




#endif /* Header_h */
