//
//  ACFaceProcessViewController.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/4.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACFaceProcessViewController.h"
#import "ACFaceModel.h"
#import "ACIconShowFlowLayout.h"
#import "ACIconCollectionCell.h"
#import "UIView+ACCameraFrame.h"
#import "ACArchiverManager.h"

static NSString * IconCellID = @"IconCellID";

@interface ACFaceProcessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView * iconCollectionView;

@property (nonatomic, strong)ACIconShowFlowLayout * iconShowFlowLayout;
@property (nonatomic, strong)NSArray * dataSourceArray;
@property (nonatomic, strong)UIImageView * faceImageView;


@end

@implementation ACFaceProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = [ACArchiverManager unArchiverFaceSerias];
    
    self.dataSourceArray = [NSArray arrayWithArray:array];
    
    //    NSLog(@"%@",[((ACFaceModel*)array[0]) iconImage]);
    
    //    [[ACMTStoreDownloadManager sharedManager] downloadWithUrl:@"https://mplat-oss.adnonstop.com/app_source/20180102/1509866822018010210art41790.zip" currentProgress:^(double progress) {
    //        NSLog(@"%lf",progress);
    //        NSLog(@"%@--%@--%@",[ACFileManager cameraSeriasDirPath],[ACFileManager cameraSeriasZipPath],[ACFileManager cameraSeriasDebugDirPath]);
    //    }];
    
    [self.view addSubview:self.iconCollectionView];
    
    [self.iconCollectionView reloadData];
    [self.view addSubview:self.faceImageView];
    
}


- (UIImageView*)faceImageView {
    if (!_faceImageView) {
        _faceImageView = [UIImageView new];
        _faceImageView.frame = CGRectMake(0, 0, self.view.ca_width, self.view.ca_height - 100);
        _faceImageView.image = [UIImage imageNamed:@"girl"];
    }
    return _faceImageView;
}

- (UICollectionView*)iconCollectionView {
    if (!_iconCollectionView) {
        _iconShowFlowLayout = [[ACIconShowFlowLayout alloc] init];
        _iconShowFlowLayout.itemSize = CGSizeMake(100, 100);
        _iconCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.ca_height - 100, self.view.ca_width, 100) collectionViewLayout:_iconShowFlowLayout];
        _iconCollectionView.showsVerticalScrollIndicator = NO;
        _iconCollectionView.scrollEnabled   = YES;
        _iconCollectionView.backgroundColor = [UIColor redColor];
        [_iconCollectionView registerClass:[ACIconCollectionCell class] forCellWithReuseIdentifier:IconCellID];
        _iconCollectionView.delegate = self;
        _iconCollectionView.dataSource = self;
    }
    return _iconCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
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

@end
