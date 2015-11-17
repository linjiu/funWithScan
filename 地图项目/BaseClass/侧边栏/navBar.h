//
//  navBar.h
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#define RGB_COLOR(_STR_) ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0])

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define KNAVBARHEIGHT  64

#import <UIKit/UIKit.h>

@interface navBar : UIView

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIViewController * VC;
@property (nonatomic, strong)UIButton *backBtn;

+ (CGFloat)barWidth;
+ (CGFloat)barHeight;

- (void)setBackBtn;
- (void)setLeftNavButton:(UIButton *)butt;
- (void)setRightNavButton:(UIButton *)butt;
- (void)setNavTitle:(NSString *)strTitle;
+ (UIButton *)createNavButtonByImageNormal:(NSString *)strNormal imageSelected:(NSString *)strSelected target:(id)target action:(SEL)action;
+ (UIButton *)createNavButttonByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

@end
