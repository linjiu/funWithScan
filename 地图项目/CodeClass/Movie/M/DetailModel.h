//
//  DetailModel.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

// 电影图片
@property (nonatomic, strong) NSDictionary *images;
// 电影名称
@property (nonatomic, strong) NSString *title;
// 电影语言
@property (nonatomic, strong) NSArray *languages;
// 电影收藏数
@property (nonatomic, strong) NSString *collect_count;
// 电影的国家
@property (nonatomic, strong) NSArray *countries;
// 电影上映时间
@property (nonatomic, strong) NSArray *pubdates;
// 电影持续时间
@property (nonatomic, strong) NSArray *durations;
// 电影标签
@property (nonatomic, strong) NSArray *tags;
//  电影种类
@property (nonatomic ,strong) NSArray *genres;
// 电影预告片
@property (nonatomic, strong) NSArray *trailers;
// 电影预告片mp4
@property (nonatomic, strong) NSArray *trailer_urls;
// 演员阵容
@property (nonatomic, strong) NSArray *casts;
// 电影导演
@property (nonatomic, strong) NSArray *directors;
// 电影简介
@property (nonatomic, strong) NSString *summary;
//影评
@property (nonatomic, strong) NSArray *popular_comments;

// 用字典 给model 赋值
+ (DetailModel *)setJsonWithDictionary:(NSDictionary *)dictionary;

@end
