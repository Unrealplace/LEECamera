//
//  ACArchiverManager.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACArchiverManager.h"
#import "ACFileManager.h"

 NSString   * const  DEBUG_PATH   = @"debug.archiver";
 NSString   * const RELEASE_PATH  = @"release.archiver";

@implementation ACArchiverManager


/**
 增加一个数据
 
 @param model model
 @param envirotype 当前的环境
 */
+ (void)addModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype {
    NSArray * arr = [self unArchiverFaceSeriasandEnviromentType:envirotype];
    NSMutableArray * copyArr = arr.mutableCopy;
    [copyArr addObject:model];
    [self archiverFaceSeriasWith:copyArr andEnviromentType:envirotype];
}


/**
 删除一个数据
 
 @param model model
 @param envirotype 当前的环境
 */
+ (void)deleteModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype {
    NSArray * arr = [self unArchiverFaceSeriasandEnviromentType:envirotype];
    NSMutableArray * copyArr = arr.mutableCopy;
    NSInteger index = 0;
    BOOL have = NO;
    for (NSInteger i = 0; i<copyArr.count; i++) {
        ACFaceModel * oneModel = copyArr[i];
        if (oneModel.faceId == model.faceId) {
            index = i;
            have  = YES;
        }
    }
    if (have) {
        [copyArr removeObjectAtIndex:index];
    }
    [self archiverFaceSeriasWith:copyArr andEnviromentType:envirotype];
    
}



/**
 更新一个数据源
 
 @param model 模型
 @param envirotype 当前的环境
 */
+ (void)updateModelWith:(ACFaceModel*)model andEnviromentType:(ACFaceSDKEnviromentType)envirotype {
    NSArray * arr = [self unArchiverFaceSeriasandEnviromentType:envirotype];
    NSMutableArray * copyArr = arr.mutableCopy;
    for (int i = 0; i<copyArr.count; i++) {
        ACFaceModel * oneModel = copyArr[i];
        if (oneModel.faceId == model.faceId) {
            copyArr[i] = model;
        }
    }
    [self archiverFaceSeriasWith:copyArr andEnviromentType:envirotype];
    
}


/**
 查找一个数据源
 
 @param modelID 模型ID
 @param envirotype 当前的环境
 @return 返回查找的结果
 */
+ (NSArray*)selectModelWithId:(NSString*)modelID andEnviromentType:(ACFaceSDKEnviromentType)envirotype {
    
    NSArray * arr = [self unArchiverFaceSeriasandEnviromentType:envirotype];
    
    for (ACFaceModel * model in arr) {
        if (model.faceId == modelID.integerValue) {
            return @[model];
        }
    }
    return nil;
}



+ (NSArray *)unArchiverFaceSeriasandEnviromentType:(ACFaceSDKEnviromentType)envirotype {
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:[[ACFileManager cameraDocumentPath]stringByAppendingPathComponent:envirotype==ACFaceSDKEnviromentTypeDebug?DEBUG_PATH:RELEASE_PATH]];
    return arr;
}

+ (BOOL)archiverFaceSeriasWith:(NSArray *)dataArray andEnviromentType:(ACFaceSDKEnviromentType)envirotype{
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSFileManager defaultManager] removeItemAtPath:[[ACFileManager cameraDocumentPath]stringByAppendingPathComponent:envirotype==ACFaceSDKEnviromentTypeDebug?DEBUG_PATH:RELEASE_PATH] error:nil];
        BOOL isSave = NO;
        do{
            isSave =  [NSKeyedArchiver archiveRootObject:dataArray toFile:[[ACFileManager cameraDocumentPath]stringByAppendingPathComponent:envirotype==ACFaceSDKEnviromentTypeDebug?DEBUG_PATH:RELEASE_PATH]];
        }while (!isSave);
    });
    return YES;
}

+ (BOOL)cleanUpLocalSeriasAndEnviromentType:(ACFaceSDKEnviromentType)envirotype {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:STORE_FACE_SERAES_DEBUG_KEY];
//    return [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}
@end
