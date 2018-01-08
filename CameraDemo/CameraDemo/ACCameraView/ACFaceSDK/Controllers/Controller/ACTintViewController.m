//
//  ACTintViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/4.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACTintViewController.h"
#import "ACCameraViewController.h"
#import "UIView+ACCameraFrame.h"
#import "ACFaceSDK.h"
#import "ACNavAnimation.h"

@interface ACTintViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *enterBtn;
@property (strong, nonatomic)ACPushTransition * pushAnimation;

@property (strong, nonatomic)ACPopTransition  * popAnimation;
@end

@implementation ACTintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.enterBtn];
    self.enterBtn.ca_center = self.view.ca_center;
    [self.naviView hiddenLeftBtn:NO centerBtnHidden:YES rightBtnHidden:YES];
    [self.view addSubview:self.naviView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (UIButton*)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterBtn.frame = CGRectMake(0, 0, 120, 44);
        _enterBtn.backgroundColor = [UIColor grayColor];
        [_enterBtn setTitle:@"换脸入口" forState:UIControlStateNormal];
        [_enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}
- (void)enterBtnClick:(UIButton*)btn {
    
    if ([[ACFaceSDK sharedSDK] isFirstLoad]) {
        NSLog(@"fisrt ----load");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[ACFaceSDK sharedSDK] setupTintAlertController:self];
        });
    }else {
        NSLog(@"not fisrt ----load");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[ACFaceSDK sharedSDK] setupTintAlertController:self];
        });
    }
    [[ACFaceSDK sharedSDK] enterToCamera:self];

}


- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType andCameraNaviView:(ACCameraNaviView *)naviView {
    if (touchType == ACCameraNaviViewTouchTypeLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - **************** Navgation delegate
/** 返回转场动画实例*/
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        if (![NSStringFromClass([[ACFaceSDK sharedSDK] currentPhotoCotroller]) isEqual:NSStringFromClass([toVC class])]) {
            return nil;
        }else {
            return self.pushAnimation;
        }
    }else if (operation == UINavigationControllerOperationPop){
        
        if (![NSStringFromClass([[ACFaceSDK sharedSDK] currentPhotoCotroller]) isEqual:NSStringFromClass([fromVC class])]){
            return nil;
        }else {
            return self.popAnimation;
        }
    }
    return nil;
}

-(ACPushTransition *)pushAnimation
{
    if (!_pushAnimation) {
        _pushAnimation = [[ACPushTransition alloc] init];
    }
    return _pushAnimation;
}
-(ACPopTransition *)popAnimation
{
    if (!_popAnimation) {
        _popAnimation = [[ACPopTransition alloc] init];
    }
    return _popAnimation;
}


@end
