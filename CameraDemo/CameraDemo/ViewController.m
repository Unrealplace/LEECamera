//
//  ViewController.m
//  CameraDemo
//
//  Created by OliverLee on 2017/12/27.
//  Copyright © 2017年 OliverLee. All rights reserved.
//

#import "ViewController.h"
#import "ACPhotoPickerController.h"
#import "ACCameraViewController.h"
#import "ACOtherCameraViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ACPhotoPickerControllerDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray     *dataSource;
@property(nonatomic, strong)UINavigationController * navi;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CCCamera";
    self.dataSource = @[
                        @"SystemVC",
                        @"ACCameraViewController",
                        @"ACPhotoPickerController",
                        ];
    
    [self.view addSubview:self.tableView];

}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}



#pragma mark - UITableView DataSource   UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cameraCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
//        cell.textLabel.font = CD_HYXXK_FONT(20);
    }
    cell.textLabel.text = [[_dataSource[indexPath.section] componentsSeparatedByString:@"."] firstObject];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ACPhotoPickerController * pickerVC = [[ACPhotoPickerController alloc]init];
    pickerVC.maximumSize = CGSizeMake(1024, 1024);
    pickerVC.delegate = self;
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:pickerVC];
    [navi setNavigationBarHidden:YES animated:NO];
    [self presentViewController:navi animated:YES completion:nil];
    
    
//    ACOtherCameraViewController * other = [[ACOtherCameraViewController alloc] init];
//    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:other];
//    [self presentViewController:navi animated:YES completion:nil];

    
//    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(_dataSource[indexPath.section]) new]];
//
//    [self.navigationController pushViewController:[NSClassFromString(_dataSource[indexPath.section]) new] animated:YES];
    
//    [self presentViewController:navi animated:YES completion:^{
//
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//    }];
    
//        [self.navigationController pushViewController:[NSClassFromString(_dataSource[indexPath.section]) new] animated:YES];
}

- (void)photoPickerController:(ACPhotoPickerController *)controller
             withFunctionType:(ACFaceSDKFunctionType)functionType
         andCompletionHandler:(void (^)(UIImage *))compleationHandler {
    switch (functionType) {
        case ACFaceSDKFunctionTypeCameraUse:{
            ACCameraViewController * cameraVC = [ACCameraViewController new];
            [controller.navigationController pushViewController:cameraVC animated:YES];
            
        }
            break;
        case ACFaceSDKFunctionTypeAlertUse:{
            
        }
            break;
            
        default:
            break;
    }
}


@end
