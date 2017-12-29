//
//  ACCameraView.h
//  CameraDemo
//
//  Created by LiYang on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "ACVideoPreView.h"

@class ACCameraView;

@protocol ACCameraViewDelegate <NSObject>

@optional


/**
 取消拍照
 */
- (void)cancelAction:(ACCameraView*)cameraView;

/**
 转换摄像头
 
 @param cameraView 摄像头视图
 
 */
- (void)switchCameraAction:(ACCameraView*)cameraView;

/**
 开启拍照
 */
- (void)takePhotoAction:(ACCameraView*)cameraView;

/**
 定点聚焦

 @param cameraView 摄像头视图
 @param point 聚焦点
 */
- (void)focusPointAction:(ACCameraView*)cameraView point:(CGPoint)point;

/**
 闪光灯效果

 @param cameraView 摄像头视图
 */
- (void)flashLightAction:(ACCameraView*)cameraView ;

@end


@interface ACCameraView : UIView


@property (nonatomic,weak)id <ACCameraViewDelegate> delegate ;

- (void)setupSession:(AVCaptureSession*)session;


@end
