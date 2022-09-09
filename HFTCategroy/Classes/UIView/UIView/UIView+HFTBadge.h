//
//  UIView+HFTBadge.h
//  ErpApp
//
//  Created by virusboo on 2019/2/22.
//  Copyright © 2019 haofangtongerp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HFTBadge)
/*****************以下属性没有特定需求完全可以不用**********************/
/**小红点的宽高 默认为6*/
@property(nonatomic, assign) CGFloat dotHeight;
/**带文案角标的特定高 默认根据文字调整高度*/
@property(nonatomic, assign) CGFloat badgeHeight;
/**badge的背景色 默认红色*/
@property(nonatomic, strong) UIColor *badgeColor;
/**调整badge横向位置偏移 以UIView右上角为锚点为基础调整 （即badge默认中心为UIView的右上角）*/
@property(nonatomic, assign) CGFloat adjustOffsetX;
/**调整badge竖向位置偏移 以UIView右上角为锚点为基础调整 （即badge默认中心为UIView的右上角）*/
@property(nonatomic, assign) CGFloat adjustOffsetY;
/**是否需要边界  默认没有边界  有，则默认宽为2,颜色为白色*/
@property(nonatomic, assign) BOOL needBorder;
/**小红点*/
@property(nonatomic, readonly, strong) UIView *badgeView;
/**带文本的角标*/
@property(nonatomic, readonly, strong) UILabel *badgeLabel;
/**
 隐藏红点（角标）
 注: 布局后调用，即先给frame或约束
 */
- (void)hideBadge;
/**
 显示红点
 注: 布局后调用，即先给frame或约束
 */
- (void)showBadge;
/**
 显示角标
 @param text 文本
 */
- (void)showBadgeWithText:(NSString *)text;


@end

