//
//  ACIconCollectionCell.m
//  CameraDemo
//
//  Created by NicoLin on 2018/1/3.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACIconCollectionCell.h"
#import "UIView+ACCameraFrame.h"

@interface ACIconCollectionCell()
@property (nonatomic,strong)UIImageView * iconImageView;
@end

@implementation ACIconCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews {
    self.iconImageView.frame = CGRectMake(0, 0, 100, 100);
}
- (void)setup {
    self.iconImageView = [UIImageView new];
    [self.contentView addSubview:self.iconImageView];
}

- (void)setIconImage:(UIImage *)iconImage {
    self.iconImageView.image = iconImage;
 }

@end
