//
//  ACCameraBottomView.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraBottomView.h"

@interface ACCameraBottomView ()

@property (nonatomic, strong) UIButton * takePhotoBtn;

@end

@implementation ACCameraBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.takePhotoBtn];
    self.takePhotoBtn.center    = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
   
}


#pragma mark getter 方法


- (UIButton *)takePhotoBtn {
    if (!_takePhotoBtn) {
        _takePhotoBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        _takePhotoBtn.frame = CGRectMake(0, 0, 50, 50);
        [_takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [_takePhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_takePhotoBtn addTarget:self action:@selector(takePhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoBtn;
}

#pragma mark touch 

- (void)takePhotoBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePhoto:)]) {
        [self.delegate takePhoto:self];
    }
}


@end
