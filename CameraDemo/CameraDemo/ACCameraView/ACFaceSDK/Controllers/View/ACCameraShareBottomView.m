//
//  ACCameraShareBottomView.m
//  CameraDemo
//
//  Created by LiYang on 2018/1/7.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACCameraShareBottomView.h"
#import "ACCameraShareCell.h"
#import "ACCameraShareFlowLayout.h"
#import "UIView+ACCameraFrame.h"

static NSString * shareCellID = @"shareID";

@interface ACCameraShareBottomView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * shareCollectionView;
@property (nonatomic, strong)ACCameraShareFlowLayout    *shareLayout;


@end

@implementation ACCameraShareBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.shareCollectionView];
    }
    return self;
}
- (void)layoutSubviews {
    self.shareCollectionView.frame = CGRectMake(0, 0, self.ca_width, self.ca_height);
}
- (UICollectionView*)shareCollectionView {
    if (!_shareCollectionView) {
        _shareLayout = [[ACCameraShareFlowLayout alloc] init];
        _shareLayout.itemSize = CGSizeMake(50, 50);
        _shareLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _shareLayout.minimumLineSpacing = 10;
        _shareLayout.minimumInteritemSpacing = 5;
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.ca_width, self.ca_height) collectionViewLayout:_shareLayout];
        _shareCollectionView.showsVerticalScrollIndicator = NO;
        _shareCollectionView.showsHorizontalScrollIndicator = NO;
        _shareCollectionView.scrollEnabled   = YES;
        [_shareCollectionView registerClass:[ACCameraShareCell class] forCellWithReuseIdentifier:shareCellID];
        _shareCollectionView.delegate = self;
        _shareCollectionView.dataSource = self;
    }
    return _shareCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}

#pragma mark - UICollectionViewDelegate Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACCameraShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shareCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewClick:andShareType:)]) {
        [self.delegate shareViewClick:self andShareType:indexPath.row];
    }
    
}

@end
