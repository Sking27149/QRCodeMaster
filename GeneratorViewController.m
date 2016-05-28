//
//  GeneratorViewController.m
//  QRCodeMaster
//
//  Created by lanou on 16/5/28.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "GeneratorViewController.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+Clear.h"

@interface GeneratorViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GeneratorViewController

- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2 恢复默认
    [filter setDefaults];
    //3 给过滤器添加数据（KVC）
    NSData *data = [self.str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    //4 获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    //5 显示二维码
    self.imageView.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
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
