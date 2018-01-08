//
//  ACFileManager.m
//  ArtCamera
//
//  Created by NicoLin on 2016/11/27.
//  Copyright © 2016年 NicoLin. All rights reserved.
//

#import "ACFileManager.h"

NSString * const ACSeriesDir        = @"Series";        //素材系列在sandBox中的文件夹名
NSString * const ACSeriesDebugDir    = @"SeriesDebug";
NSString * const ACDefaultZip       = @"DefaultZip";   //初始化素材压缩包相对bundles地址
NSString * const ACMTStoreDownloadTemPath       = @"mtStoreDownloadTemPath";   //素材中心本地下载临时地址
NSString * const ACMTStoreRecommendSeriesDetailJsonPath      = @"ACMTStoreRecommendSeriesDetailJsonPath";   //素材中心推荐玩法详情Json
NSString * const ACMTStoreRecommendSeriesJson      = @"ACMTStoreRecommendSeriesJson";   //素材中心推荐玩法json
NSString * const ACBtnAdJson      = @"ACBtnAdJson";   //首页商业广告
NSString * const ACTextAdJson      = @"ACTextAdJson";   //个人中心文本广告
NSString * const ACBannerAdJson      = @"ACBannerAdJson";   //个人中心Banner广告
NSString * const ACBeautyModuleAdJson      = @"ACBeautyModuleAdJson";   //个人中心动态入口

NSString * const ACCameraSeriesZip        = @"ACCameraSeriesZip"; // 相机素材的压缩包bundles 地址
NSString * const ACCameraSeriesDir        = @"ACCameraSeriesDir"; // 相机素材的正式环境地址
NSString * const ACCameraSeriesDebugDir   = @"ACCameraSeriesDebugDir"; // 相机素材的测试环境地址


@implementation ACFileManager

/**
 相机素材的内置缓存
 
 @return 相机素材内置缓存路径
 */
+ (NSString *)cameraSeriasZipPath {
    return [ACFileManager pathForMainBundleDirectoryWithPath:ACCameraSeriesZip];
}

/**
 相机素材正式环境文件夹地址
 
 @return  相机素材正式环境文件夹地址
 */
+ (NSString *)cameraSeriasDirPath {
    return [self pathForDocumentsDirectoryWithPath:ACCameraSeriesDir];
}

/**
 相机素材测试环境的文件夹地址
 
 @return 相机素材测试环境的文件夹地址
 */
+ (NSString *)cameraSeriasDebugDirPath {
    
    return [self pathForDocumentsDirectoryWithPath:ACCameraSeriesDebugDir];
}



/*
 *主页背景轮播图本地路径
 */
+ (NSArray *)homeBgImagesPath {
    NSArray *sortImgs = [[ACFileManager listFilesInDirectoryAtPath:[ACFileManager pathForMainBundleDirectoryWithPath:@"HomeBgImages"]] sortedArrayUsingComparator:^NSComparisonResult(NSString *path1, NSString *path2) {
        
        return (NSComparisonResult)[path1 compare:path2 options:NSNumericSearch];
    }];
   return sortImgs;
}

/*
 *素材压缩包文件夹在bundle中的地址
 */
+ (NSString *)defaultZipDirPath
{
    return [ACFileManager pathForMainBundleDirectoryWithPath:ACDefaultZip];
}

/*
 *遮罩素材所在文件夹bundle中地址
 */
+ (NSString *)thumbBlendModePicPathWithPicName:(NSString *)picName {
    
    return [[ACFileManager pathForMainBundleDirectoryWithPath:@"BlendModes"] stringByAppendingPathComponent:picName];
}

/*
 *遮罩素材所在文件夹bundle中地址
 */
+ (NSString *)maskPicPathWithPicName:(NSString *)picName {
    
    return [[ACFileManager pathForMainBundleDirectoryWithPath:@"Masks"] stringByAppendingPathComponent:picName];
}

/*
 *滤镜素材所在文件夹bundle中地址
 */
+ (NSString *)filterPicPathWithPicName:(NSString *)picName {
    
   return [[ACFileManager pathForMainBundleDirectoryWithPath:@"Filters"] stringByAppendingPathComponent:picName];
}

/*
 *素材系列文件夹在sandBox中地址
 */
+ (NSString *)seriesDirPath
{
    return [self pathForDocumentsDirectoryWithPath:ACSeriesDir];
}

+ (NSString *)seriesDebugDirPath
{
    return [self pathForDocumentsDirectoryWithPath:ACSeriesDebugDir];
}

/*
 *根据系列名得到解压后的地址 adnonstop
 */
+ (NSString *)seriesPathBySeriesName:(NSString *)seriesName
{
    return [self pathForDocumentsDirectoryWithPath:[NSString stringWithFormat:@"%@/%@",ACSeriesDir,seriesName]];
}

+ (NSString *)mtStoreDownloadTemPathWithUrl:(NSString *)url
{
    NSString *suffix = [[url componentsSeparatedByString:@"/"].lastObject stringByReplacingOccurrencesOfString:@".zip" withString:@""];
    return [self pathForDocumentsDirectoryWithPath:[NSString stringWithFormat:@"%@/",suffix]];
}

+ (NSString *)mtStoreRecommendSeriesJsonPath
{
    return [self pathForDocumentsDirectoryWithPath:ACMTStoreRecommendSeriesJson];
}

+ (NSString *)mtStoreRecommendSeriesDetailJsonPath
{
    return [self pathForDocumentsDirectoryWithPath:ACMTStoreRecommendSeriesDetailJsonPath];
}

+ (NSString *)btnAdJsonPath
{
    return [self pathForDocumentsDirectoryWithPath:ACBtnAdJson];
}

+ (NSString *)textAdJsonPath
{
    return [self pathForDocumentsDirectoryWithPath:ACTextAdJson];
}

+ (NSString *)bannerAdJsonPath
{
    return [self pathForDocumentsDirectoryWithPath:ACBannerAdJson];
}

+ (NSString *)beautyModulePath
{
    return [self pathForDocumentsDirectoryWithPath:ACBeautyModuleAdJson];
}

+ (NSString*)cameraDocumentPath {
    return [self pathForDocumentsDirectory];
}
@end
