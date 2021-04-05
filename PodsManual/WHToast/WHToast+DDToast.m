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
/** 延时操作 */
+(void)toastLoadingMsg:(NSString *)errMsg{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"toastLoading" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_imageWithGIFData:data];
        [WHToast showImage:image
                   message:errMsg
                  duration:LONG_LONG_MAX
             finishHandler:nil];
    });
}
/** 手动关闭WHToast，在主线程*/
+(void)toastHide{
    dispatch_async(dispatch_get_main_queue(), ^{
       // UI更新代码
        [WHToast hide];
    });
}
/** 当前进度 */
+(void)loadSchedule:(CGFloat)Schedule{
//    dispatch_async(dispatch_get_main_queue(), ^{
//       // UI更新代码
//        WHToast.sharedInstance.toastView.messageLabel.text = [NSString stringWithFormat:@"当前进度：%.2f",Schedule];
//    });
}

@end
