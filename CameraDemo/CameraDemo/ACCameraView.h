//
//  ACCameraView.h
//  CameraDemo
//
//  Created by LiYang on 2017/12/27.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "ACVideoPreView.h"

@interface ACCameraView : UIView


/**
 取消拍照
 */
- (void)cancelAction;


/**
 开启拍照
 */
- (void)takePhotoAction:(ACCameraView*)cameraView;


- (void)setupSession:(AVCaptureSession*)session;


@end
