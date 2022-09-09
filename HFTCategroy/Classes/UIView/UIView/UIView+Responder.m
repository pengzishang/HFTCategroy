//
//  UIView+Responder.m
//  HFTCategroy_Example
//
//  Created by Virusboo on 2018/1/8.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//

#import "UIView+Responder.h"

@implementation UIView (Responder)

- (UIViewController *)hft_viewController {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
