//
//  ACCameraView.m
//  CameraDemo
//
//  Created by LiYang on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraView.h"
#import "ACCameraBottomView.h"
#import "ACCameraTopView.h"

@interface ACCameraView ()<ACCameraBottomViewDelegate,ACCameraTopViewDelegate>
// 显示图层
@property (nonatomic, strong) ACVideoPreView             *preView;
//顶部操作菜单
@property (nonatomic, strong) ACCameraTopView            *topView;
// 底部操作菜单图层
@property (nonatomic, strong) ACCameraBottomView         *bottomView;

//聚焦图层
@property (nonatomic, strong) UIView                     *focusView;


@end

@implementation ACCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

#pragma mark getter 方法

- (ACCameraTopView*)topView {
    if (!_topView) {
        _topView = [[ACCameraTopView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.delegate = self;
    }
    return _topView;
}

- (ACVideoPreView*)preView {
    if (!_preView) {
        _preView = [[ACVideoPreView alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, self.bounds.size.height - 44 - 100)];
    }
    return _preView;
}

- (ACCameraBottomView*)bottomView {
    if (!_bottomView) {
        _bottomView = [[ACCameraBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.preView.frame), self.bounds.size.width, self.bounds.size.height - self.topView.bounds.size.height - self.preView.bounds.size.height)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.delegate        = self;
    }
    return _bottomView;
}

- (UIView*)focusView {
    if (!_focusView) {
        _focusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _focusView.backgroundColor = [UIColor clearColor];
        _focusView.layer.borderWidth = 3.0f;
        _focusView.layer.borderColor = [UIColor greenColor].CGColor;
        _focusView.hidden          = YES;
    }
    return _focusView;
}



- (void)setupUI {
    [self addSubview:self.topView];
    [self addSubview:self.preView];
    [self addSubview:self.bottomView];
    [self.preView addSubview:self.focusView];
    
    
    UITapGestureRecognizer * signleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signleTap:)];
    [self.preView addGestureRecognizer:signleTap];
    
    
}


- (void)setupSession:(AVCaptureSession*)session {
    [self.preView setCaptureSession:session];
    
}

- (void)signleTap:(UIGestureRecognizer*)ges {
    
    CGPoint point = [ges locationInView:self.preView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(focusPointAction:point:)]) {
        [self.delegate focusPointAction:self point:point];
    }
    [self runFocusAnimation:self.focusView point:point];
}




// 聚焦、曝光动画
-(void)runFocusAnimation:(UIView *)view point:(CGPoint)point{
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    } completion:^(BOOL complete) {
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            view.hidden = YES;
            view.transform = CGAffineTransformIdentity;
        });
    }];
}


#pragma mark bottomViewDelegate && topViewDelegate


- (void)takePhoto:(ACCameraBottomView*)cameraBottomView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePhotoAction:)]) {
        [self.delegate takePhotoAction:self];
    }
}

- (void)touchCancel:(ACCameraTopView *)cameraTopView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAction:)]) {
        [self.delegate cancelAction:self];
    }
}
- (void)switchCamera:(ACCameraTopView *)cameraTopView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchCameraAction:)]) {
        [self.delegate switchCameraAction:self ];
    }
}
- (void)sharkStart:(ACCameraTopView *)cameraTopView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flashLightAction:)]) {
        [self.delegate flashLightAction:self];
    }
}


@end
