//
//  ACCameraNaviView.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    ACCameraNaviViewTouchTypeLeft = 100, // 表示左边的点击
    ACCameraNaviViewTouchTypeCenter ,
    ACCameraNaviViewTouchTypeRight
}ACCameraNaviViewTouchType;

@protocol ACCameraNaviViewDelegate <NSObject>

- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType;

@end

@interface ACCameraNaviView : UIView

@property (nonatomic, weak)id <ACCameraNaviViewDelegate> delegate;


@end
