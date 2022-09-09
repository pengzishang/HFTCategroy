//
//  UIView+Responder.h
//  HFTCategroy_Example
//
//  Created by Virusboo on 2018/1/8.
//  Copyright © 2018年 Andrew_Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Responder)

/**
 找到自己所在的VC

 @return 自己所属的视图控制器
 */
- (UIViewController *)hft_viewController;

@end
