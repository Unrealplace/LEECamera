//
//  ACMTStoreDownloadManager.h
//  ArtCameraPro
//
//  Created by BeautyHZ on 2017/10/10.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACMTStoreDownloadManager : NSObject

//批量下载下载池
@property (nonatomic, strong) NSMutableDictionary *downloadPool;

+ (instancetype)sharedManager;

/** 下载  */
- (void)downloadWithUrl:(NSString *)url currentProgress:(void(^)(double progress))currentProgress;

/** 取消下载 */
- (void)cancelDownloadWithUrl:(NSString *)url;

@end

