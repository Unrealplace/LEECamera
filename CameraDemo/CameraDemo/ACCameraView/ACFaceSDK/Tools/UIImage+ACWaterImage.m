//
//  UIImage+ACWaterImage.m
//  01-生成二维码
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 xiaomage. All rights reserved.
//

#import "UIImage+ACWaterImage.h"

@implementation UIImage (ACWaterImage)
// 给图片添加文字水印：
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


+ (instancetype)waterMarkWithImageName:(UIImage *)backgroundImage andMarkImageName:(UIImage *)markName{
    
 
    UIGraphicsBeginImageContextWithOptions(backgroundImage.size, NO, 0.0);
    [backgroundImage drawInRect:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    
    CGFloat scale = 0.3;
    CGFloat margin = 5;
    CGFloat waterW = markName.size.width  * scale;
    CGFloat waterH = markName.size.height * scale;
    CGFloat waterX = backgroundImage.size.width - waterW - margin;
    CGFloat waterY = backgroundImage.size.height - waterH - margin;
    
    [markName drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
