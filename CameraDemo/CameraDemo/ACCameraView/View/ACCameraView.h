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
 @param succsss 成功回调
 @param failed 失败回调
 */
- (void)switchCameraAction:(ACCameraView*)cameraView
                   Success:(void(^)(void))succsss
                    Failed:(void(^)(NSError*))failed;
/**
 开启拍照
 */
- (void)takePhotoAction:(ACCameraView*)cameraView;


@end


@interface ACCameraView : UIView


@property (nonatomic,weak)id <ACCameraViewDelegate> delegate ;

- (void)setupSession:(AVCaptureSession*)session;


@end
