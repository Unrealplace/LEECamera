//
//  ACCameraViewController.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ACCameraViewController.h"
#import  <AVFoundation/AVFoundation.h>
#import "ACCameraView.h"
#import "ACMotionManager.h"
#import "ACPhotoShowViewController.h"

@interface ACCameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,
                                     AVCaptureAudioDataOutputSampleBufferDelegate,
                                        ACCameraViewDelegate>
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


@property (nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong) ACMotionManager *motionManager;

@end

@implementation ACCameraViewController


- (instancetype)init {
    if (self = [super init]) {
        _motionManager = [[ACMotionManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cameraView = [[ACCameraView alloc] initWithFrame:self.view.bounds];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
    
    NSError *error;
    [self setupSession:&error];
    if (!error) {
        [_cameraView setupSession:_captureSession];
        [self startCaptureSession];
    }
    [self.view addSubview:self.imageView];

}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 }

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)dealloc {
    NSLog(@"dealloc");
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.frame = CGRectMake(0, 0, 100, 100);
    }
    return _imageView;
}


// 当前设备取向
- (AVCaptureVideoOrientation)currentVideoOrientation{
    AVCaptureVideoOrientation orientation;
    switch (self.motionManager.deviceOrientation) {
        case UIDeviceOrientationPortrait:
            orientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeRight:
            orientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            orientation = AVCaptureVideoOrientationLandscapeRight;
            break;
    }
    return orientation;
}


#pragma mark - -输入设备
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)activeCamera{
    return _deviceInput.device;
}

- (AVCaptureDevice *)inactiveCamera{
    AVCaptureDevice *device = nil;
    if ([[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1) {
        if ([self activeCamera].position == AVCaptureDevicePositionBack) {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        } else {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
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



/**
 拍摄照片
 */
-(void)takePictureImage{
    AVCaptureConnection *connection = [_imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection.isVideoOrientationSupported) {
        connection.videoOrientation = [self currentVideoOrientation];
    }
    id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
        if (sampleBuffer == NULL)return ;
        self.imageView.image = nil;
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
        UIImage *image = [[UIImage alloc]initWithData:imageData];
        ACPhotoShowViewController * photoVC = [ACPhotoShowViewController new];
        photoVC.showImage = image;
        [self.navigationController pushViewController:photoVC animated:YES];
        
//        self.imageView.image = image;
    };
    [_imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:takePictureSuccess];
}

/**
 转换摄像头
 */
- (BOOL)canSwitchCameras{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count] > 1;
}

- (id)switchCameras{
    if (![self canSwitchCameras]) return nil;
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (videoInput) {
        [_captureSession beginConfiguration];
        [_captureSession removeInput:_deviceInput];
        if ([_captureSession canAddInput:videoInput]) {
            [_captureSession addInput:videoInput];
            _deviceInput = videoInput;
        }
        [_captureSession commitConfiguration];
        
        // 如果后置转前置，系统会自动关闭手电筒，如果之前打开的，需要通知camera更新UI
        if (videoDevice.position == AVCaptureDevicePositionFront) {
//            [self.cameraView changeTorch:NO];
        }
        
        // 前后摄像头的闪光灯不是同步的，所以在转换摄像头后需要重新设置闪光灯
//        [self changeFlash:_currentflashMode];
        return nil;
    }
    return error;
}

#pragma mark ACCameraDelegate

- (void)cancelAction:(ACCameraView *)cameraView {

    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)takePhotoAction:(ACCameraView *)cameraView {
    NSLog(@"takePhoto");
    [self takePictureImage];

}
- (void)switchCameraAction:(ACCameraView *)cameraView
                   Success:(void (^)(void))succsss
                    Failed:(void (^)(NSError *))failed{
    NSLog(@"switchCamera");
    id error = [self switchCameras];
    error?!failed?:failed(error):!succsss?:succsss();
    
}

@end
