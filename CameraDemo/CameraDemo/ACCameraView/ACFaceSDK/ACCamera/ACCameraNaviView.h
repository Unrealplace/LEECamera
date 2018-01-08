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
@class ACCameraNaviView;
@protocol ACCameraNaviViewDelegate <NSObject>

- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType andCameraNaviView:(ACCameraNaviView*)naviView;

@end

@interface ACCameraNaviView : UIView

@property (nonatomic, weak)id <ACCameraNaviViewDelegate> delegate;



- (void)hiddenLeftBtn:(BOOL)leftHidden centerBtnHidden:(BOOL)centerHidden rightBtnHidden:(BOOL)rightBtnHidden;

@end
