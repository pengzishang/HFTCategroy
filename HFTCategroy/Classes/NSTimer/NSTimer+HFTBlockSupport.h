//
//  NSTimer+HFTBlockSupport.h
//  Erp4iOS
//
//  Created by fakepinge on 17/5/25.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HFTBlockSupport)

+ (NSTimer *)hft_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
