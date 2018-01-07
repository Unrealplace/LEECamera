//
//  ACCameraShareView.m
//  CameraDemo
//
//  Created by LiYang on 2018/1/7.
//  Copyright © 2018年 NicoLin. All rights reserved.
//

#import "ACCameraShareView.h"
#import "UIView+ACCameraFrame.h"

@interface ACCameraShareView ()
@property (nonatomic, strong) UIImageView    *imageView;

@end

@implementation ACCameraShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    self.imageView.frame = CGRectMake(0, 0, self.ca_width, self.ca_height);
    
}
- (void)setup {
    self.imageView = [UIImageView new];
    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageView];
}

- (void)setShareImage:(UIImage *)shareImage {
    self.imageView.image = shareImage;
}


@end
