//
//  AWE_SaveImage.h
//  NicoLin
//
//  Created by NicoLin on 5/24/16.
//  Copyright © 2016 林凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^saveImageHandler)(BOOL isCompeleted,NSString * status,NSDictionary * imgInfo);

@interface ACSaveImageUtil : NSObject

+ (void)saveImage:(UIImage *)image compeleted:(saveImageHandler)saveImageHandler;

@end
