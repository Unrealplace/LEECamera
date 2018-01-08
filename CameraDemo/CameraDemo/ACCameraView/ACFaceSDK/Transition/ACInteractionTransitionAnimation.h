//
//  ACInteractionTransitionAnimation.h
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACInteractionTransitionAnimation : UIPercentDrivenInteractiveTransition
@property (assign , nonatomic) BOOL isActing;/** 判断动画正在进行中*/

-(void)writeToViewcontroller:(UIViewController *)toVc;/** 写入二级ViewController*/
@end