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
typedef void (^UseCameraBlock)(UIViewController * controller);

NSString * const SERIAS_PATH = @"CameraSerias";

@interface ACFaceSDK()

@property (nonatomic, copy)UseCameraBlock cameraBlock;

@property (nonatomic, copy)UseCameraBlock backToCameraBlock;


/**
 设置app 类型
 */
@property (nonatomic, assign)ACFaceSDKAPPType appType;

/**
 设置当前的环境，开发或者是测试环境
 
 enviroType 配置环境，开发或者是测试
 */
@property (nonatomic, assign)ACFaceSDKEnviromentType enriroType;

@property (nonatomic, copy)NSString * cameraClass;

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

- (ACFaceSDKEnviromentType)enriroType{
    return _enriroType;
}
- (void)setAppType:(ACFaceSDKAPPType)appType andCurrentEnviroment:(ACFaceSDKEnviromentType)enviroType {
    _appType    = appType;
    _enriroType = enviroType;
}

- (void)compressionSerias {
    [ACFaceDataManager compressionCameraSeriasWithPath:SERIAS_PATH];
}

- (void)useCameraHandler:(void (^)(UIViewController *))handler {
    self.cameraBlock = handler;

}

- (void)setupEnterController:(UIViewController *)controller {
    self.cameraBlock(controller);
 }

- (void)usePhotoAlbumWithCurrentController:(UIViewController *)currentController {
    switch (self.appType) {
        case ACFaceSDKAPPTypeArtCamera:
        {
            ACPhotoPickerController * photoVC = [ACPhotoPickerController new];
            [currentController.navigationController pushViewController:photoVC animated:YES];
        }
            break;
        case ACFaceSDKAPPTypeManCamera:
        {
            
        }
            break;
        case ACFaceSDKAPPTypeBeautyCamera:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)enterPhotoWithCurrentController:(UIViewController *)currentController
                               andImage:(UIImage *)image {
    switch (self.appType) {
        case ACFaceSDKAPPTypeArtCamera:
        {
            ACPhotoShowViewController * photoVC = [ACPhotoShowViewController new];
            photoVC.showImage = image;
            [currentController.navigationController pushViewController:photoVC animated:YES];
        }
            break;
        case ACFaceSDKAPPTypeManCamera:
        {
            
        }
            break;
        case ACFaceSDKAPPTypeBeautyCamera:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)backToCameraControllerHandler:(void (^)(UIViewController *))handler {
    self.backToCameraBlock = handler;
    
}
- (void)setBackToCameraController:(UIViewController *)controller {
    self.backToCameraBlock(controller);
}
//- (void)backToCameraController:(UIViewController *)controller {
//    
//    for (UIViewController * vc in controller.navigationController.childViewControllers) {
//        if ([vc isKindOfClass:NSClassFromString(self.cameraClass)]) {
//         [controller.navigationController popToViewController:vc animated:YES];
//        }
//    }
//    switch (self.appType) {
//        case ACFaceSDKAPPTypeArtCamera:
//        {
//             
//        }
//            break;
//        case ACFaceSDKAPPTypeManCamera:
//        {
//            
//        }
//            break;
//        case ACFaceSDKAPPTypeBeautyCamera:
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

 
@end
