//
//  ListCell.m
//  音乐项目
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.songLabel = [[UILabel alloc]init];
        [self addSubview:self.songLabel];
        
        self.authorLabel = [[UILabel alloc]init];
        self.authorLabel.font = [UIFont systemFontOfSize:13];
        self.authorLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.authorLabel];
        
        self.button = [[UIButton alloc]init];
        [self.button setImage:[UIImage imageNamed:@"player_play"] forState:(UIControlStateNormal)];
        [self addSubview:self.button];
        [self.button addTarget:self action:@selector(test:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return self;
}
-(void)layoutSubviews
{
    self.songLabel.frame = CGRectMake(20, 0, self.bounds.size.width / 2, self.bounds.size.height / 3 * 2);
    
    self.authorLabel.frame = CGRectMake(20, self.songLabel.bounds.size.height, self.bounds.size.width / 2, self.bounds.size.height / 3);
    
    self.button.frame = CGRectMake(self.bounds.size.width/ 10 * 8.5, 10, 30, 30);
}

-(void)test:(UIButton *)button
{
    [self.delegate myTabVClick:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
