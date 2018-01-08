//
//  ACArchiverManager.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACCameraHeader.h"
#import "ACFaceModel.h"

@interface ACArchiverManager : NSObject


/**
 增加一个数据

 @param model model
 @param envirotype 当前的环境
 */
+ (void)addModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype;


/**
 删除一个数据

 @param model model
 @param envirotype 当前的环境
 */
+ (void)deleteModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype;



/**
 更新一个数据源

 @param model 模型
 @param envirotype 当前的环境
 */
+ (void)updateModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype;


/**
 查找一个数据源

 @param modelID 模型ID
 @param envirotype 当前的环境
 @return 返回查找的结果
 */
+ (NSArray*)selectModelWithId:(NSString*)modelID andEnviromentType:(ACFaceSDKEnviromentType)envirotype;



/**
 反序列化素材数据

 @return 返回数组
 */
+ (NSArray *)unArchiverFaceSeriasandEnviromentType:(ACFaceSDKEnviromentType)envirotype ;


/**
 序列号素材数据

 @param dataArray 素材数据
 @return 是否序列号成功
 */
+ (BOOL)archiverFaceSeriasWith:(NSArray *)dataArray andEnviromentType:(ACFaceSDKEnviromentType)envirotype;

/**
 清空本地的数据

 @return 返回是否清空完成
 */
+ (BOOL)cleanUpLocalSeriasAndEnviromentType:(ACFaceSDKEnviromentType)envirotype ;
@end
