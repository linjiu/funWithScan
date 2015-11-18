//
//  MainViewController.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "MainViewController.h"
#import "LSButton.h"

#import "LocateVController.h"
#import "UIColor+AddColor.h"

#import "DKCircleButton.h"
#import "ScanVController.h"

#import <AVFoundation/AVFoundation.h>
@interface MainViewController ()
{
    BOOL buttonState;
    DKCircleButton *button1;
}

@property (nonatomic, strong) LSButton *locateB;
@property (nonatomic, strong) LSButton *erweimaB;
@property (nonatomic, strong) LSButton *luyinB;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     标题
     */
    UILabel *label = [[UILabel alloc]initWithFrame:(CGRectMake(kWidth / 2 - 125, 40, 250, 40))];
    label.font = [UIFont fontWithName:@"Zapfino" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"HomePage";
    [self.view addSubview:label];
    
    /**
     扫码
     */
    UILabel *text = [[UILabel alloc]initWithFrame:(CGRectMake(kWidth / 2 - 100, kHeight / 4, 200, 40))];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = @"点击即可扫码";
    text.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:text];
    
    button1 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
    
    button1.center = CGPointMake(kWidth / 2, kHeight / 2 - 50);
    button1.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
    
    [button1 addTarget:self action:@selector(erweima) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"模糊背景"]];
    
   
}



-(void)erweima
{
    if ([self validateCamera]) {
        
        [self showSViewController];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头不可用或没有摄像头 ~ 请前往开启 ~ 更改后程序将自动刷新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
- (BOOL)validateCamera {
    
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] && authStatus != AVAuthorizationStatusRestricted && authStatus != AVAuthorizationStatusDenied;
    
    
}

- (void)showSViewController {
    
    ScanVController *vc = [[ScanVController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
