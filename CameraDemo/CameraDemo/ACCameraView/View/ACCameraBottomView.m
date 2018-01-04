//
//  ACCameraBottomView.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraBottomView.h"
#import "UIView+ACCameraFrame.h"

@interface ACCameraBottomView ()

@property (nonatomic, strong) UIButton * takePhotoBtn;

@property (nonatomic, strong) UIButton * showPhotoBtn;

@property (nonatomic, strong) UIButton * tintBtn;

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
    [self addSubview:self.showPhotoBtn];
    [self addSubview:self.tintBtn];
    
    self.takePhotoBtn.center     = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    self.showPhotoBtn.ca_centerY = self.ca_height / 2.0f;
    self.tintBtn.ca_centerY      = self.ca_height / 2.0f;
    
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
- (UIButton*)showPhotoBtn {
    if (!_showPhotoBtn) {
        _showPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showPhotoBtn.frame = CGRectMake(20, 0, 70, 50);
        [_showPhotoBtn setTitle:@"缩略图" forState:UIControlStateNormal];
        [_showPhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showPhotoBtn addTarget:self action:@selector(showPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPhotoBtn;
}

- (UIButton*)tintBtn {
    if (!_tintBtn) {
        _tintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tintBtn.frame = CGRectMake(self.ca_width - 70, 0, 50, 50);
        [_tintBtn setTitle:@"提示" forState:UIControlStateNormal];
        [_tintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_tintBtn addTarget:self action:@selector(tintBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tintBtn;
}
#pragma mark touch 

- (void)takePhotoBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePhoto:)]) {
        [self.delegate takePhoto:self];
    }
}
- (void)showPhotoBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showPhotoAlblum:)]) {
        [self.delegate showPhotoAlblum:self];
    }
}
- (void)tintBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tintPhoto:)]) {
        [self.delegate tintPhoto:self];
    }
}
@end
