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

@property (strong, nonatomic) UIAlertController *alertVC;

@end

@implementation GeneratorViewController

//保存二维码图片到本地
- (IBAction)tap:(id)sender {
    //高斯模糊
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = self.view.frame;
    [self.view addSubview:effectView];
    
    //提醒视图
    self.alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"保存到相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, nil, nil);
        [effectView removeFromSuperview];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [effectView removeFromSuperview];
    }];
    [self.alertVC addAction:confirmAction];
    [self.alertVC addAction:cancelAction];
    [self presentViewController:self.alertVC animated:YES completion:nil];
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.alertVC dismissViewControllerAnimated:YES completion:nil];
//}

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
