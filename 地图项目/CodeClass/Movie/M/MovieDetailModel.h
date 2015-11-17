//
//  WillReleasedModel.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailModel : NSObject

@property (nonatomic, strong) NSString *ID;
//上映时间
@property (nonatomic, strong) NSString *pubdate;
@property (nonatomic, strong) NSString *mainland_pubdate;
//电影名
@property (nonatomic, strong) NSString *title;
//原名
@property (nonatomic, strong) NSString *original_title;
//电影图片
@property (nonatomic, strong) NSDictionary *images;

@property (nonatomic, strong) NSNumber *wish;
@property (nonatomic, strong) NSNumber *collection;
@property (nonatomic, strong) NSNumber *collect_count;

+ (MovieDetailModel *)setJsonWithDictionary:(NSDictionary *)dictionary;

@end
