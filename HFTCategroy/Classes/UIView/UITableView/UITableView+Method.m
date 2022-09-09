//
//  UITableView+Method.m
//  Objective-C
//
//  Created by 陈中培 on 15/3/10.
//  Copyright (c) 2015年 陈中培. All rights reserved.
//

#import "UITableView+Method.h"

@implementation UITableView (Method)

- (void)eliminateExtraSeparators {
    UIView *sb = [UIView new];
    sb.backgroundColor = [UIColor clearColor];
    self.tableFooterView = sb;
}

- (NSIndexPath *)indexPathFromEvent:(UIEvent *)event {
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    NSIndexPath *indexPath= [self indexPathForRowAtPoint:currentTouchPosition];
    return indexPath;
}

@end
