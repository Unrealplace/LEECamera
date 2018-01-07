//
//  ACFaceModel.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACBaseModel.h"

@interface ACFaceModel : ACBaseModel

@property (nonatomic, copy)NSString * name;


/**
 用于区别的id 号
 */
@property (nonatomic, assign)NSInteger faceId;


/**
 默认玩法
 */
@property (nonatomic, assign) BOOL    isDefautSet;

/**
 是否下载过
 */
@property (nonatomic, assign) BOOL    isDownload;

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
 当前版本信息
 */
@property (nonatomic, copy) NSString    *versionNum;

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
