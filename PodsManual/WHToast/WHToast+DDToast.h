//
//  WHToast+DDToast.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/10.
//

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface WHToast (DDToast)
/** 仅文字，展示在屏幕中间 */
+(void)toastMsg:(NSString *)msg;
/** 失败图标和文字，展示在屏幕中间 */
+(void)toastErrMsg:(NSString *)errMsg;
/** 成功图标和文字，展示在屏幕中间 */
+(void)toastSuccessMsg:(NSString *)successMsg;

@end

NS_ASSUME_NONNULL_END
