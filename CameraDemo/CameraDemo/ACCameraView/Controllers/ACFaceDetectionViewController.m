//
//  ACFaceDetectionViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2017/12/28.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACFaceDetectionViewController.h"
#import "ACCameraViewController.h"
#import "ACPhotoPickerController.h"
#import "UIView+ACCameraFrame.h"
#import "ACPhotoPickerController.h"
#import "ACCameraViewController.h"
#import "ACMTStoreDownloadManager.h"
#import "ACFileManager.h"
#import "ACSaveImageUtil.h"
#import "ACArchiverManager.h"
#import "ACFaceModel.h"
#import "ACIconShowFlowLayout.h"
#import "ACIconCollectionCell.h"

static NSString * IconCellID = @"IconCellID";

@interface ACFaceDetectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UIButton * goBackSelectPhotoBtn;

@property (nonatomic, strong)UIButton * goBackCameraBtn;

@property (nonatomic, strong)UIButton * saveBtn;

@property (nonatomic, strong)UICollectionView * iconCollectionView;

@property (nonatomic, strong)ACIconShowFlowLayout * iconShowFlowLayout;

@property (nonatomic, strong)NSArray * dataSourceArray;


@end

@implementation ACFaceDetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.goBackCameraBtn];
    [self.view addSubview:self.goBackSelectPhotoBtn];
    [self.view addSubview:self.saveBtn];
    
   NSArray * array = [ACArchiverManager unArchiverFaceSerias];
  
    self.dataSourceArray = [NSArray arrayWithArray:array];
    
//    NSLog(@"%@",[((ACFaceModel*)array[0]) iconImage]);
  
//    [[ACMTStoreDownloadManager sharedManager] downloadWithUrl:@"https://mplat-oss.adnonstop.com/app_source/20180102/1509866822018010210art41790.zip" currentProgress:^(double progress) {
//        NSLog(@"%lf",progress);
//        NSLog(@"%@--%@--%@",[ACFileManager cameraSeriasDirPath],[ACFileManager cameraSeriasZipPath],[ACFileManager cameraSeriasDebugDirPath]);
//    }];
    
    [self.view addSubview:self.iconCollectionView];
    
    [self.iconCollectionView reloadData];
    
}


- (UICollectionView*)iconCollectionView {
    if (!_iconCollectionView) {
        _iconShowFlowLayout = [[ACIconShowFlowLayout alloc] init];
        _iconShowFlowLayout.itemSize = CGSizeMake(100, 100);
        _iconCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.view.ca_width, 100) collectionViewLayout:_iconShowFlowLayout];
        _iconCollectionView.backgroundColor = [UIColor redColor];
        [_iconCollectionView registerClass:[ACIconCollectionCell class] forCellWithReuseIdentifier:IconCellID];
        _iconCollectionView.delegate = self;
        _iconCollectionView.dataSource = self;
    }
    return _iconCollectionView;
}

- (UIButton*)goBackSelectPhotoBtn {
    if (!_goBackSelectPhotoBtn) {
        _goBackSelectPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackSelectPhotoBtn.frame = CGRectMake(0, self.view.ca_height - 180, 150, 44);
        _goBackSelectPhotoBtn.backgroundColor = [UIColor yellowColor];
        _goBackSelectPhotoBtn.ca_centerX = self.view.ca_centerX;
        [_goBackSelectPhotoBtn setTitle:@"重新选图" forState:UIControlStateNormal];
        [_goBackSelectPhotoBtn addTarget:self action:@selector(goBackSelectPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackSelectPhotoBtn;
}

- (UIButton*)goBackCameraBtn {
    if (!_goBackCameraBtn) {
        _goBackCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackCameraBtn.frame = CGRectMake(100, self.view.ca_height - 100, 150, 44);
        _goBackCameraBtn.ca_centerX = self.view.ca_centerX;
        _goBackCameraBtn.backgroundColor = [UIColor yellowColor];
        [_goBackCameraBtn setTitle:@"重新拍照" forState:UIControlStateNormal];
        [_goBackCameraBtn addTarget:self action:@selector(goBackCameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackCameraBtn;
}

- (UIButton*)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(100, 0, 150, 44);
        _saveBtn.ca_center = self.view.ca_center;
        _saveBtn.backgroundColor = [UIColor yellowColor];
        [_saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSourceArray.count;
}

#pragma mark - UICollectionViewDelegate Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACIconCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IconCellID forIndexPath:indexPath];
    ACFaceModel * model = _dataSourceArray[indexPath.row];
    cell.iconImage = model.iconImage;
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)saveBtnClick:(UIButton*)btn {
    [ACSaveImageUtil saveImage:self.showImage compeleted:^(BOOL isCompeleted, NSString *status, NSDictionary *imgInfo) {
    }];
}

- (void)goBackSelectPhotoBtnClick:(UIButton*)btn {
    for (UIViewController * vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[ACPhotoPickerController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
}

- (void)goBackCameraBtnClick:(UIButton*)btn {
    
    BOOL have = NO;
    for (UIViewController * vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[ACCameraViewController class]]) {
            have = YES;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    if (!have) {
        ACCameraViewController * cameraVC = [ACCameraViewController new];
        [self.navigationController pushViewController:cameraVC animated:YES];
    }
   
    
}
@end
