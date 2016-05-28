//
//  GenPageViewController.m
//  QRCodeMaster
//
//  Created by lanou on 16/5/28.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "GenPageViewController.h"
#import "GeneratorViewController.h"
@interface GenPageViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation GenPageViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate =self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"generator"]) {
        GeneratorViewController *generatorVC = segue.destinationViewController;
        generatorVC.str = self.textField.text;
    }
    
}


@end
