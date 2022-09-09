//
//  UIButton+Layout.m
//  HFTCategroy_Example
//
//  Created by virusboo on 2018/9/28.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//  解决button上面图片和文字的位置问题,为避免出问题，在布局之后设置

#import "UIButton+Layout.h"

@implementation UIButton (Layout)

- (void)setLayout:(ButtonLayout)layout spacing:(CGFloat)spacing {
    switch (layout) {
        case ButtonLayoutCenter: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - self.imageView.frame.size.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - self.titleLabel.intrinsicContentSize.width);
        }
            break;
            
        case ButtonLayoutTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - self.imageView.frame.size.width, -self.imageView.frame.size.height - spacing * 0.5, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(- self.titleLabel.intrinsicContentSize.height - spacing * 0.5, 0, 0, - self.titleLabel.intrinsicContentSize.width);
        }
            break;
            
        case ButtonLayoutLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing * 0.5, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing * 0.5);
        }
            break;
            
        case ButtonLayoutBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - self.imageView.frame.size.width, self.imageView.frame.size.height + spacing * 0.5, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.intrinsicContentSize.height + spacing * 0.5, 0, 0, - self.titleLabel.intrinsicContentSize.width);
        }
            break;
            
        case ButtonLayoutRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - self.imageView.frame.size.width - spacing * 0.5 , 0, self.imageView.frame.size.width + spacing * 0.5);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width + spacing * 0.5, 0, - self.titleLabel.intrinsicContentSize.width - spacing * 0.5);
        }
            break;
            
        default: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing * 0.5, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - spacing * 0.5);
        }
            break;
    }
}

@end
