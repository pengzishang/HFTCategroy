//
//  UITableView+Method.h
//  Objective-C
//
//  Created by 陈中培 on 15/3/10.
//  Copyright (c) 2015年 陈中培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Method)

/// 去掉多余的Cell
- (void)eliminateExtraSeparators;

/// 返回点击区域的NSIndexPath
/// @param event 点击事件
- (NSIndexPath *)indexPathFromEvent:(UIEvent *)event;

@end
