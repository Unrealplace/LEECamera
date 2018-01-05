//
//  ACVideoPreView.m
//  CameraDemo
//
//  Created by LiYang on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACVideoPreView.h"

@implementation ACVideoPreView

- (void)dealloc {
    self.captureSession = nil;
}
+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [(AVCaptureVideoPreviewLayer *)self.layer setVideoGravity:AVLayerVideoGravityResize];
    }
    return self;
}

- (AVCaptureSession*)captureSession {
    return [(AVCaptureVideoPreviewLayer*)self.layer session];
}

- (void)setCaptureSession:(AVCaptureSession *)captureSession {
    [(AVCaptureVideoPreviewLayer*)self.layer setSession:captureSession];
}

- (CGPoint)captureDevicePointForPoint:(CGPoint)point {
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    return [layer captureDevicePointOfInterestForPoint:point];
}



@end
