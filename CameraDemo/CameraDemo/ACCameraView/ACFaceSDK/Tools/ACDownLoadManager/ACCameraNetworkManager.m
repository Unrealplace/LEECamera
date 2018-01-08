//
//  ACCameraNetworkManager.m
//  Network
//
//  Created by NicoLin on 2018/1/8.
//  Copyright © 2018年 andy. All rights reserved.
//

#import "ACCameraNetworkManager.h"

@implementation ACCameraNetworkManager

@end
@implementation POST

+ (void)withUrl:(NSString *)url
           body:(NSMutableDictionary *)body
        success:(SuccessBlock)success
        failure:(FailureBlock)failure {
    [ACCameraNetWorking withUrl:url
                     body:body
                     head:nil
                   method:ACPOST
                  success:^(id result) {
                      success(result);
                  }
                  failure:^(NSError *error) {
                      failure(error);
                  }];
}

+ (void)withUrl:(NSString *)url
           body:(NSMutableDictionary *)body
           head:(NSMutableDictionary *)head
        success:(SuccessBlock)success
        failure:(FailureBlock)failure {
    [ACCameraNetWorking withUrl:url
                     body:body
                     head:head
                   method:ACPOST
                  success:^(id result) {
                      success(result);
                  }
                  failure:^(NSError *error) {
                      failure(error);
                  }];
}

@end

@implementation GET

+ (void)withUrl:(NSString *)url
        success:(SuccessBlock)success
        failure:(FailureBlock)failure {
    [ACCameraNetWorking withUrl:url
                     body:nil
                     head:nil
                   method:ACGET
                  success:^(id result) {
                      success(result);
                  }
                  failure:^(NSError *error) {
                      failure(error);
                  }];
}

+ (void)withUrl:(NSString *)url
           head:(NSMutableDictionary *)head
        success:(SuccessBlock)success
        failure:(FailureBlock)failure {
    [ACCameraNetWorking withUrl:url
                     body:nil
                     head:head
                   method:ACGET
                  success:^(id result) {
                      success(result);
                  }
                  failure:^(NSError *error) {
                      failure(error);
                  }];
}

@end
