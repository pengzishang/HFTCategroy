/*******************************************************************************
 # File        : UITextView+PlaceHolder.h
 # Project     : Erp4iOS
 # Author      : fakepinge
 # Created     : 2017/8/15
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 
 -------------------------------------------------------------------------------
 # Date        : 2017/8/15
 # Author      : fakepinge
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import <UIKit/UIKit.h>

@interface UITextView (PlaceHolder)
/** 
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *zw_placeHolder;
/** 
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/** 
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *zw_placeHolderColor;

@end
