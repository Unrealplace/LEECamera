//
//  AppDelegate.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "AppDelegate.h"
#import "ACFaceSDK.h"
#import "ACCameraViewController.h"
#import "ACOtherCameraViewController.h"
#import "ACPhotoPickerController.h"
#import "ACOtherPhotoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    /**
     初始化SDK 并配置要使用的 相册和相机
     
     @param appType app 的类型
     @param enviroType 当前开发的环境
     @param photoClass photo 控制器
     @param cameraClass camera 控制器
     */
    [[ACFaceSDK sharedSDK] setAppType:ACFaceSDKAPPTypeArtCamera
                 andCurrentEnviroment:ACFaceSDKEnviromentTypeDebug
           andRegisterPhotoController:[ACOtherPhotoViewController class]
                  andCameraController:[ACOtherCameraViewController class]];
    /**
     SDK 不集成网络检测，考虑各个app 都有网络检测，只需调用即可
     
     @param currentController 当前控制器
     @return 返回当前网络状态
     */
    [[ACFaceSDK sharedSDK] monitorNetState:^ACFaceSDKNetStateType(UIViewController *currentController) {
        
        
        
        return ACFaceSDKNetStateTypeWifi;
        
    }];
    
    [[ACFaceSDK sharedSDK] compressionSerias];
    
    /**
     弹窗提示信息，相机界面的小灯泡提示，第一次登陆和用户自己点击弹出，各个app 可以根据自身进行提示
     
     @param currentController 当前控制器
     */
    [[ACFaceSDK sharedSDK] showTintAlertControllerHandler:^(UIViewController *currentController) {
        NSLog(@"显示 alert");
        if ([[ACFaceSDK sharedSDK] enriroType] == ACFaceSDKEnviromentTypeRelease) {
            [[ACFaceSDK sharedSDK] updateEnviroMentType:ACFaceSDKEnviromentTypeDebug];
        }else {
            [[ACFaceSDK sharedSDK] updateEnviroMentType:ACFaceSDKEnviromentTypeRelease];
        }
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"hello" message:@"使用提示信息啊" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *confirAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:cancleAction];
        [alertVC addAction:confirAction];
        [currentController presentViewController:alertVC animated:YES completion:nil];
        
    }];
    
    /**
     调用宿主的分享功能
     
     @param currentController 当前控制器
     @param model 分享的模型
     @param type 分享的类型
     */
    [[ACFaceSDK sharedSDK] shareViewClick:^(UIViewController *currentController, ACFaceShareModel *model, ACFaceSDKShareType type) {
        NSLog(@"开始分享%ld",type);
    }];
    
    
   
    
    
    
    

//
//    /**
//     使用宿主相册功能
//
//     @param currentController 当前控制器
//     */
//    [[ACFaceSDK sharedSDK] usePhotoAlbumControllerHandler:^(UIViewController *currentController) {
//
//        BOOL have = NO;
//        for (UIViewController * vc in currentController.navigationController.childViewControllers) {
//            if ([vc isKindOfClass:[ACPhotoPickerController class]]) {
//                have = YES;
//                [currentController.navigationController popToViewController:vc animated:YES];
//            }
//        }
//        if (!have) {
//            ACPhotoPickerController * photoVC = [ACPhotoPickerController new];
//            [currentController.navigationController pushViewController:photoVC animated:YES];
//        }
    
//        BOOL have = NO;
//        for (UIViewController * vc in currentController.navigationController.childViewControllers) {
//            if ([vc isKindOfClass:[ACOtherPhotoViewController class]]) {
//                have = YES;
//                [currentController.navigationController popToViewController:vc animated:YES];
//            }
//        }
//        if (!have) {
//            ACOtherPhotoViewController * photoVC = [ACOtherPhotoViewController new];
//            [currentController.navigationController pushViewController:photoVC animated:YES];
//        }
        
        
//    }];
    
    
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
