//
//  ACCameraAlertView.m
//  CameraDemo
//
//  Created by LiYang on 2018/1/8.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACCameraAlertView.h"
#import "ACCameraHeader.h"
#import "UIView+ACCameraFrame.h"

@interface ACCameraAlertView()

@end

@implementation ACCameraAlertView

+ (instancetype)tintAlertView {
    ACCameraAlertView * tintView = [[ACCameraAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [tintView setupSubViews];
    return tintView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.alpha = 0;
        
    }
    return self;
}
- (void)setupSubViews {
    
    UIView * showView = [UIView new];
    UIImageView * showImageView = [UIImageView new];
    UILabel * firstLabel = [UILabel new];
    UILabel * secondLabel = [UILabel new];
    UILabel * threeLabel = [UILabel new];
    UIButton * sureBtn = [UIButton new];
    
    showView.frame = CGRectMake(0, ACCAMERA_NAVI_TOP_PADDING + ACCAMERA_AdjustValue(200), ACCAMERA_AdjustValueByWidth(240), ACCAMERA_AdjustValue(220));
    showView.layer.backgroundColor = [[UIColor colorWithRed:64.0f/255.0f green:65.0f/255.0f blue:67.0f/255.0f alpha:1.0f] CGColor];
    showView.ca_centerX = self.ca_centerX;
    [self addSubview:showView];

    showImageView.frame = CGRectMake(0, 0, showView.ca_width, ACCAMERA_AdjustValue(220));
    showImageView.image = [UIImage imageNamed:@""];
    [showView addSubview:showImageView];
    
    firstLabel.frame = CGRectMake(0, CGRectGetMaxY(showImageView.frame), showView.ca_width, ACCAMERA_AdjustValue(35));
    secondLabel.frame = CGRectMake(0, CGRectGetMaxY(firstLabel.frame), showView.ca_width, ACCAMERA_AdjustValue(35));
    threeLabel.frame = CGRectMake(0, CGRectGetMaxY(secondLabel.frame), showView.ca_width, ACCAMERA_AdjustValue(35));
    firstLabel.ca_centerX = showView.ca_width/2.0f;
    secondLabel.ca_centerX = showView.ca_width/2.0f;
    threeLabel.ca_centerX = showView.ca_width/2.0f;

    firstLabel.text = @"1.请用正面角度拍摄";
    secondLabel.text = @"2.拍摄的时候漏出脸";
    threeLabel.text = @"3.不漏牙齿的微笑最好";
    
    firstLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    threeLabel.textAlignment = NSTextAlignmentCenter;

    [showView addSubview:firstLabel];
    [showView addSubview:secondLabel];
    [showView addSubview:threeLabel];

    
    sureBtn.frame = CGRectMake(0, CGRectGetMaxY(threeLabel.frame), ACCAMERA_AdjustValueByWidth(120), ACCAMERA_AdjustValue(35));
    sureBtn.backgroundColor = [UIColor yellowColor];
    [sureBtn setTitle:@"" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.ca_centerX = showView.ca_width/2.0f;
    [showView addSubview:sureBtn];
    
    
    CGFloat  height = showImageView.ca_height + firstLabel.ca_height + secondLabel.ca_height + threeLabel.ca_height + sureBtn.ca_height;
    
    showView.frame = CGRectMake(showView.ca_x, showView.ca_y, showView.ca_width, height);
    
    showView.backgroundColor = [UIColor purpleColor];
    
}
- (void)sureBtnClick:(UIButton*)sender {
    [self dismiss];
}
- (void)showAlert {
 
    [ACCAMERA_Window addSubview:self];
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.4f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
