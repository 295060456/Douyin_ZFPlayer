//
//  NSObject+Extras.m
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import "NSObject+Extras.h"

@implementation NSObject (Extras)
///震动特效反馈
+(void)feedbackGenerator{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    } else {
        // Fallback on earlier versions
    }
}
///检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
+(BOOL)didUserPressLockButton{
    //获取屏幕亮度
    CGFloat oldBrightness = [UIScreen mainScreen].brightness;
    //以较小的数量改变屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01));
    CGFloat newBrightness  = [UIScreen mainScreen].brightness;
    //恢复屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness;
    //判断屏幕亮度是否能够被改变
    return oldBrightness != newBrightness;
}
///iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch{
    [[UIApplication sharedApplication] setIdleTimerDisabled:lockSwitch];
}

@end
