//
//  ACCameraBaseViewController.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraBaseViewController.h"
#import "UIView+ACCameraFrame.h"

@interface ACCameraBaseViewController ()

@end

@implementation ACCameraBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

 }

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)dealloc{
    NSLog(@"%s",__func__);

}

- (ACCameraNaviView *)naviView {
    if (!_naviView) {
        _naviView = [[ACCameraNaviView alloc] initWithFrame:CGRectMake(0, 0, self.view.ca_width, 44)];
//        _naviView.hidden = YES;
        _naviView.delegate = self;
    }
    return _naviView;
}
- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType {
   
}

@end
