//
//  ACDownLoadTask.h
//  download-demo
//
//  Created by LiYang on 2018/1/6.
//  Copyright © 2018年 kan xu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum :NSInteger{
    ACDownLoadStatePause = 0,
    ACDownLoadStateDowning ,
    ACDownLoadStateSuccess,
    ACDownLoadStateFailed
}ACDownLoadState;

@interface ACDownLoadTask : NSObject

- (void)downLoadWithUrl:(NSString*)url
          SaveToPath:(NSString*)filePath
       callBackProgress:(void(^)(float progress)) progress
    downLoadState:(void(^)(ACDownLoadState state))stateChange
             Success:(void(^)(NSString * path,NSError* error))success;

- (void)cancelTask;
@end
