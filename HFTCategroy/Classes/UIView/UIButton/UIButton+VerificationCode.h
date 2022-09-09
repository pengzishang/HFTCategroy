//
//  UIButton+VerificationCode.h
//  Erp4iOS
//
//  Created by hftsoft on 2017/7/3.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (VerificationCode)

/**
 验证码计时

 @param Count 计时时间
 @param defaultTitle 未计时的title
 @param countDownTitle 计时时的title  eg:'已发送'、‘还剩xx再次发送’   本项目为‘已发送(59s)’
 @param defaultColor 未计时时的颜色
 @param countColor 计时时的颜色
 */
- (void)startWithCount:(NSInteger)Count
		  defaultTitle:(NSString *)defaultTitle
		countDownTitle:(NSString *)countDownTitle
		  defaultColor:(UIColor *)defaultColor
			countColor:(UIColor *)countColor;

@end
