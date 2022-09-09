//
//  UITabBar+HFTRedBadge.h
//  HFTCategroy_Example
//
//  Created by Mi on 2018/9/21.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HFTRedBadge)

/**
 显示
 */
- (void)showBadgeOnItemIndex:(int)index;
/**
 隐藏
 */
- (void)hideBadgeOnItemIndex:(int)index;

- (void)showCommonBadgeOnItemIndex:(int)index itemCount:(NSInteger)itemCount;

@end
