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
#import "ACPhotoPickerController.h"
#import "ACFaceSDK.h"
#import "ACPhotoTool.h"
#import "ACCameraHeader.h"

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


@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)ACMotionManager *motionManager;
@property(nonatomic, assign)AVCaptureFlashMode currentflashMode; // 当前闪光灯的模式，用来调整前后摄像头切换时候的模式
@property(nonatomic, assign)BOOL isFrontCarmera;// 当前是前置还是后置摄像头



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
    
   
    
    _isFrontCarmera = NO;
    _cameraView = [[ACCameraView alloc] initWithFrame:self.view.bounds];
    _cameraView.delegate = self;
    [self.view addSubview:_cameraView];
    
   
    NSError *error;
    [self setupSession:&error];
    if (!error) {
        [_cameraView setupSession:_captureSession];
        [self startCaptureSession];
    }
 
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.delegate = self;
    
 }

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.delegate = nil;

 
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [_captureSession stopRunning];
    [_motionManager.motionManager stopDeviceMotionUpdates];
    _motionManager   = nil;
    _captureSession  = nil;
    _deviceInput     = nil;
    _videoConnection = nil;
    _videoOutput     = nil;
    _imageOutput     = nil;
    self.navigationController.navigationBarHidden = NO;
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
    self.isFrontCarmera?(connection.videoMirrored=YES):(connection.videoMirrored=NO);
    id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
        if (sampleBuffer == NULL)return ;
        self.imageView.image = nil;
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
        UIImage *image = [[UIImage alloc]initWithData:imageData];
        
        [ACPhotoTool saveImage:image compeleted:^(BOOL isCompeleted, NSString *status, NSDictionary *imgInfo) {
            
            [ACPhotoTool latestAsset:^(ACAsset * _Nullable asset) {
                [_cameraView.bottomView setTheLatestImageWith:asset.image];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[ACFaceSDK sharedSDK] enterPhotoWithCurrentController:self andImage:image];
                });
            }];
           
        }];
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
            self.isFrontCarmera = YES;
        }else{
            self.isFrontCarmera = NO;
        }
        
        // 前后摄像头的闪光灯不是同步的，所以在转换摄像头后需要重新设置闪光灯
//        [self changeFlash:_currentflashMode];
        return nil;
    }
    return error;
}
- (BOOL)cameraSupportsTapToFocus{
    return [[self activeCamera] isFocusPointOfInterestSupported];
}

#pragma mark 闪光灯 和 手电筒的 配置

- (BOOL)cameraHasFlash{
    return [[self activeCamera] hasFlash];
}

- (AVCaptureFlashMode)flashMode{
    return [[self activeCamera] flashMode];
}


- (id)changeFlash:(AVCaptureFlashMode)flashMode{
    if (![self cameraHasFlash]) {
        NSDictionary *desc = @{NSLocalizedDescriptionKey:@"不支持闪光灯"};
        NSError *error = [NSError errorWithDomain:@"com.cc.camera" code:401 userInfo:desc];
        return error;
    }
    // 如果手电筒打开，先关闭手电筒
    if ([self torchMode] == AVCaptureTorchModeOn) {
        [self setTorchMode:AVCaptureTorchModeOff];
    }
    return [self setFlashMode:flashMode];
}
- (id)setFlashMode:(AVCaptureFlashMode)flashMode{
    AVCaptureDevice *device = [self activeCamera];
    if ([device isFlashModeSupported:flashMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.flashMode = flashMode;
            [device unlockForConfiguration];
            _currentflashMode = flashMode;
        }
        return error;
    }
    return nil;
}

- (BOOL)cameraHasTorch {
    return [[self activeCamera] hasTorch];
}

- (AVCaptureTorchMode)torchMode {
    return [[self activeCamera] torchMode];
}

- (id)changeTorch:(AVCaptureTorchMode)torchMode{
    if (![self cameraHasTorch]) {
        NSDictionary *desc = @{NSLocalizedDescriptionKey:@"不支持手电筒"};
        NSError *error = [NSError errorWithDomain:@"com.cc.camera" code:403 userInfo:desc];
        return error;
    }
    // 如果闪光灯打开，先关闭闪光灯
    if ([self flashMode] == AVCaptureFlashModeOn) {
        [self setFlashMode:AVCaptureFlashModeOff];
    }
    return [self setTorchMode:torchMode];
}

- (id)setTorchMode:(AVCaptureTorchMode)torchMode{
    AVCaptureDevice *device = [self activeCamera];
    if ([device isTorchModeSupported:torchMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.torchMode = torchMode;
            [device unlockForConfiguration];
        }
        return error;
    }
    return nil;
}
#pragma mark ACCameraDelegate

- (void)cancelAction:(ACCameraView *)cameraView {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)takePhotoAction:(ACCameraView *)cameraView {
    NSLog(@"takePhoto");
    [self takePictureImage];

}
- (void)showPhotoAlbum:(ACCameraView *)cameraView {
    
    [[ACFaceSDK sharedSDK] usePhotoAlbum:self];
    
//    [[ACFaceSDK sharedSDK] generateImageFromeCameraWithAppType:ACFaceSDKAPPTypeArtCamera andCurrentController:self withImage:[UIImage imageNamed:@"girl"]];
    
//    [[ACFaceSDK sharedSDK] setupPhotoAlbumController:self];
    
//    [[ACFaceSDK sharedSDK] usePhotoAlbumWithCurrentController:self];
    
//    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:photoVC];
//
//    [self presentViewController:navi animated:YES completion:nil];
    
}

- (void)tintPhotoAlbum:(ACCameraView *)cameraView {
    
    [[ACFaceSDK sharedSDK] setupTintAlertController:self];
    
}

- (void)switchCameraAction:(ACCameraView *)cameraView{
    NSLog(@"switchCamera");
     [self switchCameras];
 
}
- (void)flashLightAction:(ACCameraView *)cameraView {
 
    [self changeFlash:[self flashMode] == AVCaptureFlashModeOn?AVCaptureFlashModeOff:AVCaptureFlashModeOn];

}
- (void)focusPointAction:(ACCameraView *)cameraView
                   point:(CGPoint)point {
    
    AVCaptureDevice *device = [self activeCamera];
    if ([self cameraSupportsTapToFocus] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]){
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
        }
     }
 }



@end
