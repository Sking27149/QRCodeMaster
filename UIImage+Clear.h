//
//  UIImage+Clear.h
//  QRCodeMaster
//
//  Created by lanou on 16/5/28.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Clear)

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;


@end
