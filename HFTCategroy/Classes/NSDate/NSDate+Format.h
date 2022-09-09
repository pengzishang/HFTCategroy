//
//  NSDate+Format.h
//  Erp4iOS
//
//  Created by cheaterhu on 2017/8/18.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

/**
 *  格式化时间戳
 */
+ (NSString *)formatTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr;


/**
 *  格式化NSDate
 */
+ (NSString *)formatDate:(NSDate *)date formatStr:(NSString *)formatStr;

/**
 *  将字符串时间转化为date
 */
+ (NSDate *)dateFromString:(NSString *)dateStr formatStr:(NSString *)formatStr;


/**
 比较两个date
 return 1 : oneDate > anotherDate, -1 : oneDate < anotherDate
 */
+ (int)compareOneDate:(NSDate *)oneDate withAnotherDate:(NSDate *)anotherDate;

/**
 获取今天时间字符串
 */
+ (NSString *)todayStr;

/**
 计算几个月后的日期
 */
+ (NSDate *)date:(NSDate *)currentDate appendMonth:(NSUInteger)gapMonthCount;

/**
 计算前几天的日期
 */
+ (NSDate *)date:(NSDate *)currentDate beforeDays:(NSUInteger)days;

@end
