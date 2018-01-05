//
//  UIView+ACSnapshot.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACSnapshot)

@property (nonatomic, readonly) UIImage *snapshotImage;
@property (nonatomic, strong)   UIImage *contentImage;


@end
