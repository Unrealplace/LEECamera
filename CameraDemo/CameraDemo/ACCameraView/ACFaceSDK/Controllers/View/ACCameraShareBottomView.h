//
//  ACCameraShareBottomView.h
//  CameraDemo
//
//  Created by LiYang on 2018/1/7.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCameraHeader.h"

@class ACCameraShareBottomView;

@protocol ACCameraShareViewDelegate <NSObject>

- (void)shareViewClick:(ACCameraShareBottomView*) shareView andShareType:(ACFaceSDKShareType) shareType;

@end

@interface ACCameraShareBottomView : UIView

@property (nonatomic, weak) id     <ACCameraShareViewDelegate> delegate ;

@end
