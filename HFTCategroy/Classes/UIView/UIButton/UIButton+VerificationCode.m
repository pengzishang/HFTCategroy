//
//  UIButton+VerificationCode.m
//  Erp4iOS
//
//  Created by hftsoft on 2017/7/3.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "UIButton+VerificationCode.h"

@implementation UIButton (VerificationCode)

- (void)startWithCount:(NSInteger)count
		  defaultTitle:(NSString *)defaultTitle
		countDownTitle:(NSString *)countDownTitle
		  defaultColor:(UIColor *)defaultColor
			countColor:(UIColor *)countColor {
	//倒计时时间
	__block NSInteger timeOut = count;
	__weak typeof(self) weakSelf = self;
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
	dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
	//每秒执行一次
	dispatch_source_set_timer(timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
	dispatch_source_set_event_handler(timer, ^{
		
		//倒计时结束，关闭
		if (timeOut == 0) {
			dispatch_source_cancel(timer);
			dispatch_async(dispatch_get_main_queue(), ^{
				[weakSelf setTitleColor:defaultColor forState:UIControlStateNormal];
				[weakSelf setTitle:defaultTitle forState:UIControlStateNormal];
				weakSelf.userInteractionEnabled = YES;
			});
		} else {
			NSString *timeStr = [NSString stringWithFormat:@"%02ld", (long)timeOut];
			dispatch_async(dispatch_get_main_queue(), ^{
				[weakSelf setTitleColor:countColor forState:UIControlStateNormal];
				[weakSelf setTitle:[NSString stringWithFormat:@"%@(%@s)",countDownTitle,timeStr] forState:UIControlStateNormal];
				weakSelf.userInteractionEnabled = NO;
			});
			timeOut--;
		}
	});
	dispatch_resume(timer);
}
@end
