//
//  UIView+Corner.m
//  ErpApp
//
//  Created by Virusboo on 2018/1/2.
//  Copyright © 2018年 haofangtongerp. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)cutRoundCornerWithColor:(UIColor *)color lineWidth:(CGFloat)lineWidth {
    [self layoutIfNeeded]; //有约束 立即生效约束以获取frame
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (width == 0 || height == 0) {
        return;
    }
    CGFloat radius = MIN(width, height) / 2;
    [self cutCornerWithRadius:radius color:color lineWidth:lineWidth];
}

- (void)cutCornerWithRadius:(CGFloat)radius color:(UIColor *)color lineWidth:(CGFloat)lineWidth {
    [self layoutIfNeeded]; //有约束 立即生效约束以获取frame
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (width == 0 || height == 0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path  = path.CGPath;
    self.layer.mask = maskLayer;
    if (color && lineWidth > 0) {
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
        borderLayer.lineWidth = lineWidth;
        borderLayer.strokeColor = color.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.path = path.CGPath;
        [self.layer addSublayer:borderLayer];
    }
}

- (void)cutRoundCornerWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent {
    UIImage *backImage = [self createImageWithSize:btnSize gradientColors:clrs percentage:percent];
    self.layer.contents = (id)backImage.CGImage;
}

- (UIImage *)createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    CGFloat locations[5];
    for (int i = 0; i < percents.count; i++) {
        locations[i] = [percents[i] floatValue];
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, locations);
    
    CGPoint start = CGPointMake(0.0, imageSize.height/2);
    CGPoint end = CGPointMake(imageSize.width, imageSize.height/2);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
