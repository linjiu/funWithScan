//
//  RecommandMainModel.m
//  音乐项目
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RecommandMainModel.h"

@implementation RecommandMainModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
