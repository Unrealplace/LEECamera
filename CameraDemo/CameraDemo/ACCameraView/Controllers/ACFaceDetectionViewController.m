//
//  ACFaceDetectionViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2017/12/28.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACFaceDetectionViewController.h"
#import "ACCameraViewController.h"
#import "ACPhotoPickerController.h"
#import "UIView+ACCameraFrame.h"

@interface ACFaceDetectionViewController ()

@property (nonatomic, strong)UIButton * goBackSelectPhotoBtn;

@property (nonatomic, strong)UIButton * goBackCameraBtn;

@end

@implementation ACFaceDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.goBackCameraBtn];
    [self.view addSubview:self.goBackSelectPhotoBtn];
    
    
}

- (UIButton*)goBackSelectPhotoBtn {
    if (!_goBackSelectPhotoBtn) {
        _goBackSelectPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackSelectPhotoBtn.frame = CGRectMake(0, self.view.ca_height - 180, 150, 44);
        _goBackSelectPhotoBtn.backgroundColor = [UIColor yellowColor];
        _goBackSelectPhotoBtn.ca_centerX = self.view.ca_centerX;
        [_goBackSelectPhotoBtn setTitle:@"重新选图" forState:UIControlStateNormal];
        [_goBackSelectPhotoBtn addTarget:self action:@selector(goBackSelectPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackSelectPhotoBtn;
}

- (UIButton*)goBackCameraBtn {
    if (!_goBackCameraBtn) {
        _goBackCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackCameraBtn.frame = CGRectMake(100, self.view.ca_height - 100, 150, 44);
        _goBackCameraBtn.ca_centerX = self.view.ca_centerX;
        _goBackCameraBtn.backgroundColor = [UIColor yellowColor];
        [_goBackCameraBtn setTitle:@"重新拍照" forState:UIControlStateNormal];
        [_goBackCameraBtn addTarget:self action:@selector(goBackCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackCameraBtn;
}

- (void)goBackSelectPhotoBtnClick:(UIButton*)btn {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)goBackCameraBtnClick:(UIButton*)btn {
    
    ACCameraViewController * cameraVC = [ACCameraViewController new];
    [self.navigationController pushViewController:cameraVC animated:YES];
    
}
@end
