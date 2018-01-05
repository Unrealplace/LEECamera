//
//  ACCameraBaseViewController.h
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACCameraNaviView.h"

@interface ACCameraBaseViewController : UIViewController <ACCameraNaviViewDelegate>
@property (nonatomic, strong)ACCameraNaviView * naviView;

@end
