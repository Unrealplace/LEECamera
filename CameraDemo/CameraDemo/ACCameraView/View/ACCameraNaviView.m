
//
//  ACCameraNaviView.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACCameraNaviView.h"
#import "UIView+ACCameraFrame.h"

@interface ACCameraNaviView()

@property (nonatomic, strong)UIButton * leftBtn;
@property (nonatomic, strong)UIButton * centerBtn;
@property (nonatomic, strong)UIButton * rightBtn;


@end

@implementation ACCameraNaviView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.leftBtn];
        [self addSubview:self.centerBtn];
        [self addSubview:self.rightBtn];
    }
    return self;
}

- (void)layoutSubviews {
    self.centerBtn.center = self.center;
    self.leftBtn.ca_centerY = self.ca_centerY;
    self.leftBtn.ca_x = 10;
    self.rightBtn.ca_centerY = self.ca_centerY;
    self.rightBtn.ca_x = self.ca_width - 50;
}

- (UIButton*)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = ACCameraNaviViewTouchTypeLeft;
        _leftBtn.frame = CGRectMake(0, 0, 35, 35);
        _leftBtn.backgroundColor = [UIColor whiteColor];
        [_leftBtn addTarget:self action:@selector(touchWithType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton*)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.tag = ACCameraNaviViewTouchTypeCenter;
        _centerBtn.frame = CGRectMake(0, 0, 35, 35);
         [_centerBtn addTarget:self action:@selector(touchWithType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _centerBtn;
}

- (UIButton*)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = ACCameraNaviViewTouchTypeRight;
        _rightBtn.frame = CGRectMake(0, 0, 35, 35);
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn addTarget:self action:@selector(touchWithType:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightBtn;
}

- (void)touchWithType:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cameraNaviViewTouchEvent:)]) {
        [self.delegate cameraNaviViewTouchEvent:btn.tag];
    }
    
}

@end
