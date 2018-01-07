//
//  ACProgressHUD.h
//  ArtCameraPro
//
//  Created by NicoLin on 2017/8/16.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ACProgressHUDAnimateEffect) {
    ACProgressHUDAnimateEffectNormal,
    ACProgressHUDAnimateEffectFast,
    ACProgressHUDAnimateEffectSlow
};

@interface ACProgressHUD : UIView

//显示label
+ (void)showWithContents:(NSString *)contents;

//label显示中心，默认为屏幕中心
+ (void)showWithContents:(NSString *)contents position:(CGPoint)position;

+ (void)showWithContents:(NSString *)contents animateEffect:(ACProgressHUDAnimateEffect)animateEffect;

+ (void)showWithContents:(NSString *)contents position:(CGPoint)position animateEffect:(ACProgressHUDAnimateEffect)animateEffect;



//显示等待动画
+ (void)showProgress;

+ (void)showProgressWithPosition:(CGPoint)position;

//默认允许用户交互
+ (void)showProgressWithAllowUserInteraction:(BOOL)userInteraction;

+ (void)showProgressWithPosition:(CGPoint)position allowUserInteraction:(BOOL)userInteraction;

+ (void)dismissProgress;

@end
