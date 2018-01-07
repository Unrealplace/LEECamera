//
//  ACBaseModel.m
//  CameraDemo
//
//  Created by LiYang on 2018/1/7.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACBaseModel.h"
#import <objc/runtime.h>

@interface ACBaseModel ()<NSCoding>

@end
@implementation ACBaseModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        u_int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(properties);
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(properties);
}
@end
