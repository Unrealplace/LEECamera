//
//  ACFaceSDK.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>

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


/**
 设置app 类型
 */
@property (nonatomic, assign)ACFaceSDKAPPType appType;

/**
 设置当前的环境，开发或者是测试环境
 
  enviroType 配置环境，开发或者是测试
 */
@property (nonatomic, assign)ACFaceSDKEnviromentType enriroType;


/**
 解压素材
 */
- (void)compressionSerias;



@end
