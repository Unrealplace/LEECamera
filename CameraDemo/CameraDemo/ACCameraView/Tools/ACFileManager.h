//
//  ACFileManager.h
//  ArtCamera
//
//  Created by NicoLin on 2016/11/27.
//  Copyright © 2016年 NicoLin. All rights reserved.
//

#import "ACBaseFileManager.h"

@interface ACFileManager : ACBaseFileManager

/*
 *主页背景轮播图本地路径
 */
+ (NSArray *)homeBgImagesPath;

/*
 *素材压缩包文件夹在bundle中的地址
 */
+ (NSString *)defaultZipDirPath;

/*
 *遮罩素材所在文件夹bundle中地址
 */
+ (NSString *)thumbBlendModePicPathWithPicName:(NSString *)picName;

/*
 *遮罩素材所在文件夹bundle中地址
 */
+ (NSString *)maskPicPathWithPicName:(NSString *)picName;

/*
 *滤镜LUT素材所在文件夹bundle中地址
 */
+ (NSString *)filterPicPathWithPicName:(NSString *)picName;

/*
 *素材系列文件夹在sandBox中地址
 */
+ (NSString *)seriesDirPath;

+ (NSString *)seriesDebugDirPath;

/*
 *根据系列名得到解压后的地址
 */
+ (NSString *)seriesPathBySeriesName:(NSString *)seriesName;

/*
 *素材中心下载路径
 */
+ (NSString *)mtStoreDownloadTemPathWithUrl:(NSString *)url;

/*
 *素材中心推荐玩法本地缓存
 */
+ (NSString *)mtStoreRecommendSeriesJsonPath;

/*
 *素材中心推荐玩法详情本地缓存
 */
+ (NSString *)mtStoreRecommendSeriesDetailJsonPath;

/**
 首页商业广告本地缓存

 @return 首页商业广告本地缓存路径
 */
+ (NSString *)btnAdJsonPath;

/**
 个人中心商业广告本地缓存
 
 @return 个人中心Banner广告本地缓存路径
 */
+ (NSString *)bannerAdJsonPath;

/**
 个人中心广告本地缓存
 
 @return 个人中心Text文本广告本地缓存路径
 */
+ (NSString *)textAdJsonPath;

/**
 个人中心动态入口缓存
 
 @return 个人中心动态入口本地缓存路径
 */
+ (NSString *)beautyModulePath;


/**
 相机素材的内置缓存

 @return 相机素材内置缓存路径
 */
+ (NSString *)cameraSeriasZipPath;

/**
 相机素材正式环境文件夹地址

 @return  相机素材正式环境文件夹地址
 */
+ (NSString *)cameraSeriasDirPath;

/**
 相机素材测试环境的文件夹地址

 @return 相机素材测试环境的文件夹地址
 */
+ (NSString *)cameraSeriasDebugDirPath;


@end
