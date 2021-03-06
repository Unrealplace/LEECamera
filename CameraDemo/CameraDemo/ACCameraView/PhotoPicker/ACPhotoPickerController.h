//
//  PhotoPickerVC.h
//  ArtCamera
//
//  Created by NicoLin on 2016/11/25.
//  Copyright © 2016年 NicoLin. All rights reserved.
//

@import Photos;

typedef void(^photoPickerHandler)(UIImage * photo);

@class ACPhotoPickerController;

@protocol ACCameraSelectDelegate <NSObject>
- (void)cameraPhotoPickerController:(ACPhotoPickerController*)controller ;

@end


@interface ACPhotoPickerController : UIViewController

@property (nonatomic, assign) CGSize maximumSize; //选中图片最大尺寸，默认为2048*2048

//选图回调
- (void)selectPhotoWithPickAction:(photoPickerHandler)pickAction;

@property (nonatomic,strong)id <ACCameraSelectDelegate> delegate ;



@end
