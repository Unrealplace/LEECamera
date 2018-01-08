//
//  CIImage+ACQRImage.h
//  01-生成二维码
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 xiaomage. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface CIImage (ACQRImage)

 

+ (UIImage*)generateQRimageWithMessageUrl:(NSString*)info andSize:(CGFloat)size;

@end
