//
//  ScanVController.h
//  地图项目
//
//  Created by 09 on 15/11/16.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QRUrlBlock)(NSString *url);
@interface ScanVController : UIViewController
/**
 *  拿到扫描结果
 */
@property (nonatomic, copy) QRUrlBlock qrUrlBlock;

@end
