//
//  ACCameraNetWorking.h
//  Network
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ACRequestMethod) {
    ACPOST = 0,
    ACGET  = 1,
    ACPUT  = 2,
    ACHEAD = 3,
};

/**
 *  定义返回block
 */
typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);
@interface ACCameraNetWorking : NSObject

+ (void)withUrl:(NSString *)url
           body:(NSMutableDictionary *)body
           head:(NSMutableDictionary *)head
         method:(ACRequestMethod)method
        success:(SuccessBlock)success
        failure:(FailureBlock)failure;
@end
