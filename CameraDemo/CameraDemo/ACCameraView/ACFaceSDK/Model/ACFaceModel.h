//
//  ACFaceModel.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACFaceModel : NSObject

@property (nonatomic, copy)NSString * name;

@property (nonatomic, assign)NSInteger faceID;


/**
 显示用的icon
 */
@property (nonatomic, copy)NSString * iconImg;

/**
 展示变形用的图片
 */
@property (nonatomic, copy)NSString * showImg;

/**
 存储的文件夹名称
 */
@property (nonatomic, copy)NSString * fileName;


/**
 显示用的iconImage

 @return iconImage
 */
- (UIImage*)iconImage;

/**
 变形用的显示图片

 @return 变形用的显示图片
 */
- (UIImage*)showImage;


@end
