//
//  ACOtherCameraViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACOtherCameraViewController.h"
#import "ACFaceDetectionViewController.h"

@interface ACOtherCameraViewController ()
@property (nonatomic, strong)UIButton * faceDetectionBtn;
@end

@implementation ACOtherCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.faceDetectionBtn];
}

- (UIButton*)faceDetectionBtn {
    if (!_faceDetectionBtn) {
        _faceDetectionBtn = [UIButton new];
        _faceDetectionBtn.frame = CGRectMake(100, 100, 120, 44);
        [_faceDetectionBtn addTarget:self action:@selector(faceDetectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _faceDetectionBtn.backgroundColor = [UIColor redColor];
        
    }
    return _faceDetectionBtn;
}
- (void)faceDetectionBtnClick:(UIButton*)btn {
    ACFaceDetectionViewController * vc = [ACFaceDetectionViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
