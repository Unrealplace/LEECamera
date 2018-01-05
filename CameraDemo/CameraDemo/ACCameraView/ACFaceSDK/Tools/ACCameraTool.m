//
//  ACCameraTool.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACCameraTool.h"
#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"
#define HAVE_LOAD_KEY @"have_load_key"

@implementation ACCameraTool
+ (BOOL) isFirstLoad {
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
