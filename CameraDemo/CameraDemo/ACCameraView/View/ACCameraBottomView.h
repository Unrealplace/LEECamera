//
//  ACCameraBottomView.h
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACCameraBottomView;

@protocol ACCameraBottomViewDelegate <NSObject>

- (void)takePhoto:(ACCameraBottomView*)cameraBottomView;

- (void)showPhotoAlblum:(ACCameraBottomView*)cameraBottomView;

- (void)tintPhoto:(ACCameraBottomView*)cameraBottomView;

@end

@interface ACCameraBottomView : UIView

@property (nonatomic,weak)id <ACCameraBottomViewDelegate> delegate;

@end
