//
//  UITabBar+HFTRedBadge.m
//  HFTCategroy_Example
//
//  Created by Mi on 2018/9/21.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//

#import "UITabBar+HFTRedBadge.h"

#define TabbarItemNums 3.0

@implementation UITabBar (HFTRedBadge)

/**
 显示
 */
- (void)showBadgeOnItemIndex:(int)index {
    [self removeBadgeOnItemIndex:index];
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888 + index;
    bview.layer.cornerRadius = 3.5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index + 0.65)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.08*tabFram.size.height);
    bview.frame = CGRectMake(x + (index == 2 ? 4 : (index == 1 ? 0 : -3)), y + (index == 2 ? 1:2), 7, 7);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}
/**
 隐藏
 */
- (void)hideBadgeOnItemIndex:(int)index {
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}

/**
 显示
 */
- (void)showCommonBadgeOnItemIndex:(int)index itemCount:(NSInteger)itemCount {
    [self removeBadgeOnItemIndex:index];
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888 + index;
    bview.layer.cornerRadius = 3.5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index + 0.65)/itemCount;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.08*tabFram.size.height);
    bview.frame = CGRectMake(x - 3, y + 2, 7, 7);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

@end
