//
//  UIImage+ACWaterImage.h
//  01-生成二维码
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ACWaterImage)
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;
+ (instancetype)waterMarkWithImageName:(UIImage *)backgroundImage andMarkImageName:(UIImage *)markName;
@end
