//
//  ACDownLoadTask.m
//  download-demo
//
//  Created by LiYang on 2018/1/6.
//  Copyright © 2018年 kan xu. All rights reserved.
//

#import "ACDownLoadTask.h"
#import "ACFaceDataManager.h"
#import "ACFaceSDK.h"

typedef void (^ACDownLoadProgressBlock)(float progress);
typedef void (^ACSuccessBlock)(NSString * filePath,NSError * error);
typedef void (^ACStateChangeBlock)(ACDownLoadState state);
NSString * const DOWN_LOAD_DIR_DEBUG = @"DownLoad_Debug";
NSString * const DOWN_LOAD_DIR_RELEASE = @"DownLoad_Release";

@interface ACDownLoadTask()<NSURLSessionDownloadDelegate>

@property (nonatomic, copy) ACSuccessBlock    successBlock;
@property (nonatomic, copy) ACDownLoadProgressBlock    progressBlock;
@property (nonatomic, copy) ACStateChangeBlock    stateBlock;
@property (nonatomic, copy) NSString    *saveFilePath;

@property (nonatomic, strong) NSURLSessionDownloadTask    *downloadTask;
@property (nonatomic, strong) NSURLSession    *session;


@end

@implementation ACDownLoadTask

- (void)downLoadWithUrl:(NSString *)url
             SaveToPath:(NSString *)filePath
       callBackProgress:(void (^)(float))progress
          downLoadState:(void (^)(ACDownLoadState))stateChange
                Success:(void (^)(NSString *, NSError *))success{
    self.successBlock = success;
    self.progressBlock = progress;
    self.stateBlock = stateChange;
    self.saveFilePath = filePath;
    
    NSURL * URL = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask * downloadTask = [self.session downloadTaskWithRequest:request];
    [downloadTask resume];
    self.downloadTask = downloadTask;
    
}

- (void)cancelTask {
    [self.downloadTask cancel];
}


#pragma mark NSURLSessionDownloadDelegate
/**
 *  写数据
 *
 *  @param session                   会话对象
 *  @param downloadTask              下载任务
 *  @param bytesWritten              本次写入的数据大小
 *  @param totalBytesWritten         下载的数据总大小
 *  @param totalBytesExpectedToWrite  文件的总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //1. 获得文件的下载进度
    self.progressBlock(1.0 * totalBytesWritten/totalBytesExpectedToWrite);
}

/**
 *  当恢复下载的时候调用该方法
 *
 *  @param fileOffset         从什么地方下载
 *  @param expectedTotalBytes 文件的总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__func__);
}

/**
 *  当下载完成的时候调用
 *
 *  @param location     文件的临时存储路径
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
   
    //1、生成的Caches地址
//    NSString *cacepath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:downloadTask.response.suggestedFilename];
    NSFileManager *manager = [NSFileManager defaultManager];
    self.saveFilePath = [self.saveFilePath stringByAppendingPathComponent:[ACFaceSDK sharedSDK].enriroType == ACFaceSDKEnviromentTypeDebug?DOWN_LOAD_DIR_DEBUG:DOWN_LOAD_DIR_RELEASE];
    
    BOOL isDir ;
    if (![manager fileExistsAtPath:self.saveFilePath isDirectory:&isDir]) {
        [manager createDirectoryAtPath:self.saveFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    self.saveFilePath = [self.saveFilePath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    if ([manager fileExistsAtPath:self.saveFilePath]) {
        self.successBlock(self.saveFilePath, nil);
        return;
    }
    //2、移动图片的存储地址
    NSError * error;
   BOOL isok =   [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:self.saveFilePath] error:&error];
    if (isok) {
        [ACFaceDataManager compressionItemAtPath:self.saveFilePath];
        self.successBlock(self.saveFilePath, nil);
    }else{
        self.successBlock(self.saveFilePath, error);
    }
}

/**
 *  请求结束
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    self.successBlock(self.saveFilePath, error);
}

@end
