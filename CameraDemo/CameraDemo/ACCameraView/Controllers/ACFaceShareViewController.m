//
//  ACFaceShareViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceShareViewController.h"

@interface ACFaceShareViewController ()

@end

@implementation ACFaceShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.naviView];

}
- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType {
    if (touchType == ACCameraNaviViewTouchTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
