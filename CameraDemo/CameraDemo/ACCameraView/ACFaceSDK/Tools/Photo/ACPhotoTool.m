//
//  ACPhotoToll.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACPhotoTool.h"
#import "ALAsset+AC.h"
#import "ALAssetsLibrary+AC.h"
#import "PHAsset+AC.h"
#define Album @"图片合成器"

@implementation ACPhotoTool
+ (void)latestAsset:(ACPhotoCallBack _Nullable)callBack {
    NSLog(@"system -- %@",[UIDevice currentDevice].systemVersion);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {//判断适配
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                PHAsset *asset = [PHAsset latestAsset];
                // 在资源的集合中获取第一个集合，并获取其中的图片
                if (asset) {
                    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
                    [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                        ACAsset *a = nil;
                        if (imageData) {
                            UIImage * image = [UIImage imageWithData:imageData];
                            a = [[ACAsset alloc]initWithPHAsset:asset image:image];
                        }
                        if (callBack) {
                            callBack(a);
                        }
                    }];
                } else {
                    if (callBack) {
                        callBack(nil);
                    }
                }
            } else {
                NSLog(@"status %ld",(long)status);
                if (callBack) {
                    callBack(nil);
                }
            }
        }];
    } else {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
        [library latestAsset:^(ALAsset * _Nullable asset, NSError * _Nullable error) {
            ACAsset *a = nil;
            if (asset) {
                a = [[ACAsset alloc]initWithALAsset:asset];
            } else {
                NSLog(@"---- %@",error.localizedDescription);
            }
            if (callBack) {
                callBack(a);
            }
        }];
    }
}





+ (void)saveImage:(UIImage *)image compeleted:(ACSaveImageHandler)saveImageHandler {
    if (!image) {
        if (saveImageHandler) {
            saveImageHandler(NO,@"未能成功生成图片",nil);
        }
    }
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        if (saveImageHandler) {
            saveImageHandler(NO,@"家长控制,不允许访问",nil);
        }
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        if (saveImageHandler) {
            saveImageHandler(NO,@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关",nil);
        }
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        //获取手机照片库
        [self saveImageToAlbum:image compeleted:^(BOOL isCompeleted, NSString * status , NSDictionary * imgInfo) {
            if (saveImageHandler) {
                saveImageHandler(isCompeleted,status,imgInfo);
            }
        }];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                //获取手机照片库
                [self saveImageToAlbum:image compeleted:^(BOOL isCompeleted, NSString * status , NSDictionary * imgInfo) {
                    if (saveImageHandler) {
                        saveImageHandler(isCompeleted,status,imgInfo);
                    }
                }];
            }
            else {
                if (saveImageHandler) {
                    saveImageHandler(NO,@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关",nil);
                }
            }
        }];
    }
}


/**
 *  返回相册
 */
+ (PHAssetCollection *)collection
{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:Album]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    PHAssetCollection *createdCollection = nil;
    NSError *error = nil;
    __block NSString *createdCollectionID;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        //创建一个相册,拿到相册的唯一标识符
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:Album].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (!createdCollectionID) {
        return nil;
    }
    
    //根据相册的唯一标识符拿到相册
    createdCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
    
    if (error) {
        //保存失败
        return nil;
    }else{
        //保存成功
        return createdCollection;
    }
}


/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
+ (void)saveImageToAlbum:(UIImage *)image compeleted:(ACSaveImageHandler)saveImageHandler
{
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    __block NSString *assetId = nil;
    
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        // 返回PHAsset(图片)的字符串标识
        assetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (error || !assetId) {
            if (saveImageHandler) {
                saveImageHandler(NO,@"保存图片到相机胶卷中失败",@{@"imageAssetId" : assetId});
            }
            return;
        }
        
        NSLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collection];
        
        if (!collection) {
            if (saveImageHandler) {
                saveImageHandler(NO,@"添加图片到相册中失败",@{@"imageAssetId" : assetId});
            }
            return;
        }
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                if (saveImageHandler) {
                    saveImageHandler(NO,@"添加图片到相册中失败",@{@"imageAssetId" : assetId});
                }
                return;
            }
            if (saveImageHandler) {
                saveImageHandler(YES,@"成功添加图片到相册中",@{@"imageAssetId" : assetId});
            }
        }];
    }];
}

@end
