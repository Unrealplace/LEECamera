//
//  ACFaceModel.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceModel.h"
#import "ACFaceDataManager.h"

@interface ACFaceModel()<NSCoding>

@end

@implementation ACFaceModel

- (id)initWithCoder:(NSCoder *)aDecoder {
   
    if ([self init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.faceID = [aDecoder decodeIntegerForKey:@"faceID"];
        self.fileName = [aDecoder decodeObjectForKey:@"fileName"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.faceID forKey:@"faceID"];
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
    
}

- (UIImage*)iconImage {
    NSString *path       = [ACFaceDataManager storedSeriesPath].absoluteString;
    NSString *seriesName = [NSString new];
    NSArray *fileNameTemps = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[path stringByAppendingPathComponent:self.fileName]  error:nil];
    for (NSString *file in fileNameTemps)
    {
        if (![file isEqualToString:@"__MACOSX"])
        {
            seriesName = file;
        }
    }
    NSString *filePath = [[[path stringByAppendingPathComponent:self.fileName]  stringByAppendingPathComponent:seriesName] stringByAppendingPathComponent:@"preImage.jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image)
    {
        return image;
    }
    else{
        return nil;
    }

}
- (UIImage*)showImage {
    NSString *path       = [ACFaceDataManager storedSeriesPath].absoluteString;
    NSString *seriesName = [NSString new];
    NSArray *fileNameTemps = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[path stringByAppendingPathComponent:self.fileName]  error:nil];
    for (NSString *file in fileNameTemps)
    {
        if (![file isEqualToString:@"__MACOSX"])
        {
            seriesName = file;
        }
    }
    NSString *filePath = [[[path stringByAppendingPathComponent:self.fileName]  stringByAppendingPathComponent:seriesName] stringByAppendingPathComponent:self.showImg];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image)
    {
        return image;
    }
    else{
        return nil;
    }
}


@end
