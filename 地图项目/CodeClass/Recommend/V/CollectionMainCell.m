//
//  CollectionMainCell.m
//  音乐项目
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CollectionMainCell.h"

@implementation CollectionMainCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageV = [[UIImageView alloc]init];
        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:self.imageV];
        [self.contentView addSubview:self.label];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = self.bounds;
    self.label.frame = CGRectMake(0, self.imageV.bounds.size.height + 5, self.imageV.bounds.size.width, 20);

}
@end
