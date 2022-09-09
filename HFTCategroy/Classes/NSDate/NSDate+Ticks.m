//
//  NSDate+CLRTicks.m
//  crmZztx
//
//  Created by niko on 6/18/14.
//  Copyright (c) 2014 luo hao. All rights reserved.
//

#import "NSDate+Ticks.h"

@implementation NSDate (Ticks)

+ (NSDate *)dateWithCLRTicks:(int64_t)ticks withTimeIntervalAddition:(NSTimeInterval)timeIntervalAddition {
    const double GMTOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    const int64_t CLROffset = 621355968000000000;
    double timeStamp = ((double)(ticks - CLROffset) / 10000000.0) - GMTOffset + timeIntervalAddition;
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

+ (NSDate *)dateWithCLRTicks:(long long)ticks {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(ticks)];
    return date;
}

+ (long long)ticksWithDate:(NSDate *)date {
    long long result = [date timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    result = result * 1000;
    return result;
}

- (long long)ticksTime {
    return [NSDate ticksWithDate:self];
}

+ (long long)getSecondTimeForNow:(NSDate *)date {
    long long result = [date timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    result = result*1000;
    return result;
}

@end
