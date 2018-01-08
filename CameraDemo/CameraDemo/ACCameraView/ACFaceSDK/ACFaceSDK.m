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

#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"
#define HAVE_LOAD_KEY        @"have_load_key"

typedef void (^ACCameraBlock)(UIViewController * controller);
typedef void (^ACCameraShareBlock)(UIViewController * controller,ACFaceShareModel * model, ACFaceSDKShareType shareType);
typedef ACFaceSDKNetStateType (^ACCameraNetStateBlock)(UIViewController * controller);

NSString * const SERIAS_PATH = @"CameraSerias";

@interface ACFaceSDK()

@property (nonatomic, copy)ACCameraBlock         showTintBlock;

@property (nonatomic, copy)ACCameraShareBlock    shareBlock;

@property (nonatomic, copy)ACCameraNetStateBlock  netBlock;

/**
 设置app 类型
 */
@property (nonatomic, assign)ACFaceSDKAPPType appType;

/**
 设置当前的环境，开发或者是测试环境
 
 enviroType 配置环境，开发或者是测试
 */
@property (nonatomic, assign)ACFaceSDKEnviromentType enriroType;


/**
 注册的相册控制器
 */
@property (nonatomic, strong)Class   photoClass;

/**
 注册的相机控制器
 */
@property (nonatomic, strong)Class   CameraClass;


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



/**
 初始化SDK 并配置要使用的 相册和相机

 @param appType app 的类型
 @param enviroType 当前开发的环境
 @param photoClass photo 控制器
 @param cameraClass camera 控制器
 */
- (void)setAppType:(ACFaceSDKAPPType)appType
        andCurrentEnviroment:(ACFaceSDKEnviromentType)enviroType
        andRegisterPhotoController:(Class)photoClass
        andCameraController:(Class)cameraClass {
    
    _appType    = appType;
    _enriroType = enviroType;
    self.photoClass  = photoClass;
    self.CameraClass = cameraClass;
    
}

/**
 获取当前的相册控制器

 @return 相册控制器
 */
- (Class)currentPhotoCotroller {
    return self.photoClass;
}

/**
 获取当前的相机控制器

 @return 当前的相机控制器
 */
- (Class)currentCameraCotroller {
    return self.CameraClass;
}


/**
 进入宿主相机界面

 @param superClass 父控制器
 */
- (void)enterToCamera:(UIViewController*)superClass {
    
    [superClass.navigationController pushViewController:[self.CameraClass new] animated:YES];
}

/**
 返回相机界面

 @param superClass  父控制器
 */
- (void)backToCamera:(UIViewController *)superClass {
    for (UIViewController * vc in superClass.navigationController.childViewControllers) {
        if ([vc isKindOfClass:self.CameraClass]) {
            [superClass.navigationController popToViewController:vc animated:YES];
        }
    }
}
/**
 使用宿主的相册功能
 
 @param superClass 相册的父控制器
 */
- (void)usePhotoAlbum:(UIViewController *)superClass {
    BOOL have = NO;
    for (UIViewController * vc in superClass.navigationController.childViewControllers) {
        if ([vc isKindOfClass:self.photoClass]) {
            have = YES;
            [superClass.navigationController popToViewController:vc animated:YES];
        }
    }
    if (!have) {
        [superClass.navigationController pushViewController:[self.photoClass new] animated:YES];
    }
}
/**
 返回到相册
 
 @param superClass 相册的父控制器
 */
- (void)backToPhotoAlbum:(UIViewController *)superClass {
    BOOL have = NO;
    for (UIViewController * vc in superClass.navigationController.childViewControllers) {
        if ([vc isKindOfClass:self.photoClass]) {
            have = YES;
            [superClass.navigationController popToViewController:vc animated:YES];
        }
    }
    if (!have) {
        [superClass.navigationController pushViewController:[self.photoClass new] animated:YES];
    }
}


/**
 进入到图片展示确认页面

 @param currentController 当前控制器
 @param image 要展示的图片
 */
- (void)enterPhotoWithCurrentController:(UIViewController *)currentController
                               andImage:(UIImage *)image {
   
    ACPhotoShowViewController * photoVC = [ACPhotoShowViewController new];
    photoVC.showImage = image;
    [currentController.navigationController pushViewController:photoVC animated:YES];
}

/**
 显示提示，用户点击小灯泡或者首次登陆时候弹框提示
 
 @param handler 提示回调
 */
- (void)showTintAlertControllerHandler:(void (^)(UIViewController *))handler {
    self.showTintBlock = handler;
    
}
/**
 配置弹框的父控制器
 
 @param controller 弹框的父控制器
 */
- (void)setupTintAlertController:(UIViewController *)controller {
    self.showTintBlock(controller);
}

/**
 调用宿主的分享功能
 
 @param handler 分享回调
 */
- (void)shareViewClick:(void (^)(UIViewController *, ACFaceShareModel *, ACFaceSDKShareType))handler {
    self.shareBlock = handler;
}

/**
 设置分享
 
 @param controller 控制器
 @param model 分享的模型
 @param shareType 分享的种类
 */
- (void)setShareViewWith:(UIViewController *)controller andShareModel:(ACFaceShareModel *)model andShareType:(ACFaceSDKShareType)shareType {
    self.shareBlock(controller, model, shareType);
}
/**
 调用宿主的网络状态
 
 @param handler 监控回调
 */
- (void)monitorNetState:(ACFaceSDKNetStateType (^)(UIViewController *))handler {
    self.netBlock = handler;
}

/**
 配置网络检测
 
 @param controller 父控制器
 @return 当前网络状态
 */
- (ACFaceSDKNetStateType)setNetState:(UIViewController *)controller {
    return self.netBlock(controller);
}
/**
 解压素材
 */
- (void)compressionSerias {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [ACFaceDataManager compressionCameraSeriasWithPath:SERIAS_PATH];
    });
}


/**
 是否是第一次启动

 @return 状态
 */
- (BOOL)isFirstLoad {
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        if ([[defaults objectForKey:HAVE_LOAD_KEY] boolValue]) {
            return NO;
        }else {
            [defaults setObject:@(YES) forKey:HAVE_LOAD_KEY];
            return YES;
        }
    }
    else if (![lastRunVersion isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
        if ([[defaults objectForKey:HAVE_LOAD_KEY] boolValue]) {
            return NO;
        }else {
            [defaults setObject:@(YES) forKey:HAVE_LOAD_KEY];
            return YES;
        }
    }
    return NO;
}
@end
