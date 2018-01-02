//
//  ACFaceSDK.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/2.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceSDK.h"

@interface ACFaceSDK()


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
- (void)setAppType:(ACFaceSDKAPPType)appType {
    _appType = appType;
}

 

@end
