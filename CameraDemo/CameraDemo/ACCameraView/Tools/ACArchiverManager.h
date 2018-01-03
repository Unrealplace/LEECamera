//
//  ACArchiverManager.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACArchiverManager : NSObject


/**
 反序列化素材数据

 @return 返回数组
 */
+ (NSArray *)unArchiverFaceSerias;


/**
 序列号素材数据

 @param dataArray 素材数据
 @return 是否序列号成功
 */
+ (BOOL)archiverFaceSeriasWith:(NSArray*)dataArray;


/**
 清空本地的数据

 @return 返回是否清空完成
 */
+ (BOOL)cleanUpLocalSerias;

@end
