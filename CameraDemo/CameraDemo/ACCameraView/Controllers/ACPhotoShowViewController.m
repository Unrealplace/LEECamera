//
//  ACPhotoShowViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2017/12/28.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACPhotoShowViewController.h"
#import "ACFaceDetectionViewController.h"

@interface ACPhotoShowViewController ()

@property (nonatomic, strong) UIImageView * showImageView;

@property (nonatomic, strong) UIButton    * selectBtn;

@property (nonatomic, strong) UIButton    * dismissBtn;

@end

@implementation ACPhotoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.showImageView];
    [self.view addSubview:self.selectBtn];
    [self.view addSubview:self.dismissBtn];
    
    
}

- (UIImageView*)showImageView {
    if (!_showImageView) {
        _showImageView = [UIImageView new];
        _showImageView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44-80);
        _showImageView.image = self.showImage;
        _showImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _showImageView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(10, CGRectGetMaxY(self.showImageView.frame) + 10, 50, 50);
        [_selectBtn setTitle:@"ok" forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(self.view.bounds.size.width - 60, CGRectGetMaxY(self.showImageView.frame) + 10, 50, 50);
        [_dismissBtn setTitle:@"dis" forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

- (void)selectBtnClick:(UIButton*)btn {
    ACFaceDetectionViewController * faceDecVC = [ACFaceDetectionViewController new];
    [self.navigationController pushViewController:faceDecVC animated:YES];
    
}

- (void)dismissBtnClick:(UIButton*)btn {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
