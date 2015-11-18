//
//  DetailMovieScrollView.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//
#import "DetailMovieScrollView.h"
#import "UIColor+AddColor.h"
@implementation DetailMovieScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addView];
        self.bounces = NO;
    }
    return self;
}

// 添加视图
- (void)addView {
    self.moviePic = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
    
    // 电影名
    self.movieName = [[UILabel alloc] initWithFrame:CGRectMake(140 * kFitWidth, 10 * kFitHeight, 200 * kFitWidth, 30 * kFitHeight)];
    self.movieName.font = [UIFont boldSystemFontOfSize:20.0 * kFitHeight];
    self.movieName.textColor = [UIColor jinjuse];
    [self addSubview:self.movieName];
    
    // 电影类型
    self.movieGenres = [[UILabel alloc] initWithFrame:CGRectMake(140 * kFitWidth, 50 * kFitHeight, 200 * kFitWidth, 20 * kFitHeight)];
    self.movieGenres.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    self.movieGenres.textColor = [UIColor whiteColor];
    [self addSubview:self.movieGenres];
    
    // 电影的国家、语言、时长
    self.movieCountriesLanguageDuration = [[UILabel alloc] initWithFrame:CGRectMake(140 * kFitWidth, 80 * kFitHeight, 200 * kFitWidth, 20 * kFitHeight)];
    self.movieCountriesLanguageDuration.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    self.movieCountriesLanguageDuration.textColor = [UIColor whiteColor];
    [self addSubview:self.movieCountriesLanguageDuration];
    
    // 电影的上映时间及地区
    self.moviePubdates = [[UILabel alloc] initWithFrame:CGRectMake(140 * kFitWidth, 110 * kFitHeight, 200 * kFitWidth, 20 * kFitHeight)];
    self.moviePubdates.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    self.moviePubdates.textColor = [UIColor whiteColor];
    [self addSubview:self.moviePubdates];
    
    // 收藏人数
    self.movieCollectcount = [[UILabel alloc] initWithFrame:CGRectMake(140 * kFitWidth, 140 * kFitHeight, 100 * kFitWidth, 30 * kFitHeight)];
    self.movieCollectcount.textColor = [UIColor jinjuse];
    self.movieCollectcount.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    [self addSubview:self.movieCollectcount];
    
    // 简介
    self.movieSummary = [[UILabel alloc] initWithFrame:CGRectMake(10 * kFitWidth, 180 * kFitHeight, kWidth - (20 * kFitWidth), 80 * kFitHeight)];
    self.movieSummary.textColor = [UIColor whiteColor];
    self.movieSummary.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    self.movieSummary.numberOfLines = 0;
    self.movieSummary.userInteractionEnabled = YES;
    self.movieSummary.tag = 100;
    [self addSubview:self.movieSummary];
    
    
}

// 用model设置详情界面
- (void)setDetailViewWithDetailModel:(DetailModel *)model {
    // 电影图片
    NSDictionary *images = model.images;
    NSString *largeImage = images[@"large"];
    [self.moviePic sd_setImageWithURL:[NSURL URLWithString:largeImage]];
    // 电影名
    self.movieName.text = model.title;
    // 电影类型
    NSArray *genres = model.genres;
    NSString *genresStr;
    for (int i = 0; i < genres.count; i++) {
        if (genresStr == nil) {
            genresStr = genres[0];
        }else {
            genresStr = [NSString stringWithFormat:@"%@ %@",genresStr,genres[i]];
        }
    }
    self.movieGenres.text = genresStr;
    // 电影的国家、语言、时长
    NSString *countriesStr = model.countries[0];
    NSString *durationStr;
    if (model.durations.count != 0) {
        durationStr = model.durations[0];
    }else {
        durationStr = @"不详";
    }
    NSString *languageStr;
    for (int j = 0; j < model.languages.count; j++) {
        if (languageStr == nil) {
            languageStr = model.languages[0];
        }else {
            languageStr = [NSString stringWithFormat:@"%@ %@",languageStr,model.languages[j]];
        }
    }
    self.movieCountriesLanguageDuration.text = [NSString stringWithFormat:@"%@/%@/%@",countriesStr,languageStr,durationStr];
    // 放映时间和地区
    if (model.pubdates.count) {
        self.moviePubdates.text = [NSString stringWithFormat:@"%@上映",model.pubdates[0]];
    }
    // 电影收藏数
    self.movieCollectcount.text = [NSString stringWithFormat:@"%@人收藏",model.collect_count];
    // 电影简介
    self.movieSummary.text = [model.summary substringToIndex:60];
    CGRect frame = [self.movieSummary.text boundingRectWithSize:CGSizeMake(kWidth - (20 * kFitWidth), 999) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0 * kFitHeight] forKey:NSFontAttributeName] context:nil];
    self.movieSummary.frame = CGRectMake(10 * kFitWidth, 180 * kFitHeight, kWidth - (20 * kFitWidth), frame.size.height);
    
    // 导演和演员的scrollView
    self.castsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.movieSummary.frame.origin.y + self.movieSummary.frame.size.height + 20 * kFitHeight, kWidth, 160 * kFitHeight)];
    self.castsScrollView.contentSize = CGSizeMake(90 * kFitWidth * (model.casts.count + 1) + 10 * kFitWidth, 150 * kFitHeight);
    self.castsScrollView.showsHorizontalScrollIndicator = NO;
    self.castsScrollView.bounces = NO;
    [self addSubview:self.castsScrollView];
    
    // 导演的图片标题
    UILabel *directorsTitle = [[UILabel alloc] initWithFrame:CGRectMake(10 * kFitWidth, 0, 80 * kFitWidth, 20 * kFitHeight)];
    directorsTitle.text = @"导演";
    directorsTitle.textColor = [UIColor jinjuse];
    directorsTitle.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
//    directorsTitle.textAlignment = NSTextAlignmentCenter;
    [self.castsScrollView addSubview:directorsTitle];
    // 导演
    if (model.directors.count) {
        NSDictionary *directorsDic = model.directors[0];
        NSDictionary *largePic = directorsDic[@"avatars"];
        self.movieDirectors = [[UIImageView alloc] initWithFrame:CGRectMake(10 * kFitWidth, 20 * kFitHeight, 80 * kFitWidth, 100 * kFitHeight)];
        if (![largePic isEqual:[NSNull null]]) {
            [self.movieDirectors sd_setImageWithURL:[NSURL URLWithString:largePic[@"large"]] placeholderImage:[UIImage imageNamed:@"16"]];
        } else {
            self.movieDirectors.image = [UIImage imageNamed:@"16"];
        }
        self.movieDirectors.tag = 200;
        [self.castsScrollView addSubview:self.movieDirectors];
        
        // 导演名字
        UILabel *nameLabelDir = [[UILabel alloc] initWithFrame:CGRectMake(self.movieDirectors.frame.origin.x, self.movieDirectors.frame.origin.y + self.movieDirectors.frame.size.height, self.movieDirectors.frame.size.width, 20 * kFitHeight)];
        nameLabelDir.text = directorsDic[@"name"];
        nameLabelDir.textColor = [UIColor whiteColor];
        nameLabelDir.textAlignment = NSTextAlignmentCenter;
        nameLabelDir.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
        [self.castsScrollView addSubview:nameLabelDir];
        UILabel *name_enLabelDir = [[UILabel alloc] initWithFrame:CGRectMake(self.movieDirectors.frame.origin.x, self.movieDirectors.frame.origin.y + self.movieDirectors.frame.size.height + 20 * kFitHeight, self.movieDirectors.frame.size.width, 20 * kFitHeight)];
        name_enLabelDir.text = directorsDic[@"name_en"];
        name_enLabelDir.textColor = [UIColor whiteColor];
        name_enLabelDir.textAlignment = NSTextAlignmentCenter;
        name_enLabelDir.font = [UIFont systemFontOfSize:13.0 * kFitHeight];
        [self.castsScrollView addSubview:name_enLabelDir];
        
    }
     // 演员图片标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * kFitWidth, 0, 80 * kFitWidth, 20 * kFitHeight)];
    titleLabel.text = @"演员";
    titleLabel.textColor = [UIColor jinjuse];
    titleLabel.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
    [self.castsScrollView addSubview:titleLabel];

    // 演员
    NSArray *castsArr = model.casts;
    for (int b = 0; b < model.casts.count; b++) {
        NSDictionary *castsDic = castsArr[b];
        NSDictionary *avatarsDic = castsDic[@"avatars"];
        self.movieCasts = [[UIImageView alloc] initWithFrame:CGRectMake(b * (90 * kFitWidth) + 100 * kFitWidth, 20 * kFitHeight, 80 * kFitWidth, 100 * kFitHeight)];
        if (![avatarsDic isEqual:[NSNull null]]) {
            [self.movieCasts sd_setImageWithURL:[NSURL URLWithString:avatarsDic[@"large"]]];
        } else {
            self.movieCasts.image = [UIImage imageNamed:@"16"];
        }
        self.movieCasts.tag = 300 + b;
        [self.castsScrollView addSubview:self.movieCasts];
        
        // 演员名字
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.movieCasts.frame.origin.x, self.movieCasts.frame.origin.y + self.movieCasts.frame.size.height, self.movieCasts.frame.size.width, 20 * kFitHeight)];
        nameLabel.text = castsDic[@"name"];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:15.0 * kFitHeight];
        [self.castsScrollView addSubview:nameLabel];
        UILabel *name_enLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.movieCasts.frame.origin.x, self.movieCasts.frame.origin.y + self.movieCasts.frame.size.height + 20 * kFitHeight, self.movieCasts.frame.size.width, 20 * kFitHeight)];
        name_enLabel.text = castsDic[@"name_en"];
        name_enLabel.textColor = [UIColor whiteColor];
        name_enLabel.textAlignment = NSTextAlignmentCenter;
        name_enLabel.font = [UIFont systemFontOfSize:13.0 * kFitHeight];
        [self.castsScrollView addSubview:name_enLabel];
    }
    
    // 放简介下面所有控件的view
    self.allView = [[UIView alloc] init];
    
    // 预告片标题
    UILabel *trailerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * kFitWidth, 0, 100 * kFitWidth, 40 * kFitHeight)];
    trailerLabel.text = @"预告片";
    trailerLabel.textColor = [UIColor jinjuse];
    trailerLabel.font = [UIFont boldSystemFontOfSize:18.0 * kFitHeight];
    [self.allView addSubview:trailerLabel];
    
    // 预告片图片button
    NSArray *trailersArr = model.trailers;
    for (int m = 0; m < trailersArr.count; m++) {
        NSDictionary *dic = trailersArr[m];
        self.movieTrailerPic = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _movieTrailerPic.layer.masksToBounds = YES;
        self.movieTrailerPic.tag = 1000 + m;
        self.movieTrailerPic.frame = CGRectMake(20 * kFitWidth, trailerLabel.frame.origin.y + 50 * kFitHeight + 250 * kFitHeight * m, kWidth - 40 * kFitWidth, 200 * kFitHeight);
        NSURL *url = [NSURL URLWithString:dic[@"medium"]];
        NSData *picData = [NSData dataWithContentsOfURL:url];
        [self.movieTrailerPic setImage:[UIImage imageWithData:picData] forState:(UIControlStateNormal)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.movieTrailerPic.bounds.size.width / 2- 50 * kFitWidth, self.movieTrailerPic.bounds.size.height / 2 - 50 * kFitWidth, 60 * kFitWidth, 60 * kFitWidth)];
        imageView.image = [UIImage imageNamed:@"player_play@2x"];
        [self.movieTrailerPic addSubview:imageView];
        [self.allView addSubview:self.movieTrailerPic];
        
        self.movieTrailerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10 * kFitWidth, self.movieTrailerPic.frame.origin.y + self.movieTrailerPic.frame.size.height, kWidth - 20 * kFitWidth, 30 * kFitHeight)];
        self.movieTrailerTitle.text = dic[@"title"];
        self.movieTrailerTitle.textAlignment = NSTextAlignmentCenter;
        self.movieTrailerTitle.textColor = [UIColor whiteColor];
        [self.allView addSubview:self.movieTrailerTitle];
    }
    // 设置所有控件view的frame
    self.allView.frame = CGRectMake(0, self.castsScrollView.frame.origin.y + self.castsScrollView.frame.size.height + 20 * kFitHeight, kWidth, self.movieTrailerTitle.frame.origin.y + self.movieTrailerTitle.frame.size.height);
    [self addSubview:self.allView];
    // 设置详情界面scrollView的偏移范围
    self.contentSize = CGSizeMake(kWidth, self.allView.frame.origin.y + self.allView.frame.size.height);
    
}

// 给简介的label添加一个手势
- (void)addTapLabelWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.movieSummary addGestureRecognizer:tapGesture];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
