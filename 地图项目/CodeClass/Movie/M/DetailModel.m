//
//  DetailModel.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//
#import "DetailModel.h"

@implementation DetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

// 用字典 给model 赋值
+ (DetailModel *)setJsonWithDictionary:(NSDictionary *)dictionary
{
    DetailModel *model = [[DetailModel alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}
@end
