#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "APPObserver.h"
#import "NSArray+Safe.h"
#import "NSDate+Format.h"
#import "NSDate+Ticks.h"
#import "NSDictionary+Json.h"
#import "NSDictionary+NilSafe.h"
#import "NSObject+Runtime.h"
#import "NSString+Regex.h"
#import "NSString+Utils.h"
#import "NSTimer+HFTBlockSupport.h"
#import "UIColor+Tool.h"
#import "UIResponder+Router.h"
#import "UIBarButtonItem+Badge.h"
#import "UIButton+Expand.h"
#import "UIButton+Layout.h"
#import "UIButton+VerificationCode.h"
#import "UIImage+Edit.h"
#import "UIImage+Reduce.h"
#import "UIImage+Tool.h"
#import "UIImageView+Blur.h"
#import "UIImageView+Tool.h"
#import "UILabel+Community.h"
#import "UILabel+Tool.h"
#import "UITableView+Method.h"
#import "UITextView+PlaceHolder.h"
#import "UITabBar+HFTRedBadge.h"
#import "UIView+Border.h"
#import "UIView+Corner.h"
#import "UIView+Frame.h"
#import "UIView+HFTBadge.h"
#import "UIView+Responder.h"

FOUNDATION_EXPORT double HFTCategroyVersionNumber;
FOUNDATION_EXPORT const unsigned char HFTCategroyVersionString[];

