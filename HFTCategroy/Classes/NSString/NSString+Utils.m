//
//  NSString+Utils.m
//  Erp4iOS
//
//  Created by fakepinge on 2017/11/27.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)

#pragma mark -  判断字符串是否存在 去掉空格后判断的
- (BOOL)isExist {
	NSString *temp = self;
	BOOL result = NO;
	if ([self isKindOfClass:[NSNumber class]]) {
		temp = [NSString stringWithFormat:@"%@",self];
	}
	if ([temp isNull]) {
        return result;
	} else if (temp == nil) {
		return result;
	} else if ([temp removeSpaceChar].length == 0) {
		return result;
	} else {
		result = YES;
	}
	return  result;
}

#pragma mark - 去除空格字符
- (NSString *)removeSpaceChar {
	return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 去除收尾空格和换行字符串
- (NSString *)removeEnterAndSpacesChar {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 去除Float型字符串小数点后多余的0
- (NSString *)removeFloatStrAllZero {
	NSString *outNumber = [NSString stringWithFormat:@"%@", @(self.doubleValue)];
	return outNumber;
}

#pragma mark - 取小数点后几位，如果后面是0会去掉
- (NSString *)getDecimalAfterPlaces:(NSInteger)offset {
    NSInteger space = labs(offset);
    // 保留两位并四舍五入
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:space raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *selfNum = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:@"1"];
    // 计算计算保留两位并四舍五入
    NSDecimalNumber *calculateNum = [selfNum decimalNumberByMultiplyingBy:num withBehavior:roundUp];
    return calculateNum.stringValue;
}

+ (NSString *)stringWithFormatRemoveRedundantZero:(CGFloat)orignalFloat {
    if (orignalFloat <= 0) {
        return @"0";
    }
    // 四舍五入，并保留两位小数
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"0.00"];
    NSString *temp = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:orignalFloat]];
    NSRange pointRange = [temp rangeOfString:@"."];
    
    if (pointRange.location != NSNotFound && temp.length > pointRange.location + 2) {
        if ([temp hasSuffix:@".00"]) {
            temp = [temp substringToIndex:temp.length - 3];
        } else if ([temp hasSuffix:@"0"]) {
            temp = [temp substringToIndex:temp.length - 1];
        }
    }
    return temp;
}

#pragma mark - 是否包含目标字符串
- (BOOL)isContainString:(NSString *)string {
	return [self rangeOfString:string].location != NSNotFound;
}

#pragma mark - 是否包含中文
- (BOOL)isContainChinese {
	for (int i = 0; i < self.length; i++) {
		int a = [self characterAtIndex:i];
		if( a > 0x4e00 && a < 0x9fff) {
			return YES;
		}
	}
	return NO;
}

#pragma mark - 是否全是数字
- (BOOL)isOnlyNumber {
	for (NSInteger i = 0; i < self.length; i++) {
		unichar ch = [self characterAtIndex:i];
		if (!((ch >= '0') && (ch <= '9'))){ // 0=48
			return NO;
		}
	}
	return YES;
}

#pragma mark - 是否全是字母
- (BOOL)isOnlyLetter {
	for (NSInteger i = 0; i < self.length; i++) {
		unichar ch = [self characterAtIndex:i];
		if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')))){ //0=48
			return NO;
		}
	}
	return YES;
}

#pragma mark - 是否全是数字或者全是字母
- (BOOL)isContainNumberOrLatter {
	for (NSInteger i = 0; i < self.length; i++) {
		unichar ch = [self characterAtIndex:i];
		if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')) || ((ch >= '0') && (ch <= '9')))) {
			return NO;
		}
	}
	return YES;
}

#pragma mark - 是否为浮点形
- (BOOL)isPureFloatNum {
	NSScanner *scan = [NSScanner scannerWithString:self];
	float val;
	return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark - 是否是整数
- (BOOL)isPureIntNum {
	NSScanner *scan = [NSScanner scannerWithString:self];
	int val;
	return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 是否是整数数或浮点数
- (BOOL)isPureIntOrFloat {
	if([self isPureIntNum] || [self isPureFloatNum]) {
		return YES;
	}
	return NO;
}

#pragma mark - 整数或者字母和数字(字母和数字可混合)
- (BOOL)isContainIntNumOrNumAndLatter {
	if ([self isPureIntNum]) { // 整数 包括负数
		return YES;
	}
	if ([self isContainNumberOrLatter]) { // 全是数字或者全是字母
		return YES;
	}
	return NO;
}

#pragma mark - 根据字体大小和限定的高度，得到宽度
- (CGFloat)getWidthStrWithFontSize:(CGFloat)fontSize height:(CGFloat)height {
	UIFont *font = [UIFont systemFontOfSize:fontSize]; // 文字的size
	CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
	return rect.size.width; // 文本的宽度
}

#pragma mark - 根据字体大小和限定的宽度，得到高度
- (CGFloat)getHeightStrWIthFontSize:(CGFloat)fontSize width:(CGFloat)width {
	UIFont *font = [UIFont systemFontOfSize:fontSize]; // 文字的size
	CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
	return rect.size.height; // 文本的高度
}

#pragma mark - 根据时间字符串和时间格式转换成date
- (NSDate *)getDateWithFormatStr:(NSString *)formatStr {
	if (![self isExist]) {
		return nil;
	}
	if (![formatStr isExist]) {
		return nil;
	}
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatStr];
	NSDate *date = [formatter dateFromString:self];
	return date;
}

#pragma mark - 根据时间字符串和时间格式转换成今天、昨天等等
- (NSString *)getTimeLineStrSinceNowWithFormatString:(NSString *)formatString {
	if (![self isExist] || ![formatString isExist]) {
		return self;
	}
	NSRange dateRange = [formatString rangeOfString:@"^yyyy.*MM.*dd.*((HH)|(hh)).*mm.*ss$" options:NSRegularExpressionSearch];
	if (!NSEqualRanges(dateRange, NSMakeRange(0, formatString.length))) {
		return self;
	}
	NSRange timeRange = [formatString rangeOfString:@"((HH)|(hh)).*mm" options:NSRegularExpressionSearch];
	NSDate *date = [self getDateWithFormatStr:formatString];
	double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
	NSString *dateString = @"";
	switch ((int)(([[NSDate date] timeIntervalSince1970] + timezoneFix)/(24*3600)) -
			(int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600))) {
		case 0:
			dateString = [NSString stringWithFormat:@"今天 %@", [self substringWithRange:timeRange]];
			break;
		case 1:
			dateString = [NSString stringWithFormat:@"昨天 %@", [self substringWithRange:timeRange]];
			break;
		default: {
			dateRange = [formatString rangeOfString:@"^yyyy.*MM.*dd.*((HH)|(hh)).*mm" options:NSRegularExpressionSearch];
			dateString = [self substringWithRange:dateRange];
		}
			break;
	}
	return dateString;
}

#pragma mark - 百分号编码
- (NSString *)percentEncryptString {
    if (![self isExist]) {
        return @"";
    }
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef) self, nil, CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "), kCFStringEncodingUTF8);
    NSString *string = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];
    return string;
}

#pragma mark - 百分号解码
- (NSString *)percentDecodeString {
    if (![self isExist]) {
        return @"";
    }
    NSString *str = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString *string = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}

#pragma mark - 字符串md5加密
- (NSString *)hft_md5_string {
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digestStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digestStr appendFormat:@"%02x", result[i]];
    }
    return digestStr;
}

+ (NSString *)getParamsStringWithParamsDict:(NSDictionary *)paramsDict andUrlString:(NSString *)urlString {
    NSString *paramsStr = [NSString getParamsStringWithParamsDict:paramsDict];
    if ([paramsStr isExist]) {
        if ([urlString containsString:@"?"]) {
            NSString *str = [urlString componentsSeparatedByString:@"?"].lastObject;
            if ([str containsString:@"/"]) {
                urlString = [NSString stringWithFormat:@"%@?%@", urlString, paramsStr];
            } else {
                urlString = [NSString stringWithFormat:@"%@&%@", urlString, paramsStr];
            }
        } else {
            urlString = [NSString stringWithFormat:@"%@?%@", urlString, paramsStr];
        }
    }
    return urlString;
}

+ (NSString *)getParamsStringWithParamsDict:(NSDictionary *)paramsDict {
    if (!paramsDict || paramsDict.allKeys.count == 0) return nil;
    NSMutableArray *paramsStrArr = [NSMutableArray array];
    for (NSString *key in paramsDict.allKeys) {
        id value = [paramsDict valueForKey:key];
        NSString *valueStr;
        if ([value isKindOfClass:[NSNumber class]]) {
            valueStr = [NSString stringWithFormat:@"%d", [value intValue]];
        } else if ([value isKindOfClass:[NSString class]]) {
            valueStr = (NSString *)value;
        }
        if ([valueStr isExist]) {
            NSString *paramsStr = [NSString stringWithFormat:@"%@=%@", key, valueStr.percentEncryptString];
            [paramsStrArr addObject:paramsStr];
        }
    }
    if (paramsStrArr.count == 0) return nil;
    return [paramsStrArr componentsJoinedByString:@"&"];
}

#pragma mark - json字符串转字典
- (NSDictionary *)getJsonDictData {
    if (!self.isExist) return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) return nil;
    return dict;
}

#pragma mark - 是否是工作时间
+ (BOOL)isWorkingTimeWhenNowDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* currentDate = [NSDate date];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond |NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents *comp = [gregorian components:unitFlags fromDate:currentDate];
    NSInteger hour = comp.hour;
    if(hour > 9 && hour < 18) {
        return YES;
    }
    return NO;
}

#pragma mark ----------------------------- 私有方法 ------------------------------
// 是否为null
- (BOOL)isNull {
	return [self isKindOfClass:[NSNull class]];
}

@end
