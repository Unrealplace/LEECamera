//
//  ACPhotoToll.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACAsset.h"

typedef void(^ACPhotoCallBack)(ACAsset *_Nullable asset);

typedef void(^ACSaveImageHandler)(BOOL isCompeleted,NSString * _Nullable status,NSDictionary * _Nullable imgInfo);


@interface ACPhotoTool : NSObject

/**
 获取最新的一张图片

 @param callBack 成功回调
 */
+ (void)latestAsset:(ACPhotoCallBack _Nullable)callBack;

/**
 保存一张图片到相册

 @param image 图片
 @param saveImageHandler 保存成功的回调
 */
+ (void)saveImage:(UIImage *_Nullable)image compeleted:(ACSaveImageHandler _Nullable )saveImageHandler;

@end



