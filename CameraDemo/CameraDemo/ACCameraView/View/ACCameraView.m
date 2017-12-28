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

@end

@implementation ACCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

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

- (void)setupUI {
    [self addSubview:self.topView];
    [self addSubview:self.preView];
    [self addSubview:self.bottomView];
    
}


- (void)setupSession:(AVCaptureSession*)session {
    [self.preView setCaptureSession:session];
    
}

#pragma mark bottomViewDelegate


- (void)takePhoto:(ACCameraBottomView*)cameraBottomView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takePhotoAction:)]) {
        [self.delegate takePhotoAction:self];
    }
}

#pragma mark topViewDelegate

- (void)touchCancel:(ACCameraTopView *)cameraTopView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAction:)]) {
        [self.delegate cancelAction:self];
    }
}
- (void)switchCamera:(ACCameraTopView *)cameraTopView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchCameraAction:Success:Failed:)]) {
        [self.delegate switchCameraAction:self Success:^{
            
        } Failed:^(NSError * error) {
            
        }];
    }
}
- (void)sharkStart:(ACCameraTopView *)cameraTopView {
    
}


@end
