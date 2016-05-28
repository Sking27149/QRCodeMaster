//
//  ScanResultViewController.m
//  QRCodeMaster
//
//  Created by lanou on 16/5/28.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultLabel.text = self.resultStr;
}


- (IBAction)goBtn:(id)sender {

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        NSURL *url = [NSURL URLWithString:self.resultStr];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:self.webView];
    [self.view bringSubviewToFront:self.webView];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error);
    if (error.code == -999) {
        return;
    }
    [self.webView removeFromSuperview];
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
