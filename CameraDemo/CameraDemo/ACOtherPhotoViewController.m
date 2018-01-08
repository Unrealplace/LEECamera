//
//  ACOtherPhotoViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACOtherPhotoViewController.h"
#import "ACFaceDetectionViewController.h"

@interface ACOtherPhotoViewController ()
@property (nonatomic, strong)UIButton * faceDetectionBtn;

@end

@implementation ACOtherPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.faceDetectionBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
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
