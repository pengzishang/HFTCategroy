/*******************************************************************************
 # File        : HFTRouter.h
 # Project     : Erp4iOS
 # Author      : Andrew
 # Created     : 15/6/17
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 监听类
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^APPObserverBlock)(id object);
typedef void(^APPObserverOldAndNewBlock)(id object,id oldValue, id newValue);


@interface APPObserver : NSObject

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
                  block:(APPObserverBlock)block;

+ (id)observerForObject:(id)object
                keyPath:(NSString *)keyPath
         oldAndNewBlock:(APPObserverOldAndNewBlock)block;

- (void)stopObserving;

@end

NS_ASSUME_NONNULL_END
