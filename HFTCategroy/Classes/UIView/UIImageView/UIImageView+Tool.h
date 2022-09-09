//
//  UIImageView+Tool.h
//  UUHaoFang
//
//  Created by 正合适 on 16/6/5.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Tool)

/**
 设置图片，从图片中心截取
 
 @param urlStr      源图片地址
 @param placeholder 站位图
 */
- (void)setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/**
 *  图片适应view，防止拉伸压缩
 *
 *  @param origionImageView 原始的ImageView
 */
+ (void)scaleImageToFitWithImageView:(UIImageView *)origionImageView;

/**
 画虚线

 @param color 颜色
 @param size 大小
 @return 虚线
 */
+ (UIImageView *)createDottedHLine:(UIColor *)color size:(CGSize)size;

/**
 像服务器请求imageview大小换算为像素尺寸的image（基于sdwebimage）
 
 @param strUrl 图片链接
 @param image 占位图
 @param animation 是否需要动画
 @param compeletBlock 加载完成回调
 */
- (void)useSDWebImageLoadImageWithURL:(NSString *)strUrl placeholderImage:(UIImage *)image animation:(BOOL)animation compeletBlock:(void(^)(UIImage *image, NSError *error, NSURL *imageURL))compeletBlock;

@end
