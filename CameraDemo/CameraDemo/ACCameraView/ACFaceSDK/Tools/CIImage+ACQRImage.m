//
//  CIImage+ACQRImage.m
//  01-生成二维码
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 xiaomage. All rights reserved.
//

#import "CIImage+ACQRImage.h"

@implementation CIImage (ACQRImage)


+ (UIImage*)generateQRimageWithMessageUrl:(NSString *)info andSize:(CGFloat)size{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3.设置数据
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];

    return [outputImage createQRimageSize:size];
    
    
}
 
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param size  图片宽度
 */

- (UIImage *)createQRimageSize:(CGFloat)size {
    
    
    CGRect  extent = CGRectIntegral(self.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:self fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (UIImage *)createNonInterpolatedWithSize:(CGFloat)size
{
    
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    NSString *info = @"http://www.520it.com";
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    CGRect extent = CGRectIntegral(self.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:self fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
