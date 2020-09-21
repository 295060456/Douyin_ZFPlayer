//
//  NSObject+Extras.h
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extras)
///震动特效反馈
+(void)feedbackGenerator;
/*
 * 检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
 * 作用范围:在sceneDidEnterBackground（iOS 13及其以上版本有效） && applicationDidEnterBackground（iOS 13以下版本有效）
 * 调试是否进入后台，要断开于Xcode的连接，否则屏幕常亮
 */
+(BOOL)didUserPressLockButton;
///iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch;

@end
