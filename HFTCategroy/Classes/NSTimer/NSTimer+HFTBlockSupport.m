//
//  NSTimer+HFTBlockSupport.m
//  Erp4iOS
//  
//  Created by fakepinge on 17/5/25.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "NSTimer+HFTBlockSupport.h"

@implementation NSTimer (HFTBlockSupport)

+ (NSTimer *)hft_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(hft_callBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)hft_callBlock:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    !block ?: block(timer);
}

@end
