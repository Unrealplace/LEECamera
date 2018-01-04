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

@interface ACTintViewController ()

@property (nonatomic, strong) UIButton *enterBtn;

@end

@implementation ACTintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.enterBtn];
    self.enterBtn.ca_center = self.view.ca_center;
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    
    [[ACFaceSDK sharedSDK] setupEnterController:self];
    
//    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:pickerVC];
//    [navi setNavigationBarHidden:YES animated:NO];
//    [self.navigationController pushViewController:pickerVC animated:YES];
}

@end
