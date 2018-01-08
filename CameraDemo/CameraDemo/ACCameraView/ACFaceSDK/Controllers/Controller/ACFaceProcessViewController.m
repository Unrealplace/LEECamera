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
#import "ACFaceShareViewController.h"
#import "ACDownLoadManager.h"
#import "ACFileManager.h"
#import "ACFaceSDK.h"
#import "ACFaceDataManager.h"
#import "ACCameraShareView.h"
#import "ACCameraShareBottomView.h"
#import "ACCameraNaviView.h"

static NSString * IconCellID = @"IconCellID";

@interface ACFaceProcessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ACCameraNaviViewDelegate,ACCameraNaviViewDelegate,ACCameraShareViewDelegate>
@property (nonatomic, strong)UICollectionView * iconCollectionView;

@property (nonatomic, strong)ACIconShowFlowLayout * iconShowFlowLayout;
@property (nonatomic, strong)NSArray * dataSourceArray;
@property (nonatomic, strong)UIImageView * faceImageView;
@property (nonatomic, strong) ACCameraShareView    *shareView;
@property (nonatomic, strong) ACCameraShareBottomView    *shareBottomView;
@property (nonatomic, strong) ACCameraNaviView    *shareNavView;



@end

@implementation ACFaceProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = [ACArchiverManager unArchiverFaceSeriasandEnviromentType:[ACFaceSDK sharedSDK].enriroType];
    
    self.dataSourceArray = [NSArray arrayWithArray:array];

    [self.view addSubview:self.iconCollectionView];
    
    [self.iconCollectionView reloadData];
    [self.view addSubview:self.faceImageView];
    [self.view addSubview:self.naviView];
    
}


- (ACCameraNaviView *)shareNavView {
    if (!_shareNavView) {
        _shareNavView = [[ACCameraNaviView alloc] initWithFrame:CGRectMake(0, 0, self.view.ca_width, 44)];
        _shareNavView.delegate = self;
        _shareNavView.tag = 1000;
        _shareNavView.alpha = 0;
    }
    return _shareNavView;
}
- (ACCameraShareView *)shareView {
    if (!_shareView) {
        _shareView = [[ACCameraShareView alloc] initWithFrame:CGRectMake(0, 44, self.view.ca_width, self.view.ca_height - 44 - self.shareBottomView.ca_height)];
        _shareView.alpha = 0;
    }
    return _shareView;
    
}
- (ACCameraShareBottomView*)shareBottomView {
    if (!_shareBottomView) {
        _shareBottomView = [[ACCameraShareBottomView alloc] initWithFrame:CGRectMake(0, self.view.ca_height, self.view.ca_width, 70)];
        _shareBottomView.backgroundColor = [UIColor blueColor];
        _shareBottomView.alpha = 0;
        _shareBottomView.delegate = self;
    }
    return _shareBottomView;
}


- (UIImageView*)faceImageView {
    if (!_faceImageView) {
        _faceImageView = [UIImageView new];
        _faceImageView.frame = CGRectMake(0, 44, self.view.ca_width, self.view.ca_height - 44- self.iconCollectionView.ca_height);
        _faceImageView.image = [UIImage imageNamed:@"girl"];
        _faceImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_faceImageView addGestureRecognizer:tap];
    }
    return _faceImageView;
}

- (UICollectionView*)iconCollectionView {
    if (!_iconCollectionView) {
        _iconShowFlowLayout = [[ACIconShowFlowLayout alloc] init];
        _iconShowFlowLayout.itemSize = CGSizeMake(100, 100);
        _iconShowFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _iconShowFlowLayout.minimumLineSpacing = 10;
        _iconShowFlowLayout.minimumInteritemSpacing = 5;
    
        _iconCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.ca_height - 100, self.view.ca_width, 100) collectionViewLayout:_iconShowFlowLayout];
        _iconCollectionView.showsVerticalScrollIndicator = NO;
        _iconCollectionView.showsHorizontalScrollIndicator = NO;
        _iconCollectionView.scrollEnabled   = YES;
         [_iconCollectionView registerClass:[ACIconCollectionCell class] forCellWithReuseIdentifier:IconCellID];
        _iconCollectionView.delegate = self;
        _iconCollectionView.dataSource = self;
    }
    return _iconCollectionView;
}

- (void)tapClick:(UITapGestureRecognizer*)sender {
    
    ACFaceModel * model = (ACFaceModel*)_dataSourceArray.lastObject;
    
    NSString * pathUrl = [[ACFaceDataManager storedSeriesPath].absoluteString stringByAppendingPathComponent:model.fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:pathUrl error:nil];

    
    [ACArchiverManager deleteModelWith:_dataSourceArray.lastObject andEnviromentType:[ACFaceSDK sharedSDK].enriroType];

    _dataSourceArray = [ACArchiverManager unArchiverFaceSeriasandEnviromentType:[ACFaceSDK sharedSDK].enriroType];
    
    [self.iconCollectionView reloadData];
    
}

- (void)cameraNaviViewTouchEvent:(ACCameraNaviViewTouchType)touchType  andCameraNaviView:(ACCameraNaviView *)naviView{
    if (naviView.tag == 1000) {
        if (touchType == ACCameraNaviViewTouchTypeLeft) {
          
            [UIView animateWithDuration:0.25 animations:^{
                self.shareBottomView.frame = CGRectMake(0, self.view.ca_height , self.shareBottomView.ca_width, self.shareBottomView.ca_height);
                self.shareBottomView.alpha  = 0.0;
            } completion:^(BOOL finished) {
                [self.shareBottomView removeFromSuperview];
                [UIView animateWithDuration:0.2 animations:^{
                    self.iconCollectionView.frame = CGRectMake(0, self.view.ca_height - 100, self.view.ca_width, 100);
                    self.iconCollectionView.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    
                }];
            }];
            
            [UIView animateWithDuration:0.6 animations:^{
                self.shareView.transform = CGAffineTransformMakeScale( 1.0, 1.0);
                self.faceImageView.transform = CGAffineTransformMakeScale( 1.0, 1.0);
                self.faceImageView.alpha = 1.0;
                self.shareView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.shareView removeFromSuperview];
            }];
            self.shareNavView.alpha = 0.0f;
            [self.shareNavView removeFromSuperview];
            self.naviView.alpha = 1.0f;
            
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }else {
        if (touchType == ACCameraNaviViewTouchTypeLeft) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (touchType == ACCameraNaviViewTouchTypeRight) {
          
            [self.view addSubview:self.shareBottomView];
            [UIView animateWithDuration:0.25 animations:^{
                self.iconCollectionView.frame = CGRectMake(0, self.view.ca_height, self.iconCollectionView.ca_width, self.iconCollectionView.ca_height);
            } completion:^(BOOL finished) {
                self.iconCollectionView.alpha = 0.0f;
                [UIView animateWithDuration:0.2 animations:^{
                    self.shareBottomView.alpha = 1.0f;
                    self.shareBottomView.frame = CGRectMake(0, self.view.ca_height - 80, self.shareBottomView.ca_width, self.shareBottomView.ca_height);
                    
                } completion:^(BOOL finished) {
                    
                }];
            }];
            
            self.shareView.shareImage = [UIImage imageNamed:@"girl"];
            self.shareView.alpha = 0.0f;
            [self.view addSubview:self.shareView];
            [UIView animateWithDuration:0.6 animations:^{
                self.faceImageView.transform = CGAffineTransformScale(self.faceImageView.transform, 0.8, 0.75);
                self.faceImageView.alpha = 0.0f;
                self.shareView.transform = CGAffineTransformScale(self.shareView.transform, 0.8, 0.75);
                self.shareView.alpha = 1.0f;
            } completion:^(BOOL finished) {
            }];
            
            [self.view addSubview:self.shareNavView];
            self.shareNavView.alpha = 1.0f;
            self.naviView.alpha = 0.0f;
 
            
            //        ACFaceShareViewController * share = [ACFaceShareViewController new];
            //        [self.navigationController pushViewController:share animated:YES];
        }
    }
 
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
    cell.model = model;
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[ACFaceSDK sharedSDK] setNetState:self] == ACFaceSDKNetStateTypeWifi) {
        NSLog(@"wifi----%ld",ACFaceSDKNetStateTypeWifi);
    }else {
        [[ACDownLoadManager shareInstance] downLoadWithUrl:@"https://mplat-oss.adnonstop.com/app_source/20180102/1509866822018010210art41790.zip" andSaveToPath:[ACFileManager cameraDocumentPath] callBackProgress:^(float progress) {
            NSLog(@"%f",progress);
        } downLoadStateChange:^(ACDownLoadState state) {
            
        } andSuccess:^(NSString *path, NSError *error) {
            NSLog(@"%@--%@",path,error);
            if (!error) {
                self.dataSourceArray = [ACArchiverManager unArchiverFaceSeriasandEnviromentType:[ACFaceSDK sharedSDK].enriroType];
                [self.iconCollectionView reloadData];
            }
        }];
        
    }
    
   
//    [[ACDownLoadManager shareInstance] cancelDownLoadWithUrl:@"https://mplat-oss.adnonstop.com/app_source/20180102/1509866822018010210art41790.zip"];

}

- (void)shareViewClick:(ACCameraShareBottomView *)shareView andShareType:(ACFaceSDKShareType)shareType {
    
    [[ACFaceSDK sharedSDK] setShareViewWith:self andShareModel:nil andShareType:shareType];
    
}

@end
