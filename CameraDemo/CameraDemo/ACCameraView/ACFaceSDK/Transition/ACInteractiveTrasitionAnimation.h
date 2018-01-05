//
//  ACInteractiveTrasitionAnimation.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ACInteractiveTrasitionAnimation : NSObject <UIViewControllerInteractiveTransitioning>

@property (assign , nonatomic) BOOL isActing;/** 判断动画正在进行中*/

-(void)writeToViewcontroller:(UIViewController *)toVc;/** 写入二级ViewController*/

- (void)updateInteractiveTransition:(CGFloat)percentComplete;/** 更新交互进度*/

- (void)cancelInteractiveTransition;/** 取消切换*/

- (void)finishInteractiveTransition;/** 完成切换*/

@end
