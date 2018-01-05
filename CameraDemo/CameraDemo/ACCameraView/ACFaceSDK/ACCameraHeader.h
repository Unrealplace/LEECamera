//
//  ACCameraHeader.h
//  CameraDemo
//
//  Created by NicoLin on 2017/12/28.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#ifndef ACCameraHeader_h
#define ACCameraHeader_h


#endif /* ACCameraHeader_h */
//RGBA颜色基础宏
#define ACCAMERA_RGBAColor(r,g,b,a)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ACCAMERA_ACRGBColor(r,g,b)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0f)]
#define ACCAMERA_ACBlackColor(h)                 [UIColor colorWithRed:(h)/255.0 green:(h)/255.0 blue:(h)/255.0 alpha:(1.0f)]

#define ACCAMERA_SCREEN_BOUNDS                   [[UIScreen mainScreen] bounds]
#define ACCAMERA_SCREEN_SIZE                     [[UIScreen mainScreen] bounds].size
#define ACCAMERA_SCREEN_SCALE                    [UIScreen  mainScreen].scale
#define ACCAMERA_SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define ACCAMERA_SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height



//是否为pad
#define ACCAMERA_DeviceIsPad                     [UIDevice currentDevice].isPad
#define ACCAMERA_DeviceIsX                       (ACCAMERA_SCREEN_HEIGHT == 812.0f)

//适配

#define ACCAMERA_NAVI_TOP_PADDING                (ACCAMERA_DeviceIsX ? 44.0f : 0.0f)
#define ACCAMERA_NAVI_HEIGHT                     (ACCAMERA_DeviceIsX ? 60.0f : 44.0f)
#define ACCAMERA_EDIT_BOTTOM_PADDING             (ACCAMERA_DeviceIsX ? 34.0f : 0.0f)


//字体
#define ACCAMERA_ACFont(size)                       [UIFont systemFontOfSize:size]
#define ACCAMERA_ACBoldFont(size)                [UIFont boldSystemFontOfSize:size]
