//
//  ACCameraTopView.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/28.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraTopView.h"

@interface ACCameraTopView ()

@property (nonatomic, strong) UIButton * sharkBtn;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UIButton * switchCameraBtn;
@end

@implementation ACCameraTopView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.switchCameraBtn];
    [self addSubview:self.sharkBtn];
    
    self.cancelBtn.center       = CGPointMake(self.cancelBtn.center.x, self.bounds.size.height/2.0f);
    self.switchCameraBtn.center = CGPointMake(self.switchCameraBtn.center.x, self.bounds.size.height/2.0f);
    self.sharkBtn.center        = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
}

- (UIButton*)sharkBtn {
    if (!_sharkBtn) {
        _sharkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sharkBtn.frame = CGRectMake(0, 0, 100, 35);
        [_sharkBtn setTitle:@"闪光灯" forState:UIControlStateNormal];
        [_sharkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sharkBtn addTarget:self action:@selector(sharkBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sharkBtn;
}

#pragma mark getter 方法
- (UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(10, 0, 100, 35);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)switchCameraBtn {
    if (!_switchCameraBtn) {
        _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchCameraBtn.frame = CGRectMake(self.bounds.size.width - 110, 0, 100, 35);
        [_switchCameraBtn setTitle:@"切换" forState:UIControlStateNormal];
        [_switchCameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraBtn;
}

#pragma mark touch
- (void)cancelBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchCancel:)]) {
        [self.delegate touchCancel:self];
    }
}
- (void)sharkBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sharkStart:)]) {
        [self.delegate sharkStart:self];
    }
}
- (void)switchCameraBtnClick:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchCamera:)]) {
        [self.delegate switchCamera:self];
    }
}
@end
