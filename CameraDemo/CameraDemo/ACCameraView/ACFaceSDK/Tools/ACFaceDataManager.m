//
//  ACFaceDataManager.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceDataManager.h"
#import "ZipArchive.h"
#import "ACFaceModel.h"
#import "ACArchiverManager.h"
#import "ACFaceSDK.h"

NSString * const CAMERA_SERIAS_PATH = @"CameraSerias";


@implementation ACFaceDataManager

+ (void)compressionCameraSeriasWithPath:(NSString *)cameraSeriasPath {
    
    NSString *defaultSeriesPath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:cameraSeriasPath];
    //可能不止一个压缩包
    NSArray *series = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:defaultSeriesPath error:nil];
    NSMutableArray * dataArray = [NSMutableArray array];
    
    if (series){
        for (int i =0 ; i<series.count; i++) {
            NSString * fileName = series[i];
            // 去除.zip后缀得到的压缩包文件
            NSString *zipfileName = [[fileName componentsSeparatedByString:@"."] firstObject];
            // 用于存储解压缩文件的文件主目录
            NSString *savedPath = [[self storedSeriesPath].absoluteString stringByAppendingPathComponent:zipfileName];
            // 将要读取的文件的地址
            if ([self hadCompressionAtPath:savedPath]) continue;
            NSString *seriesPath = [defaultSeriesPath stringByAppendingPathComponent:fileName];
            // 创建解压对象
            ZipArchive *zip = [[ZipArchive alloc] init];
            if ([zip UnzipOpenFile:seriesPath]){
                if ([zip UnzipFileTo:savedPath overWrite:YES]){
                    // 可能会生成__MACOSX文件,过滤
                    NSString *seriesName = [NSString new];
                    NSArray *fileNameTemps = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:savedPath error:nil];
                    for (NSString *file in fileNameTemps){
                        if (![file isEqualToString:@"__MACOSX"]){
                            seriesName = file;
                        }
                    }
                    // 解压缩后得到的文件数据,主要获取bundle.json
//                    NSString *bundlePath = [[savedPath stringByAppendingPathComponent:seriesName] stringByAppendingPathComponent:@"bundle.json"];
//                    NSData *data = [NSData dataWithContentsOfFile:bundlePath];
                    ACFaceModel * model = [[ACFaceModel alloc] init];
                    model.name = @"oliver";
                    model.faceId = 12345;
                    model.fileName = seriesName;
                    model.isDefautSet = YES;
                    [dataArray addObject:model];
//                    if (data){
//                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                        // 存储数据
//                    }
                }
            }
            [zip UnzipCloseFile];
            [ACArchiverManager archiverFaceSeriasWith:dataArray andEnviromentType:[[ACFaceSDK sharedSDK]enriroType]];
            
        }
    }
}

// 从路径中获得完整的文件名（带后缀）
//exestr = [filePath lastPathComponent];
//NSLog(@"%@",exestr);
//// 获得文件名（不带后缀）
//exestr = [exestr stringByDeletingPathExtension];
//NSLog(@"%@",exestr);
//
//// 获得文件的后缀名（不带'.'）
//exestr = [filePath pathExtension];
//NSLog(@"%@",exestr);
//
+ (void)compressionItemAtPath:(NSString*)itemPath {
    //可能不止一个压缩包
   
    NSString * fileName = [itemPath lastPathComponent];
    // 去除.zip后缀得到的压缩包文件
    NSString * zipfileName = [[fileName componentsSeparatedByString:@"."] firstObject];
    NSString *savedPath = [[self storedSeriesPath].absoluteString stringByAppendingPathComponent:zipfileName];
    ZipArchive *zip = [[ZipArchive alloc] init];
    if ([zip UnzipOpenFile:itemPath]){
        if ([zip UnzipFileTo:savedPath overWrite:YES]){
            // 可能会生成__MACOSX文件,过滤
            NSString *seriesName = [NSString new];
            NSArray *fileNameTemps = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:savedPath error:nil];
            for (NSString *file in fileNameTemps){
                if (![file isEqualToString:@"__MACOSX"]){
                    seriesName = file;
                }
            }
            // 解压缩后得到的文件数据,主要获取bundle.json
            //                    NSString *bundlePath = [[savedPath stringByAppendingPathComponent:seriesName] stringByAppendingPathComponent:@"bundle.json"];
            ACFaceModel * model = [[ACFaceModel alloc] init];
            model.name = @"oliver";
            model.faceId = 123345;
            model.fileName = seriesName;
            model.isDownload = YES;
            [ACArchiverManager addModelWith:model andEnviromentType:[ACFaceSDK sharedSDK].enriroType];
        }
    }
    
}

+ (BOOL)hadCompressionAtPath:(NSString*)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator<NSString *> * myDirectoryEnumerator;
    myDirectoryEnumerator=  [fileManager enumeratorAtPath:filePath];
    int fileNum = 0;
    while (filePath = [myDirectoryEnumerator nextObject]) {
        for (NSString * namePath in filePath.pathComponents) {
            NSLog(@"-----AAA-----%@", namePath  );
            fileNum++;
        }
    }
    return fileNum>=1?YES:NO;
}
+ (NSURL *)storedSeriesPath
{
    
    NSString *directoryName = [self directoryNameWithNetworkType:[[ACFaceSDK sharedSDK] enriroType]];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL * pathUrl = [NSURL URLWithString:[[path stringByAppendingPathComponent:directoryName] stringByAppendingPathComponent:CAMERA_SERIAS_PATH]];
    return pathUrl;
}

+ (NSString *)directoryNameWithNetworkType:(ACFaceSDKEnviromentType)enriroType
{
    switch (enriroType)
    {
        case ACFaceSDKEnviromentTypeDebug:
        {
            return @"AllDebug";
        }
            break;
        case ACFaceSDKEnviromentTypeRelease:
        {
            return @"AllOnline";
        }
            break;
            
        default:
            break;
    }
    return @"Unknow";
}
@end
