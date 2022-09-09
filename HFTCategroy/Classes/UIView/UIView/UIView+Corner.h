//
//  UIView+Corner.h
//  ErpApp
//
//  Created by Virusboo on 2018/1/2.
//  Copyright © 2018年 haofangtongerp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

/**
 给控件切圆以及添加边框
 注: 布局后调用，即先给frame或约束
 @param color 边框颜色
 @param lineWidth 边框宽度
 */
- (void)cutRoundCornerWithColor:(UIColor *)color lineWidth:(CGFloat)lineWidth;

/**
 给控件切圆角以及添加边框
 注: 布局后调用，即先给frame或约束
 @param radius 圆角半径
 @param color 边框颜色
 @param lineWidth 边框宽度
 */
- (void)cutCornerWithRadius:(CGFloat)radius color:(UIColor *)color lineWidth:(CGFloat)lineWidth;

/**
 给控件切圆角
 */
- (void)cutRoundCornerWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;

/**
 生成渐变色
 */
- (void)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent;




@end
