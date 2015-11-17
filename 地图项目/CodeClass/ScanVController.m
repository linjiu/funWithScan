//
//  ScanVController.m
//  地图项目
//
//  Created by 09 on 15/11/16.
//  Copyright © 2015年 yifan. All rights reserved.
//

#import "ScanVController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "QRUtil.h"
@interface ScanVController ()<AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) QRView *qrView;

@property (nonatomic, assign) NSInteger i;

@end

@implementation ScanVController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultConfig];       //初始化配置,主要是二维码的配置
    [self configUI];
    [self updateLayout];
}



- (void)defaultConfig {
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    AVCaptureConnection *outputConnection = [_output connectionWithMediaType:AVMediaTypeVideo];
    outputConnection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    }
    
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResize;
    _preview.frame =[QRUtil screenBounds];
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    _preview.connection.videoOrientation = [QRUtil videoOrientationFromCurrentDeviceOrientation];
    
    [_session startRunning];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (![_session isRunning]) {
        
        [self defaultConfig];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_preview removeFromSuperlayer];
    [_session stopRunning];
}

- (void)configUI {
    
    [self.view addSubview:self.qrView];
    [self.view addSubview:self.backBtn];
    
}

- (void)updateLayout {
    
    
    
    _qrView.center = CGPointMake([QRUtil screenBounds].size.width / 2, [QRUtil screenBounds].size.height / 2);
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - self.qrView.transparentArea.width) / 2,
                                 (screenHeight - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);
    
    [_output setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
}

- (void)pop:(UIButton *)button {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark QRViewDelegate
-(void)scanTypeConfig:(QRItem *)item {
    
    self.i = item.type;
    /**
     *  0为二维码 1为条形码(二维码也可)
     */
    if (item.type == QRItemTypeQRCode) {
        
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        }
        
    } else if (item.type == QRItemTypeOther) {
        
        if ([_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            _output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                            AVMetadataObjectTypeCode128Code,
                                            AVMetadataObjectTypeQRCode];
        }
        
    }
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    // NSLog(@" %@",stringValue);
    
    if (self.qrUrlBlock) {
        self.qrUrlBlock(stringValue);
    }
    
    if (self.i == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"二维码结果" message:stringValue preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *freshAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"转到链接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:stringValue];
            [[ UIApplication sharedApplication]openURL:url];
        }];
        [alertC addAction:cancelAction];
        [alertC addAction:freshAction];
        //回到主界面方法
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"条形码结果" message:stringValue preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *freshAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:freshAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
    
}


#pragma mark - Getter and Setter
-(UIButton *)backBtn {
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(20, 20, 50, 50);
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}


-(QRView *)qrView {
    
    if (!_qrView) {
        
        CGRect screenRect = [QRUtil screenBounds];
        _qrView = [[QRView alloc] initWithFrame:screenRect];
        _qrView.transparentArea = CGSizeMake(200, 200);
        
        _qrView.backgroundColor = [UIColor clearColor];
        _qrView.delegate = self;
    }
    return _qrView;
}

@end
