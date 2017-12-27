//
//  ACCameraView.m
//  CameraDemo
//
//  Created by LiYang on 2017/12/27.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACCameraView.h"

@interface ACCameraView ()

@property (nonatomic, strong) ACVideoPreView    *preView;

@end

@implementation ACCameraView



- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.preView = [[ACVideoPreView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 64 - 100)];
    [self addSubview:self.preView];
    
}
/**
 取消拍照
 */
- (void)cancelAction {
    
}

/**
 开启拍照
 */
- (void)takePhotoAction:(ACCameraView*)cameraView {
    
}

- (void)setupSession:(AVCaptureSession*)session {
    [self.preView setCaptureSession:session];
    
}


@end
