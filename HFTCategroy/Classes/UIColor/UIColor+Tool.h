//
//  UIColor+Tool.h
//  TCMManager
//
//  Created by mac on 15/6/15.
//  Copyright (c) 2015年 JianLiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Tool)

+(UIColor *)getColor:(NSString *)hexColor;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
