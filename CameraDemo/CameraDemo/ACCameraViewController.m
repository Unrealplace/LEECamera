//
//  ACCameraViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2017/12/27.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACCameraViewController.h"
#import  <AVFoundation/AVFoundation.h>
#import "ACCameraView.h"

@interface ACCameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

{
    // 会话
    AVCaptureSession * _captureSession;
    
    //输入
    AVCaptureDeviceInput * _deviceInput;
    
    //输出
    AVCaptureConnection       *_videoConnection;
    AVCaptureVideoDataOutput  *_videoOutput;
    AVCaptureStillImageOutput *_imageOutput;

    //相机图层
    ACCameraView          * _cameraView;
}


@end

@implementation ACCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _cameraView = [[ACCameraView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_cameraView];
    
    NSError *error;
    [self setupSession:&error];
    if (!error) {
        [_cameraView setupSession:_captureSession];
        [self startCaptureSession];
    }

}

- (void)dealloc {
    NSLog(@"dealloc");
}
#pragma mark -- 输入设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray * devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice * device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}


#pragma mark 会话配置

- (void)setupSession:(NSError**)error {
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [self setupSessionInputs:error];
    [self setupSeesionOutPut:error];
}

#pragma mark 输入配置
- (void)setupSessionInputs:(NSError**)error {
    // 视频输入
    AVCaptureDevice * videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput  * videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([_captureSession canAddInput:videoInput]) {
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        }
    }
}

- (void)setupSeesionOutPut:(NSError**)error {
    
    AVCaptureStillImageOutput * imageOutput =  [[AVCaptureStillImageOutput alloc] init];
    imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([_captureSession canAddOutput:imageOutput]) {
        [_captureSession addOutput:imageOutput];
        _imageOutput = imageOutput;
    }
}

#pragma mark -- 开始和停止会话
- (void)startCaptureSession {
    if (!_captureSession.isRunning) {
        [_captureSession startRunning];
    }
}

- (void)stopCaptureSession {
    if (_captureSession.isRunning) {
        [_captureSession stopRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"%@",sampleBuffer);
}

@end
