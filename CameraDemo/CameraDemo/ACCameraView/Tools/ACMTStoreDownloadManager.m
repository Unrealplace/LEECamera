//
//  ACMTStoreDownloadManager.m
//  ArtCameraPro
//
//  Created by BeautyHZ on 2017/10/10.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACMTStoreDownloadManager.h"
#import "ACMTStoreDonloadTask.h"
#import "ACFileManager.h"
#include <CommonCrypto/CommonCrypto.h>

@interface NSString (Camera_MD5)
- (NSString *)Camera_md5String ;
@end

@implementation NSString (Camera_MD5)
- (NSString *)Camera_md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@interface ACMTStoreDownloadManager()

@end

@implementation ACMTStoreDownloadManager


+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static ACMTStoreDownloadManager *downloader = nil;
    dispatch_once(&onceToken, ^{
        downloader = [[ACMTStoreDownloadManager alloc] init];
        downloader.downloadPool = [NSMutableDictionary dictionary];
    });
    
    return downloader;
}

- (void)downloadWithUrl:(NSString *)url currentProgress:(void(^)(double progress))currentProgress
{
    ACMTStoreDonloadTask *downloadTask = [self.downloadPool objectForKey:url.Camera_md5String];
    if (!downloadTask) {
        //下载任务
        downloadTask = [[ACMTStoreDonloadTask alloc] init];
        [self.downloadPool setObject:downloadTask forKey:url.Camera_md5String];
    }
    downloadTask.downloadProgressBlock = currentProgress;
    [downloadTask downloadWithUrl:url];
    
}

- (void)cancelDownloadWithUrl:(NSString *)url {
    ACMTStoreDonloadTask *downloadTask = [self.downloadPool objectForKey:url.Camera_md5String];
    if (downloadTask) {
        [downloadTask cencel];
        [self.downloadPool removeObjectForKey:url.Camera_md5String];
        [[NSFileManager defaultManager] removeItemAtPath:[ACFileManager mtStoreDownloadTemPathWithUrl:url] error:nil];
    }
}

@end
