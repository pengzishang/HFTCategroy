//
//  NSDictionary+NilSafe.h
//  NSDictionary-NilSafe
//
//  Created by Allen Hsu on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NilSafe)

/**
 * 删除字典里value未NULL的元素
 */
- (NSDictionary *)deleteAllNullValue;

@end

@interface NSMutableDictionary (NilSafe)

@end

@interface NSNull (NilSafe)

@end
