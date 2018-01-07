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
@property (nonatomic,strong)CALayer     * downLayer;

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
    self.downLayer.frame     = CGRectMake(0, 0, self.contentView.ca_width, self.contentView.ca_height);
    
}
- (void)setup {
    self.iconImageView = [UIImageView new];
    self.downLayer     = [CALayer layer];
    self.downLayer.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
    [self.contentView addSubview:self.iconImageView];
    [self.contentView.layer addSublayer:self.downLayer];
}
- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.downLayer.hidden = NO;
    }else {
        self.downLayer.hidden = YES;
    }
}


- (void)setModel:(ACFaceModel *)model {
    if (model.isDefautSet) {
        self.downLayer.hidden = YES;
    }else {
        if (!model.isDownload) {
            self.downLayer.hidden = NO;
        }else {
            self.downLayer.hidden = YES;
        }
    }
    self.iconImageView.image = model.iconImage;
}
@end
