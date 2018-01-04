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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   
    [[ACFaceSDK sharedSDK] setAppType:ACFaceSDKAPPTypeArtCamera andCurrentEnviroment:ACFaceSDKEnviromentTypeDebug];
    
    [[ACFaceSDK sharedSDK] compressionSerias];
    
    [[ACFaceSDK sharedSDK] useCameraHandler:^(UIViewController *currentController) {
//        ACCameraViewController * pickerVC = [[ACCameraViewController alloc]init];
//        [currentController.navigationController pushViewController:pickerVC animated:YES];
        
        ACOtherCameraViewController * pickerVC = [[ACOtherCameraViewController alloc]init];
        [currentController.navigationController pushViewController:pickerVC animated:YES];
        
    }];
    
    [[ACFaceSDK sharedSDK] backToCameraControllerHandler:^(UIViewController *currentController) {
        for (UIViewController * vc in currentController.navigationController.childViewControllers) {
            if ([vc isKindOfClass:[ACOtherCameraViewController class]]) {
                 [currentController.navigationController popToViewController:vc animated:YES];
            }
        }
    }];
     
    
    
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
