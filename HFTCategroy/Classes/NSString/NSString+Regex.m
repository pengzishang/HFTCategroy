//
//  NSString+Regex.m
//  HFTCategroy_Example
//
//  Created by Virusboo on 2018/1/12.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//

#import "NSString+Regex.h"
#import "NSString+Utils.h"

@implementation NSString (Regex)

- (BOOL)isValidMobile
{
    NSString *regex = @"^1[3-9]\\d{9}$";
    return [self evaluateWithRegex:regex];
}

- (BOOL)isValidID
{
    NSString *regex = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)";
    return [self evaluateWithRegex:regex];
}

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self evaluateWithRegex:regex];
}

- (BOOL)isValidUrl
{
    NSString *regex = @"[a-zA-z]+://[^\\s]*";
    assert(self != nil);
    if (![self isExist]) {
        return NO;
    }
    return [self evaluateWithRegex:regex];
}

- (BOOL)includeChinese
{
    for(int i = 0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isValidUserName
{
    NSString *regex = @"^[a-zA-Z一-龥]{1,20}";
    return [self evaluateWithRegex:regex];
}

- (BOOL)isValidSMSCode
{
    NSString *regex = @"^[0-9]{6}$";
    return [self evaluateWithRegex:regex];
}

- (BOOL)isValidLoginPwd
{
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    return [self evaluateWithRegex:regex];
}

- (BOOL)evaluateWithRegex:(NSString *)regex
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

@end
