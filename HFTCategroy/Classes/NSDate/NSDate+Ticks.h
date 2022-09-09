//
//  NSDate+CLRTicks.h
//  crmZztx
//
//  Created by niko on 6/18/14.
//  Copyright (c) 2014 luo hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ticks)

/**
 根据时间戳获取时间
 */
+ (NSDate *)dateWithCLRTicks:(long long)ticks;

/**
 获取1970到指定时间的时间戳
 */
+ (long long)ticksWithDate:(NSDate *)date;

/**
 获取1970到当前时间的时间戳
 */
- (long long)ticksTime;

/**
 获取到当前的总共的秒数
 */
+ (long long)getSecondTimeForNow:(NSDate *)date;

@end
