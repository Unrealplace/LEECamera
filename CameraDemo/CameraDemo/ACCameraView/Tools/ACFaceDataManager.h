//
//  ACFaceDataManager.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFaceDataManager : NSObject

/**
 解压相机素材包
 
 @param cameraSeriasPath 相机素材压缩包的bundle文件路径
 */
+ (void)compressionCameraSeriasWithPath:(NSString*)cameraSeriasPath;

+ (NSURL *)storedSeriesPath;
@end
