//
//  ACFaceSDK.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// app 的类型枚举
typedef enum :NSInteger {
    ACFaceSDKAPPTypeArtCamera = 0,
    ACFaceSDKAPPTypeManCamera,
    ACFaceSDKAPPTypeBeautyCamera
    
}ACFaceSDKAPPType;

typedef enum :NSInteger{
    ACFaceSDKEnviromentTypeDebug = 0,
    ACFaceSDKEnviromentTypeRelease
}ACFaceSDKEnviromentType;



@interface ACFaceSDK : NSObject

+ (instancetype)sharedSDK;


- (ACFaceSDKEnviromentType)enriroType;

/**
 设置当前app 的类型

 @param appType app 类型
 @param enviroType 当前的环境
 */
- (void)setAppType:(ACFaceSDKAPPType)appType andCurrentEnviroment:(ACFaceSDKEnviromentType)enviroType;
/**
 解压素材
 */
- (void)compressionSerias;

/**
 调用宿主的相机功能
 */

- (void)useCameraHandler:(void(^)(UIViewController * currentController))handler;


/**
 使用相册功能

 @param currentController 当前控制器
 */
- (void)usePhotoAlbumWithCurrentController:(UIViewController *)currentController;


/**
 确认是否使用图片

 @param currentController 当前控制器
 @param image 生成的image
 */
- (void)enterPhotoWithCurrentController:(UIViewController *)currentController
                               andImage:(UIImage *)image;

/**
 设置入口controller

 @param controller 入口controller
 */
- (void)setupEnterController:(UIViewController*)controller;



/**
 返回对应的相机控制器

 @param handler 处理回调
 */
- (void)backToCameraControllerHandler:(void(^)(UIViewController * currentController))handler;

/**
 设置相机控制器的父控制器

 @param controller 控制器
 */
- (void)setBackToCameraController:(UIViewController*)controller;

@end
