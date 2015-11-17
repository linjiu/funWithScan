//
//  WillReleasedModel.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (MovieDetailModel *)setJsonWithDictionary:(NSDictionary *)dictionary
{
    MovieDetailModel *model = [[MovieDetailModel alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    model.ID = dictionary[@"id"];
    return model;
}

@end
