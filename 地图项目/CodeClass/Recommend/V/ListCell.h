//
//  ListCell.h
//  音乐项目
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;

@end

@interface ListCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UILabel *songLabel;
@property(nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, assign) BOOL isPlay;

@property (nonatomic, strong) NSString *url;

@property(nonatomic, strong) UIButton *button;

@property(assign,nonatomic)id<myTabVdelegate>delegate;

@end
