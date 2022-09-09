//
//  UIImageView+Blur.m
//  Erp4iOS
//
//  Created by Andrew on 15/8/17.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "UIImageView+Blur.h"
#import <objc/runtime.h>
#import <Accelerate/Accelerate.h>

static void* blurViewAddr=@"veffViewAddr";

@implementation UIImageView (Blur)

-(void)setBlurView:(UIVisualEffectView *)blurView
{
	objc_setAssociatedObject(self, blurViewAddr, blurView, OBJC_ASSOCIATION_RETAIN);
}

-(UIVisualEffectView *)blurView
{
	return objc_getAssociatedObject(self, blurViewAddr);
}

- (void)blurImageViewWithStyle:(BlurStyle)style alpha:(float)alpha
{
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	if (version < 8.0) {
		UIImage *blurImage = [self applyBlurRadius:30 toImage:self.image];
		[self setImage:blurImage];
	}else {
		UIVisualEffectView *blurView = [self viewWithTag:50000];
		blurView = [self applyBlurRect:self.bounds style:style alpha:alpha];
		if (![self viewWithTag:50000]) {
			self.blurView=blurView;
			[self addSubview:blurView];
		}
	}
}

- (void)coreImage:(UIImage *)image CIGaussianBlurRadius:(CGFloat)radius NS_AVAILABLE_IOS(6_0)
{
	UIImage *blurImage = [self applyBlurRadius:radius toImage:image];
	[self setImage:blurImage];
}

- (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image
{
	if (radius < 0) radius = 0;
	
	CIContext *context = [CIContext contextWithOptions:nil];
	CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
	
	CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
	[filter setValue:inputImage forKey:kCIInputImageKey];
	[filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
	CIImage *result = [filter valueForKey:kCIOutputImageKey];
	
	CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
	
	UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
	CGImageRelease(cgImage);
	return returnImage;
}

- (UIVisualEffectView *)applyBlurRect:(CGRect)blurRect style:(BlurStyle)style alpha:(float)alpha
{
	UIBlurEffect *blurEffect;
	switch (style) {
		case BlurStyleDark:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
			break;
		case BlurStyleExtraLight:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
			break;
		case BlurStyleLight:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
			break;
	}
	
	UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	view.frame = blurRect;
	view.alpha = alpha;
	
	return view;
}



+(UIVisualEffectView *)blurViewRect:(CGRect)blurRect style:(BlurStyle)style alpha:(float)alpha
{
	UIBlurEffect *blurEffect;
	switch (style) {
		case BlurStyleDark:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
			break;
		case BlurStyleExtraLight:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
			break;
		case BlurStyleLight:
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
			break;
	}
	
	UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	view.frame = blurRect;
	view.alpha = alpha;
	
	return view;
}

/**文字绘成图片*/
- (UIImage *)createImageWithContext:(NSString *)text textFont:(UIFont *)font {
    UIFont *textFont = font;
    //内容宽度
    NSDictionary *attributes = @{NSFontAttributeName:textFont};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    
    CGSize imageSize; //画的背景 大小
    imageSize = CGSizeMake(sizeToFit.size.width, sizeToFit.size.height + 5);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    //绘制文字
    [text drawAtPoint:CGPointMake(0,0) withAttributes:@{NSFontAttributeName:textFont, NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    //返回绘制的新图形
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 高斯模糊（对用content截图，opengl截图的图片发红处理高斯模糊）
 
 @param image 图片
 @param blur 1-100（最好是1-25）
 @return 高斯模糊图片
 */
+(UIImage *)fan_accelerateBlurWithImage:(UIImage *)image blurNumber:(CGFloat)blur
{
    if(image==nil){
        return nil;
    }
    int boxSize = blur;
    if (blur<1||blur>100) {
        boxSize=25;
    }
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;
    
    void *pixelBuffer, *convertBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);    

    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    
    if (pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *rgbConvertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img);
    outRGBBuffer.rowBytes = CGImageGetBytesPerRow(img);//3
    outRGBBuffer.data = rgbConvertBuffer;
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    //    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    const uint8_t mask[] = {2, 1, 0, 3};
    
    vImagePermuteChannels_ARGB8888(&outBuffer, &rgbOutBuffer, mask, kvImageNoFlags);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data,
                                             rgbOutBuffer.width,
                                             rgbOutBuffer.height,
                                             8,
                                             rgbOutBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    
    free(pixelBuffer);
    free(convertBuffer);
    free(rgbConvertBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
