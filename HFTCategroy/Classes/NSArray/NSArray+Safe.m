//
//  NSArray+Safe.m
//  ErpApp
//
//  Created by rztime on 2017/12/14.
//  Copyright © 2017年 haofangtongerp. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (![self isKindOfClass:[NSArray class]] || self.count == 0) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
