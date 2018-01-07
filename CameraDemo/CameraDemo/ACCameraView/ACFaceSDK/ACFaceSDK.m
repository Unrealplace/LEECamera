//
//  ACFaceSDK.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceSDK.h"
#import "ACFaceDataManager.h"
#import "ACPhotoPickerController.h"
#import "ACPhotoShowViewController.h"
#import "ACArchiverManager.h"

typedef void (^ACCameraBlock)(UIViewController * controller);
typedef void (^ACCameraShareBlock)(UIViewController * controller,ACFaceShareModel * model, ACFaceSDKShareType shareType);

NSString * const SERIAS_PATH = @"CameraSerias";

@interface ACFaceSDK()

@property (nonatomic, copy)ACCameraBlock cameraBlock;

@property (nonatomic, copy)ACCameraBlock backToCameraBlock;

@property (nonatomic, copy)ACCameraBlock showTintBlock;

@property (nonatomic, copy)ACCameraBlock photoBlock;

@property (nonatomic, copy) ACCameraShareBlock    shareBlock;

/**
 设置app 类型
 */
@property (nonatomic, assign)ACFaceSDKAPPType appType;

/**
 设置当前的环境，开发或者是测试环境
 
 enviroType 配置环境，开发或者是测试
 */
@property (nonatomic, assign)ACFaceSDKEnviromentType enriroType;

@property (nonatomic, strong)NSArray * vcArray;



@end

@implementation ACFaceSDK

+ (instancetype)sharedSDK {
    static ACFaceSDK * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ACFaceSDK alloc] init];
    });
    return manager;
    
}

- (void)updateEnviroMentType:(ACFaceSDKEnviromentType)enrioType {
    _enriroType = enrioType;
    NSArray * arr = [ACArchiverManager unArchiverFaceSeriasandEnviromentType:enrioType];
    if (!arr) {
        [self compressionSerias];
    }
}
- (ACFaceSDKEnviromentType)enriroType{
    return _enriroType;
}
- (void)setAppType:(ACFaceSDKAPPType)appType andCurrentEnviroment:(ACFaceSDKEnviromentType)enviroType andControllers:(NSArray *)controllersArray{
    _appType    = appType;
    _enriroType = enviroType;
    self.vcArray= [NSArray arrayWithArray:controllersArray];
    
}

- (void)compressionSerias {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [ACFaceDataManager compressionCameraSeriasWithPath:SERIAS_PATH];
    });
}

- (void)useCameraHandler:(void (^)(UIViewController *))handler {
    self.cameraBlock = handler;
}

- (void)setupEnterController:(UIViewController *)controller {
    self.cameraBlock(controller);
 }


- (void)enterPhotoWithCurrentController:(UIViewController *)currentController
                               andImage:(UIImage *)image {
   
    ACPhotoShowViewController * photoVC = [ACPhotoShowViewController new];
    photoVC.showImage = image;
    [currentController.navigationController pushViewController:photoVC animated:YES];
}

- (void)backToCameraControllerHandler:(void (^)(UIViewController *))handler {
    self.backToCameraBlock = handler;
    
}
- (void)setBackToCameraController:(UIViewController *)controller {
    self.backToCameraBlock(controller);
}

- (void)showTintAlertControllerHandler:(void (^)(UIViewController *))handler {
    self.showTintBlock = handler;
    
}

- (void)setupTintAlertController:(UIViewController *)controller {
    self.showTintBlock(controller);
}

- (void)usePhotoAlbumControllerHandler:(void (^)(UIViewController *))handler {
    self.photoBlock = handler;
}
- (void)setupPhotoAlbumController:(UIViewController *)currentController {
    self.photoBlock(currentController);
}

- (NSArray*)otherControllers {
    return self.vcArray;
}

- (void)shareViewClick:(void (^)(UIViewController *, ACFaceShareModel *, ACFaceSDKShareType))handler {
    self.shareBlock = handler;
}

- (void)setShareViewWith:(UIViewController *)controller andShareModel:(ACFaceShareModel *)model andShareType:(ACFaceSDKShareType)shareType {
    self.shareBlock(controller, model, shareType);
}

@end
