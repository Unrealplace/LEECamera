//
//  ACDownLoadManager.h
//  download-demo
//
//  Created by LiYang on 2018/1/6.
//  Copyright © 2018年 kan xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACDownLoadTask.h"

@interface ACDownLoadManager : NSObject

@property (nonatomic, strong) NSMutableDictionary    *downLoadPool;

+ (instancetype)shareInstance;

- (void)downLoadWithUrl:(NSString*)url
          andSaveToPath:(NSString*)filePath
       callBackProgress:(void(^)(float progress)) progress
    downLoadStateChange:(void(^)(ACDownLoadState state))stateChange
             andSuccess:(void(^)(NSString * path,NSError* error))success;

- (void)stopDownLoadWithUrl:(NSString*)url;

- (void)cancelDownLoadWithUrl:(NSString*)url;

- (void)resumeDownLoadWithUrl:(NSString*)url;

- (void)deleteAllDownLoad;


@end
