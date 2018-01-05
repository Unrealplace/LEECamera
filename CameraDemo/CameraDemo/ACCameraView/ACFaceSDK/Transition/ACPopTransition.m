//
//  ACPopTransition.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/5.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACPopTransition.h"
#import "ACFaceSDK.h"

@implementation ACPopTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3f;
    
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect bounds             = [[UIScreen mainScreen] bounds];


    toVc.view.frame           = [transitionContext containerView].bounds;
    fromVc.view.frame         = [transitionContext containerView].bounds;

    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:fromVc.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVc.view.transform = CGAffineTransformTranslate(fromVc.view.transform, 0, bounds.size.height); //平移
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
  
    
    
}
@end
