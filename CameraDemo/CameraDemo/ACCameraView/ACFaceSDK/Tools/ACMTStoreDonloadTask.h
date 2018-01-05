//
//  ACMTStoreDonloadTask.h
//  ArtCameraPro
//
//  Created by BeautyHZ on 2017/10/10.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^downloadProgress)(double progress);//test

@interface ACMTStoreDonloadTask : NSObject

//下载进度block
@property (nonatomic, copy) downloadProgress downloadProgressBlock;

//根据url下载
- (void)downloadWithUrl:(NSString *)url;

//手动取消下载
- (void)cencel;

@end
