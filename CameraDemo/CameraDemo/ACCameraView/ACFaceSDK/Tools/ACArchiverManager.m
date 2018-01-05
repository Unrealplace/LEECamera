//
//  ACArchiverManager.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACArchiverManager.h"

 NSString  * const  STORE_FACE_SERAS_KEY = @"STORE_FACE_SERAS_KEY";

@implementation ACArchiverManager

+ (NSArray *)unArchiverFaceSerias {
    NSData *data  = [[NSUserDefaults standardUserDefaults]objectForKey:STORE_FACE_SERAS_KEY];
    NSArray *arrt = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arrt;
}

+ (BOOL)archiverFaceSeriasWith:(NSArray *)dataArray {
   
    NSData *wData = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    [[NSUserDefaults standardUserDefaults]setObject:wData forKey:STORE_FACE_SERAS_KEY];
    return [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)cleanUpLocalSerias {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:STORE_FACE_SERAS_KEY];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
