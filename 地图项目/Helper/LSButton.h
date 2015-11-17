//
//  LSButton.h
//  LSButton
//
//  Created by Yang on 2015/01/16.
//  Copyright (c) 2015 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface LSButton : UIButton

@property (nonatomic,strong) IBInspectable UIColor *buttonColor;
@property (nonatomic,strong) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGFloat radius;
@property (nonatomic) IBInspectable CGFloat angel;


+ (LSButton *)buttonWithFrame:(CGRect)frame
                         icon:(UIImage*)icon
                  buttonColor:(UIColor*)buttonColor
                  shadowColor:(UIColor*)shadowColor
                    tintColor:(UIColor*)tintColor
                       radius:(CGFloat)radius
                        angel:(CGFloat)angel
                      target:(id)tar
                      action:(SEL)sel;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com