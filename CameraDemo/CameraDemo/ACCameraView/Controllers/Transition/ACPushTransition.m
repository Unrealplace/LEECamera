//
//  ACPushTransition.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACPushTransition.h"
#import "ACFaceSDK.h"

@implementation ACPushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3f;
    
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVc    = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds             = [[UIScreen mainScreen] bounds];
    
   
    
    toVC.view.frame = CGRectOffset(finalFrameForVc, 0, bounds.size.height);

    [[transitionContext containerView] addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0.8;
        toVC.view.frame = finalFrameForVc;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha = 1.0;
    }];
   
    
    
}

//第一个方法返回的是动画时间，不做多言。
//
//第二个方法是动画的具体执行，方法的参数transitionContext遵守了UIViewControllerContextTransitioning协议，所以它包含了许多关于专场所需要的内容，包括转入ViewController和转出Viewcontroller，还有动画容器View--containerView等。
//
//我们点进去UIViewControllerContextTransitioning协议，可以找到许多的属性和方法，这些方法中最重要的几个方法和意义如下：
//
//- (UIView*)containerView;                                                          //获取容器View
//
//- (void)completeTransition:(BOOL)didComplete;                     //通过此参数获知动画是否结束
//
//- (UIViewController*)viewControllerForKey:(NSString*)key;  //获取转入、转出VC
//
//- (CGRect)initialFrameForViewController:(UIViewController*)vc   //获取动画前VC的frame
//
//- (CGRect)finalFrameForViewController:(UIViewController*)vc;    //获取动画后VC的frame


@end
