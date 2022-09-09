//
//  NSDate+Format.m
//  Erp4iOS
//
//  Created by cheaterhu on 2017/8/18.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

+ (NSString *)formatTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatStr];
	NSString *dateStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
	return dateStr;
}

+ (NSString *)formatDate:(NSDate *)date formatStr:(NSString *)formatStr {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatStr];
	NSString *dateStr = [formatter stringFromDate:date];
	return dateStr;
}

+ (NSDate *)dateFromString:(NSString *)dateStr formatStr:(NSString *)formatStr {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatStr];
	NSDate *date = [formatter dateFromString:dateStr];
	return date;
}

+ (int)compareOneDate:(NSDate *)oneDate withAnotherDate:(NSDate *)anotherDate {
    NSComparisonResult result = [oneDate compare:anotherDate];
    if (result == NSOrderedDescending) {
        return 1;
    } else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
}

+ (NSString *)todayStr {
    return [NSDate formatDate:[NSDate date] formatStr:@"yyyy-MM-dd"];
}

+ (NSDate *)date:(NSDate *)currentDate appendMonth:(NSUInteger)gapMonthCount {
    // 获取当年的月份，当月的总天数
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    // 一般提前一天
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitCalendar fromDate:currentDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = @"";
    NSInteger endDay = 0;//天
    NSDate *newDate = [NSDate date];//新的年&月
    //判断是否是下一年
    if (components.month+gapMonthCount > 12) {
        //是下一年
        NSInteger yearInteger = components.year+((components.month+gapMonthCount)%12==0?(components.month+gapMonthCount)/12-1:(components.month+gapMonthCount)/12);
        NSInteger monthInteger = (components.month+gapMonthCount)%12==0?12: (components.month+gapMonthCount)%12;
        dateStr = [NSString stringWithFormat:@"%4ld-%2ld-01", (long)yearInteger, (long)monthInteger];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:currentDate]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        dateStr = [NSString stringWithFormat:@"%4ld-%2ld-%2ld", (long)yearInteger, (long)monthInteger, (long)endDay];
    } else {
        //依然是当前年份
        dateStr = [NSString stringWithFormat:@"%zd-%zd-01",(long)components.year,(long)(components.month+gapMonthCount)];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:currentDate]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        
        dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",(long)components.year,(long)(components.month+gapMonthCount),(long)endDay];
    }
    newDate = [formatter dateFromString:dateStr];
    return newDate;
}

//判断是否是月末
+ (BOOL)isEndOfTheMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger daysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSDateComponents *componets = [calendar components:NSCalendarUnitDay fromDate:date];
    if (componets.day >= daysInMonth) {
        return YES;
    }
    return NO;
}

+ (NSDate *)date:(NSDate *)currentDate beforeDays:(NSUInteger)days {
    NSTimeInterval time = (days * 24 * 60 * 60);
    return [NSDate dateWithTimeInterval:-time sinceDate:currentDate];
}

@end
