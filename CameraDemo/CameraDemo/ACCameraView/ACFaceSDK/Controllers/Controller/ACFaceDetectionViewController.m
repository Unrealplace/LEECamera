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
#import "ACPhotoPickerController.h"
#import "ACCameraViewController.h"
#import "ACFileManager.h"
#import "ACArchiverManager.h"

#import "ACFaceProcessViewController.h"
#import "ACFaceSDK.h"


@interface ACFaceDetectionViewController (){
    ACPhotoPickerController * _photoPicker;
}

@property (nonatomic, strong)UIButton * goBackSelectPhotoBtn;

@property (nonatomic, strong)UIButton * goBackCameraBtn;

@property (nonatomic, strong)UIButton * saveBtn;





@end

@implementation ACFaceDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.goBackCameraBtn];
    [self.view addSubview:self.goBackSelectPhotoBtn];
    [self.view addSubview:self.saveBtn];
    
}
- (void)dealloc {
    NSLog(@"%s",__func__);

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

- (UIButton*)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(100, 0, 150, 44);
        _saveBtn.ca_center = self.view.ca_center;
        _saveBtn.backgroundColor = [UIColor yellowColor];
        [_saveBtn setTitle:@"识别完成" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}





- (void)saveBtnClick:(UIButton*)btn {
    
    ACFaceProcessViewController * vc = [ACFaceProcessViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)goBackSelectPhotoBtnClick:(UIButton*)btn {
    
    [[ACFaceSDK sharedSDK] backToPhotoAlbum:self];
 
}

- (void)goBackCameraBtnClick:(UIButton*)btn {

    [[ACFaceSDK sharedSDK] backToCamera:self];
    
}
@end
