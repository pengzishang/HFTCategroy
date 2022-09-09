//
//  NSObject+Runtime.m
//  Erp4iOS
//
//  Created by Andrew on 14/8/17.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (BOOL)hft_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel {
	Class class = [self class];
	Method origMethod = class_getInstanceMethod(class, origSel);
	Method altMethod = class_getInstanceMethod(class, altSel);
	if (!origMethod || !altMethod) {
		return NO;
	}
	BOOL didAddMethod = class_addMethod(class,origSel,
										method_getImplementation(altMethod),
										method_getTypeEncoding(altMethod));
	if (didAddMethod) {
		class_replaceMethod(class,altSel,
							method_getImplementation(origMethod),
							method_getTypeEncoding(origMethod));
	} else {
		method_exchangeImplementations(origMethod, altMethod);
	}

	return YES;
}


@end
