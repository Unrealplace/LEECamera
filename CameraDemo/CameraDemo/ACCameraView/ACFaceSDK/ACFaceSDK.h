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

@interface ACFaceSDK : NSObject

+ (instancetype)sharedSDK;


/**
 设置app 类型
 */
@property (nonatomic, assign)ACFaceSDKAPPType appType;



@end
