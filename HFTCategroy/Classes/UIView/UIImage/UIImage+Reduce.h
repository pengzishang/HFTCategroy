//
//  UIImage+Reduce.h
//  Erp4iOS
//	压缩图片的扩展
//  Created by fakepinge on 17/5/25.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Reduce)

/**
 上传图片压缩 默认比例  (960 * 720)

 @return 压缩后的图片
 */
- (UIImage *)imageForReduceDefautImagePixels;

/**
 上传图片压缩 自定义比例 width * height

 @param imagePixels 自定义比例 width * height
 @return 压缩后的图片
 */
- (UIImage *)imageForReduce:(CGFloat)imagePixels;

- (UIImage *)fixOrientation;

- (NSData *)imageCompressForSpecifyKB:(NSInteger)specifyKB;

@end
