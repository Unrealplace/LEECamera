//
//  ACCameraTopView.h
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACCameraTopView;

@protocol ACCameraTopViewDelegate <NSObject>

- (void)touchCancel:(ACCameraTopView*)cameraTopView;

- (void)switchCamera:(ACCameraTopView*)cameraTopView;

- (void)sharkStart:(ACCameraTopView*)cameraTopView;

@end
@interface ACCameraTopView : UIView

@property (nonatomic,weak)id <ACCameraTopViewDelegate> delegate;

@end
