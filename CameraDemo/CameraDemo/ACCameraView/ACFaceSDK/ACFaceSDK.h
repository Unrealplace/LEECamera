//
//  ACFaceSDK.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACCameraHeader.h"
#import "ACFaceShareModel.h"

@interface ACFaceSDK : NSObject

+ (instancetype)sharedSDK;

/**
 初始化SDK 并配置要使用的 相册和相机
 
 @param appType app 的类型
 @param enviroType 当前开发的环境
 @param photoClass photo 控制器
 @param cameraClass camera 控制器
 */
- (void)setAppType:(ACFaceSDKAPPType)appType
        andCurrentEnviroment:(ACFaceSDKEnviromentType)enviroType
        andRegisterPhotoController:(Class)photoClass
        andCameraController:(Class)cameraClass;


/**
 获取当前的相册控制器
 
 @return 相册控制器
 */
- (Class)currentPhotoCotroller;

/**
 获取当前的相机控制器
 
 @return 相机控制器
 */
- (Class)currentCameraCotroller;


/**
 获取当前的开发的环境

 @return 对应的项目开发环境
 */
- (ACFaceSDKEnviromentType)enriroType;

/**
 更新当前环境
 
 @param enrioType 当前的环境
 */
- (void)updateEnviroMentType:(ACFaceSDKEnviromentType)enrioType;



/**
 调用宿主的相机功能
 
 @param superClass 相机的父控制器
 */
- (void)enterToCamera:(UIViewController*)superClass;



/**
 返回相机界面

 @param superClass 相机的父控制器
 */
- (void)backToCamera:(UIViewController *)superClass;



/**
 使用宿主的相册功能,对应的 app 的 相册按钮点击时候的触发事件

 @param superClass 相册的父控制器
 */
- (void)usePhotoAlbum:(UIViewController *)superClass;

/**
 返回到相册, 对应的 app 的 相册按钮点击时候的触发事件

 @param superClass 相册的父控制器
 */
- (void)backToPhotoAlbum:(UIViewController *)superClass;


/**
 确认是否使用图片
 
 @param currentController 当前控制器
 @param image 生成的image
 */
- (void)enterPhotoWithCurrentController:(UIViewController *)currentController
                               andImage:(UIImage *)image;

/**
 显示提示，用户点击小灯泡或者首次登陆时候弹框提示
 
 @param handler 提示回调
 */
- (void)showTintAlertControllerHandler:(void(^)(UIViewController * currentController))handler;

/**
 配置弹框的父控制器
 
 @param controller 弹框的父控制器
 */
- (void)setupTintAlertController:(UIViewController*)controller;

/**
 调用宿主的分享功能
 
 @param handler 分享回调
 */
- (void)shareViewClick:(void(^)(UIViewController * currentController,ACFaceShareModel * model,ACFaceSDKShareType type))handler;

/**
 设置分享
 
 @param controller 控制器
 @param model 分享的模型
 @param shareType 分享的种类
 */
- (void)setShareViewWith:(UIViewController *)controller andShareModel:(ACFaceShareModel*)model andShareType:(ACFaceSDKShareType)shareType;


/**
 调用宿主的网络状态
 
 @param handler 监控回调
 */
- (void)monitorNetState:(ACFaceSDKNetStateType(^)(UIViewController * currentController))handler;


/**
 配置网络检测

 @param controller 父控制器
 @return 当前网络状态
 */
- (ACFaceSDKNetStateType)setNetState:(UIViewController*)controller;


/**
 判断是否是第一次使用
 
 @return bool
 */
- (BOOL)isFirstLoad;


/**
 解压素材
 */
- (void)compressionSerias;


@end
