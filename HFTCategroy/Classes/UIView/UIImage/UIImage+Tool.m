//
//  UIImage+Tool.m
//  HFTCategroy_Example
//
//  Created by shenghai on 2017/12/15.
//  Copyright © 2017年 Andrew_Zhang. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

#pragma mark - 创建纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
