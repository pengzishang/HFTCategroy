//
//  NSObject+Runtime.h
//  Erp4iOS
//
//  Created by Andrew on 14/8/17.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (Runtime)

+ (BOOL)hft_hookOrigMenthod:(SEL)origSel NewMethod:(SEL)altSel;

@end
