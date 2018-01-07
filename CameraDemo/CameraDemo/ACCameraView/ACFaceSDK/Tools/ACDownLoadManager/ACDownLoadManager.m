//
//  ACDownLoadManager.m
//  download-demo
//
//  Created by LiYang on 2018/1/6.
//  Copyright © 2018年 kan xu. All rights reserved.
//

#import "ACDownLoadManager.h"

#include <CommonCrypto/CommonCrypto.h>
@interface NSString (AC_MD5)
- (NSString*)ac_md5String;
@end

@implementation NSString (AC_MD5)
- (NSString*)ac_md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
@interface ACDownLoadManager()
@property (nonatomic, copy) NSString    *filePath;

@end

@implementation ACDownLoadManager

+ (instancetype)shareInstance {
    static ACDownLoadManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ACDownLoadManager alloc] init];
        manager.downLoadPool = [NSMutableDictionary dictionary];
    });
    return manager;
}

- (void)downLoadWithUrl:(NSString *)url
          andSaveToPath:(NSString*)filePath
       callBackProgress:(void (^)(float))progress
    downLoadStateChange:(void (^)(ACDownLoadState))stateChange
             andSuccess:(void (^)(NSString *, NSError *))success{
    
    ACDownLoadTask * downloadTask = [self.downLoadPool objectForKey:url.ac_md5String];
    if (!downloadTask) {
        downloadTask = [[ACDownLoadTask alloc] init];
        [self.downLoadPool setObject:downloadTask forKey:url.ac_md5String];
    }
    [downloadTask downLoadWithUrl:url
                       SaveToPath:filePath
                 callBackProgress:progress
                    downLoadState:stateChange
                          Success:success];
    
    
}

- (void)stopDownLoadWithUrl:(NSString*)url{
    
}

- (void)cancelDownLoadWithUrl:(NSString*)url{
    
    ACDownLoadTask * downloadTask = [self.downLoadPool objectForKey:url.ac_md5String];
    if (downloadTask) {
        [downloadTask cancelTask];
        [self.downLoadPool removeObjectForKey:url.ac_md5String];
    }
    [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    
}

- (void)resumeDownLoadWithUrl:(NSString*)url{
    
}

- (void)deleteAllDownLoad{
    
}
@end
