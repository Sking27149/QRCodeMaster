//
//  ScanPageViewController.m
//  QRCodeMaster
//
//  Created by lanou on 16/5/28.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ScanPageViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanResultViewController.h"
@interface ScanPageViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, weak) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;

@end

@implementation ScanPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 创建捕捉绘画
     AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    //2 添加输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [self.session addInput:input];
    //3 添加输出源
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [self.session addOutput:output];
    //告诉元数据的类型是二维码类型
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //4 添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer = layer;
    layer.frame = self.view.frame;
    [self.view.layer addSublayer:layer];
    //开始扫描
    [self.session startRunning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session startRunning];
}

//扫秒到数据时执行的代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
          //1 获取扫描结果数据的最后一个元素
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSString *resultStr = object.stringValue;
//        //2 停止扫描
        [self.session stopRunning];
//        //3 移除图层
       // [self.layer removeFromSuperlayer];
        ScanResultViewController *resultVC = [[ScanResultViewController alloc] init];
        resultVC.resultStr = resultStr;
        [self.navigationController pushViewController:resultVC animated:YES];
    }
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
