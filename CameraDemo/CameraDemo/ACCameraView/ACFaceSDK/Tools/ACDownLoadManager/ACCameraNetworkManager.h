//
//  ACCameraNetworkManager.h
//  Network
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACCameraNetWorking.h"
/**
 *  定义返回block
 */
typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);

@interface ACCameraNetworkManager : NSObject

@end


@interface POST : ACCameraNetWorking

/**
 *  POST请求（不需要修改请求头）
 *
 *  @param url     请求地址
 *  @param body    请求体
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)withUrl:(NSString *)url
           body:(NSMutableDictionary *)body
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;
/**
 *  POST请求（自定义请求头）
 *
 *  @param url     请求地址
 *  @param body    请求体
 *  @param head    请求头
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)withUrl:(NSString *)url
           body:(NSMutableDictionary *)body
           head:(NSMutableDictionary *)head
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;

@end

@interface GET : ACCameraNetWorking

/**
 *  GET请求（不需要修改请求头）
 *
 *  @param url     请求地址
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)withUrl:(NSString *)url
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;
/**
 *  GET请求（自定义请求头）
 *
 *  @param url     请求地址
 *  @param head    请求头
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)withUrl:(NSString *)url
           head:(NSMutableDictionary *)head
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;
@end

