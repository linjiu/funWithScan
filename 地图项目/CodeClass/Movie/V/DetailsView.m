//
//  DetailsView.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//
#import "DetailsView.h"

@implementation DetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2-100 * kFitWidth, 0, 200 * kFitWidth, 40 * kFitHeight)];
        self.title.font = [UIFont systemFontOfSize:20 * kFitHeight];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor whiteColor];
        
        self.directors = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2-100 * kFitWidth, 40 * kFitHeight, 200 * kFitWidth, 40 * kFitHeight)];
        self.directors.font = [UIFont systemFontOfSize:17 * kFitHeight];
        self.directors.textAlignment = NSTextAlignmentCenter;
        self.directors.textColor = [UIColor whiteColor];
        
        self.casts = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2-100 * kFitWidth, 80 * kFitHeight, 200 * kFitWidth, 80 * kFitHeight)];
        self.casts.numberOfLines = 0;
        self.casts.font = [UIFont systemFontOfSize:17 * kFitHeight];
        self.casts.textAlignment = NSTextAlignmentCenter;
        self.casts.textColor = [UIColor whiteColor];
        
        self.pubdates = [[UILabel alloc] initWithFrame:CGRectMake(kWidth - 70 * kFitWidth, 0, 60 * kFitWidth, 80 * kFitHeight)];
        self.pubdates.numberOfLines = 0;
        self.pubdates.font = [UIFont systemFontOfSize:17 * kFitHeight];
        self.pubdates.textColor = [UIColor whiteColor];
        
        self.rating = [[UILabel alloc] initWithFrame:CGRectMake(kWidth - 70 * kFitWidth, 80 * kFitHeight, 60 * kFitWidth, 80 * kFitHeight)];
        self.rating.font = [UIFont systemFontOfSize:17 * kFitHeight];
        self.rating.textColor = [UIColor whiteColor];
        self.rating.numberOfLines = 0;
        
        self.genres = [[UILabel alloc] initWithFrame:CGRectMake(20 * kFitWidth, 20 * kFitHeight, 60 * kFitWidth, 120 * kFitHeight)];
        self.genres.font = [UIFont systemFontOfSize:17 * kFitHeight];
        self.genres.textColor = [UIColor whiteColor];
        self.genres.numberOfLines = 0;
        
        [self addSubview:self.backVisual];
        [self addSubview:self.title];
        [self addSubview:self.directors];
        [self addSubview:self.casts];
        [self addSubview:self.pubdates];
        [self addSubview:self.rating];
        [self addSubview:self.genres];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
