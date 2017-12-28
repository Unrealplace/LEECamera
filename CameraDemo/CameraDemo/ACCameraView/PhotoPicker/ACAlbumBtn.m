//
//  ACAlbumBtn.m
//  ArtCameraPro
//
//  Created by NicoLin on 2017/8/4.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACAlbumBtn.h"
#import "UIView+ACCameraFrame.h"

@implementation ACAlbumBtn

- (void)setAlbumTitle:(NSString *)title {
    
    self.selected = NO;
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];

    CGFloat titleWidth = [title widthForFont:self.titleLabel.font];
    self.titleLabel.ca_height = titleWidth;
    
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    self.ca_centerX += (self.ca_width - (imageViewWidth + titleWidth + 6.0f))/2;
    self.ca_width = imageViewWidth + titleWidth + 6.0f;
    self.imageEdgeInsets = UIEdgeInsetsMake(0,0 + titleWidth + 3.0f,0,0 - titleWidth - 3.0f);
    self.titleEdgeInsets = UIEdgeInsetsMake(0,0 - imageViewWidth - 3.0f,0, 0 + imageViewWidth + 3.0f);
}

@end
