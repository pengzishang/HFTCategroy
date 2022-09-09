//
//  NSString+Regex.h
//  HFTCategroy_Example
//
//  Created by Virusboo on 2018/1/12.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//
/**
 字符串正则表达式的匹配
 */
#import <Foundation/Foundation.h>

@interface NSString (Regex)

/**
 正则匹配移动电话号码
 
 @return 布尔值
 */
- (BOOL)isValidMobile;

/**
 正则匹配大陆身份证号码
 
 @return 布尔值
 */
- (BOOL)isValidID;

/**
 正则匹配邮箱地址
 
 @return 布尔值
 */
- (BOOL)isValidEmail;

/**
 正则匹配链接地址
 参考链接 ：//http://blog.csdn.net/qxuewei/article/details/51326017
 @return 布尔值
 */
- (BOOL)isValidUrl;

/**
 正则字符串是否含有汉字
 
 @return 布尔值
 */
- (BOOL)includeChinese;
/**
 正则匹配用户姓名,20位以内的中文或英文
 
 @return 布尔值
 */
- (BOOL)isValidUserName;
/**
 正则匹配短信验证码 6位
 
 @return 布尔值
 */
- (BOOL)isValidSMSCode;
/**
 正则匹配登录密码(6-20位数字和字母组合)
 */
@property (nonatomic, assign, readonly) BOOL isValidLoginPwd;

@end
