//
//  UIButton+Layout.h
//  HFTCategroy_Example
//
//  Created by virusboo on 2018/9/28.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonLayout) {
    ButtonLayoutCenter,          //图片和title都居中
    ButtonLayoutTop,             //图片在文字上面
    ButtonLayoutLeft,            //图片在文字左边
    ButtonLayoutBottom,          //图片在文字底下
    ButtonLayoutRight            //图片在文字右边
};

@interface UIButton (Layout)

/**
 按钮添加布局方式

 @param layout 布局方式
 @param spacing 间隔
 */
- (void)setLayout:(ButtonLayout)layout spacing:(CGFloat)spacing;
@end
