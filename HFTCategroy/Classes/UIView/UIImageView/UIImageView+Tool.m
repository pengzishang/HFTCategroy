//
//  UIImageView+Tool.m
//  UUHaoFang
//
//  Created by 正合适 on 16/6/5.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import "UIImageView+Tool.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Tool)

- (void)setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [UIImageView scaleImageToFitWithImageView:weakSelf];
    }];
}

+ (void)scaleImageToFitWithImageView:(UIImageView *)origionImageView {
    [origionImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    origionImageView.contentMode = UIViewContentModeScaleAspectFill;
    origionImageView.layer.masksToBounds = YES;
}

+ (UIImageView *)createDottedHLine:(UIColor *)color size:(CGSize)size {
    NSArray *arr = [self rgbWithColor:color];
    return [self createDottedHLine:[arr[0] floatValue] g:[arr[1] floatValue] b:[arr[2] floatValue] a:[arr[3] floatValue] size:size];
}

+ (UIImageView *)createDottedHLine:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a size:(CGSize)size {
    //画线
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width,size.height)];
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(line, r/255.0, g/255.0, b/255.0, a);
    CGFloat lengths[] = {5,1};
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, size.height);    //开始画线
    CGContextAddLineToPoint(line, size.width, size.height);
    CGContextStrokePath(line);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.image = image;
    return imageView;
}

+ (NSArray *)rgbWithColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    const CGFloat alpha = CGColorGetAlpha(color.CGColor);
    NSArray *array = @[@(components[0]), @(components[1]), @(components[2]), @(alpha)];
    return array;
}

- (void)useSDWebImageLoadImageWithURL:(NSString *)strUrl placeholderImage:(UIImage *)image animation:(BOOL)animation compeletBlock:(void(^)(UIImage *, NSError *, NSURL *))compeletBlock {
    if (self.frame.size.width > 0 && self.frame.size.height > 0) {
        CGFloat width = self.frame.size.width * [UIScreen mainScreen].scale*([UIScreen mainScreen].bounds.size.width >=414?0.87:1);
        CGFloat height = self.frame.size.height * [UIScreen mainScreen].scale*([UIScreen mainScreen].bounds.size.height >=414?0.87:1);
        strUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,%ld,w_%ld", (strUrl.length>0?strUrl:@""), (long)width, (long)height];
    }
    // 铺满 x-oss-process=image/
    self.contentMode = UIViewContentModeScaleAspectFill;// 图片填满
    self.clipsToBounds = YES;
    
    NSLog(@"%@",strUrl);
    
    // 加载图片
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 支持动画、没有错误、没有用缓存的情况下添加渐变的显示效果
        if (animation && error == nil && cacheType == SDImageCacheTypeNone) {
            weakSelf.alpha = 0.0;
            [UIView transitionWithView:weakSelf duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                weakSelf.alpha = 1.0;
            } completion:nil];
        }
        if (compeletBlock) {
            compeletBlock(image,error,imageURL);
        }
    }];
}

@end
