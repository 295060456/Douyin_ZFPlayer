//
//  WHToast+DDToast.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/10.
//

#import "WHToast+DDToast.h"

@implementation WHToast (DDToast)
/** 仅文字，展示在屏幕中间 */
+(void)toastMsg:(NSString *)msg{
    [WHToast showMessage:msg
                duration:1.5
           finishHandler:nil];
}
/** 成功图标和文字，展示在屏幕中间 */
+(void)toastSuccessMsg:(NSString *)successMsg{
    [WHToast showSuccessWithMessage:successMsg
                           duration:1.5
                      finishHandler:nil];
}
/** 失败图标和文字，展示在屏幕中间 */
+(void)toastErrMsg:(NSString *)errMsg{
    [WHToast showErrorWithMessage:errMsg
                         duration:1.5
                    finishHandler:nil];
}


@end
