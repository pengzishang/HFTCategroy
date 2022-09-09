//
//  NSDictionary+Json.h
//  TestErpApp
//
//  Created by fakepinge on 2017/11/27.
//  Copyright © 2017年 fakepinge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)

- (NSString *)jsonString:(NSString *)key;
- (NSDictionary *)jsonDict:(NSString *)key;
- (NSArray *)jsonArray:(NSString *)key;
- (NSArray *)jsonStringArray:(NSString *)key;

- (BOOL)jsonBool:(NSString *)key;
- (NSInteger)jsonInteger:(NSString *)key;
- (double)jsonDouble:(NSString *)key;
- (long long)jsonLongLong:(NSString *)key;
- (unsigned long long)jsonUnsignedLongLong:(NSString *)key;

@end
