//
//  UIButton+Expand.m
//  HFTCategroy_Example
//
//  Created by virusboo on 2018/5/8.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "UIButton+Expand.h"
#import <objc/runtime.h>

@implementation UIButton (Expand)
@dynamic expandEdgeInsets;
static char const key_expandEdgeInsets;

- (void)setExpandEdgeInsets:(UIEdgeInsets)expandEdgeInsets {
    NSValue *value = [NSValue value:&expandEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &key_expandEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)expandEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &key_expandEdgeInsets);
    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }
    return UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.expandEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect expandFrame = UIEdgeInsetsInsetRect(relativeFrame, self.expandEdgeInsets);
    return CGRectContainsPoint(expandFrame, point);
}

@end
