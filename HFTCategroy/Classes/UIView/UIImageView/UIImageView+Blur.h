//
//  UIImageView+Blur.h
//  Erp4iOS
//
//  Created by Andrew on 15/8/17.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	BlurStyleDark,
	BlurStyleLight,
	BlurStyleExtraLight
}BlurStyle;


// 毛玻璃
// 高斯模糊

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Blur)

/**
 *  iOS 8.0 毛玻璃view
 */
@property (nonatomic,strong)UIVisualEffectView *blurView NS_AVAILABLE_IOS(8_0);



#pragma mark - 对外API
/**
 获取一个 UIVisualEffectView

 @param blurRect rect
 @param style style
 @param alpha alpha

 @return UIVisualEffectView 实例
 */
+(UIVisualEffectView *)blurViewRect:(CGRect)blurRect style:(BlurStyle)style alpha:(float)alpha NS_AVAILABLE_IOS(8_0);



/**
 高斯模糊

 @desc iOS 8.0+ 使用 UIVisualEffectView，iOS 8.0- 使用CIFilter处理
 @param style BlurStyle
 @param alpha 透明度
 */
- (void)blurImageViewWithStyle:(BlurStyle)style alpha:(float)alpha NS_AVAILABLE_IOS(6_0);


/**
 利用coreImage 处理 高斯模糊 (!!:比较耗费性能)

 @param image 需要处理的图片
 @param radius 模糊半径
 */
- (void)coreImage:(UIImage *)image CIGaussianBlurRadius:(CGFloat)radius NS_AVAILABLE_IOS(6_0);


/**
 文字绘成图片
 
 @param text 文本
 @param font 字体大小
 */
- (UIImage *)createImageWithContext:(NSString *)text textFont:(UIFont *)font;

/**
 高斯模糊（对用content截图，opengl截图的图片发红处理高斯模糊）
 
 @param image 图片
 @param blur 1-100（最好是1-25）
 @return 高斯模糊图片
 */
+(UIImage *)fan_accelerateBlurWithImage:(UIImage *)image blurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
