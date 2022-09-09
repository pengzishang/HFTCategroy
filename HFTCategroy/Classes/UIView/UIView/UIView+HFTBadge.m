//
//  UIView+HFTBadge.m
//  ErpApp
//
//  Created by virusboo on 2019/2/22.
//  Copyright © 2019 haofangtongerp. All rights reserved.
//

#import "UIView+HFTBadge.h"
#import <objc/runtime.h>

static char key_dotHeight;
static char key_badgeHeight;
static char key_badgeColor;
static char key_adjustOffsetX;
static char key_adjustOffsetY;
static char key_needBorder;
static char key_badgeView;
static char key_badgeLabel;

static const CGFloat DOT_HEIGHT = 6;
static const CGFloat TEXT_FONT = 12;
static CGFloat BORDER_WIDTH;

@implementation UIView (HFTBadge)
#pragma mark - API
- (void)hideBadge {
    [self.badgeView removeFromSuperview];
    [self.badgeLabel removeFromSuperview];
    self.badgeView = nil;
    self.badgeLabel = nil;
}

- (void)showBadge {
    if (self.badgeView || self.badgeLabel) {
        [self hideBadge];
    }
    if (nil == self.badgeView) {
        [self layoutIfNeeded];
        BORDER_WIDTH = self.needBorder? 2 : 0;
        CGFloat dotHeight = self.dotHeight > 0? self.dotHeight : DOT_HEIGHT;
        dotHeight += BORDER_WIDTH;
        CGFloat dotHalf = dotHeight*0.5;
        CGFloat dotX = CGRectGetWidth(self.frame) - dotHalf + self.adjustOffsetX;
        CGFloat dotY = -dotHalf + self.adjustOffsetY;
        CGRect frame = CGRectMake(dotX, dotY, dotHeight, dotHeight);
        self.badgeView = [[UIView alloc] initWithFrame:frame];
        self.badgeView.backgroundColor = self.badgeColor? : [UIColor redColor];
        self.badgeView.layer.cornerRadius = dotHalf;
        self.badgeView.layer.masksToBounds = YES;
        if (BORDER_WIDTH > 0) {
            self.badgeView.layer.borderWidth = BORDER_WIDTH;
            self.badgeView.layer.borderColor = [[UIColor whiteColor] CGColor];
        }
        [self addSubview:self.badgeView];
        [self bringSubviewToFront:self.badgeView];
    }
}

- (void)showBadgeWithText:(NSString *)text {
    if (self.badgeView || self.badgeLabel) {
        [self hideBadge];
    }
    if (nil == self.badgeLabel) {
        [self layoutIfNeeded];
        BORDER_WIDTH = self.needBorder? 2 : 0;
        self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.badgeLabel];
        [self bringSubviewToFront:self.badgeLabel];
        self.badgeLabel.backgroundColor = self.badgeColor? : [UIColor redColor];
        self.badgeLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
        self.badgeLabel.text = text;
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        [self.badgeLabel sizeToFit];
        CGRect frame = self.badgeLabel.frame;
        CGFloat badgeWidth = frame.size.width + 6 + BORDER_WIDTH;
        CGFloat badgeHeight = MAX(frame.size.height + 2, self.badgeHeight) + BORDER_WIDTH;
        badgeWidth = MAX(badgeWidth, badgeHeight); //宽不能比高还小
        CGFloat badgeX = CGRectGetWidth(self.frame) - badgeWidth*0.5 + self.adjustOffsetX;
        CGFloat badgeY = -badgeHeight*0.5 + self.adjustOffsetY;
        self.badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeWidth, badgeHeight);
        self.badgeLabel.layer.cornerRadius = badgeHeight*0.5;
        self.badgeLabel.layer.masksToBounds = YES;
        if (BORDER_WIDTH > 0) {
            self.badgeLabel.layer.borderWidth = BORDER_WIDTH;
            self.badgeLabel.layer.borderColor = [[UIColor whiteColor] CGColor];
        }
    }
}

#pragma mark - setter&getter
- (void)setDotHeight:(CGFloat)dotHeight {
    objc_setAssociatedObject(self, &key_dotHeight, @(dotHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)dotHeight {
    NSNumber *value = objc_getAssociatedObject(self, &key_dotHeight);
    return value.floatValue;
}

- (void)setBadgeHeight:(CGFloat)badgeHeight {
    objc_setAssociatedObject(self, &key_badgeHeight, @(badgeHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)badgeHeight {
    NSNumber *value = objc_getAssociatedObject(self, &key_badgeHeight);
    return value.floatValue;
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    objc_setAssociatedObject(self, &key_badgeColor, badgeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeColor {
    return objc_getAssociatedObject(self, &key_badgeColor);
}

- (void)setAdjustOffsetX:(CGFloat)adjustOffsetX {
    objc_setAssociatedObject(self, &key_adjustOffsetX, @(adjustOffsetX), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)adjustOffsetX {
    NSNumber *value = objc_getAssociatedObject(self, &key_adjustOffsetX);
    return value.floatValue;
}
- (void)setAdjustOffsetY:(CGFloat)adjustOffsetY {
    objc_setAssociatedObject(self, &key_adjustOffsetY, @(adjustOffsetY), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)adjustOffsetY {
    NSNumber *value = objc_getAssociatedObject(self, &key_adjustOffsetY);
    return value.floatValue;
}

- (void)setNeedBorder:(BOOL)needBorder {
    objc_setAssociatedObject(self, &key_needBorder, @(needBorder), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)needBorder {
    NSNumber *value = objc_getAssociatedObject(self, &key_needBorder);
    return value.boolValue;
}

- (void)setBadgeView:(UIView *)badgeView {
    objc_setAssociatedObject(self, &key_badgeView, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)badgeView {
    return objc_getAssociatedObject(self, &key_badgeView);
}

- (void)setBadgeLabel:(UILabel *)badgeLabel {
    objc_setAssociatedObject(self, &key_badgeLabel, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLabel {
    return objc_getAssociatedObject(self, &key_badgeLabel);
}

@end
