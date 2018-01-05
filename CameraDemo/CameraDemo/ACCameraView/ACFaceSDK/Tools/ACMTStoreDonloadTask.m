//
//  ACMTStoreDonloadTask.m
//  ArtCameraPro
//
//  Created by BeautyHZ on 2017/10/10.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACMTStoreDonloadTask.h"
#import "AFNetworking.h"
#import "ACFileManager.h"

@interface ACMTStoreDonloadTask()

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation ACMTStoreDonloadTask


- (void)downloadWithUrl:(NSString *)url
{
    //下载任务
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.downloadTask = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgress.fractionCompleted != 1) {
            self.downloadProgressBlock(downloadProgress.fractionCompleted);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"下载成功缓存地址：%@", [ACFileManager mtStoreDownloadTemPathWithUrl:url]);
        return  [NSURL fileURLWithPath:[ACFileManager mtStoreDownloadTemPathWithUrl:url]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            self.downloadProgressBlock(1);
        } else {
            NSLog(@"下载失败：%@", error);
            self.downloadProgressBlock(-1);
        }
    }];
    [self.downloadTask resume];
}

- (void)cencel {
    [self.downloadTask cancel];
}

@end
