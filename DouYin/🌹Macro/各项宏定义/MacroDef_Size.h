//
//  MacroDef_Size.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Size_h
#define MacroDef_Size_h

#define MianScreen          UIScreen.mainScreen.bounds.size
#define Device_Width        MianScreen.width//获取屏幕宽高
#define Device_Height       MianScreen.height
#define MAINSCREEN_WIDTH    Device_Width
#define MAINSCREEN_HEIGHT   Device_Height

#define SCREEN_MAX_LENGTH   (MAX(Device_Width, Device_Height))
#define SCREEN_MIN_LENGTH   (MIN(Device_Width, Device_Height))

#import <UIKit/UIKit.h>
#import "MacroDef_Func.h"
//非刘海屏：状态栏高度(20.f) + 导航栏高度(44.f) = 64.f
//刘海屏系列：状态栏高度(44.f) + 导航栏高度(44.f) = 88.f
static inline CGFloat Top(){
    static CGFloat value = 0;
    static dispatch_once_t once_t = 0;
    dispatch_once(&once_t, ^{
        value = isiPhoneX_series() ? 88.0f : 64.0f;
    });return value;
}
#pragma mark —— 状态栏高度：全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
//方法一：
static inline CGFloat rectOfStatusbar(){
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    CGFloat RectOfStatusbar = 0.0f;
    if (@available(iOS 13.0, *)){
        id WINDOW = UIApplication.sharedApplication.windows.firstObject;
        if ([WINDOW isKindOfClass:UIWindow.class]) {
            UIWindow *window = (UIWindow *)WINDOW;
            UIWindowScene *windowScene = window.windowScene;
            UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
            if (statusBarManager.statusBarHidden == NO) {
                RectOfStatusbar = statusBarManager.statusBarFrame.size.height;
//                statusBarManager.statusBarFrame.mj_h
            }else{}
        }
    }else{
        RectOfStatusbar = UIApplication.sharedApplication.statusBarFrame.size.height;
    }return RectOfStatusbar;
#pragma clang diagnostic pop
}
//方法二：
static inline CGFloat StatusBarHeight(){
    if (@available(iOS 13.0, *)) {
        return getMainWindow().windowScene.statusBarManager.statusBarFrame.size.height;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        return [[UIApplication sharedApplication] statusBarFrame].size.height;
#pragma clang diagnostic pop
    }
}
//导航栏高度
static inline CGFloat NavigationHeight(){
    NSLog(@"%f",StatusBarHeight());
    return StatusBarHeight() + 44;
}
//tabbar高度：全面屏手机比普通手机多34的安全区域
#import "DouYinAppDelegate.h"
#import "TabbarVC.h"
static inline CGFloat TabBarHeight(){
    //即时获取
    CGFloat tabBarHeight = DouYinAppDelegate.sharedInstance.tabbarVC.tabBar.frame.size.height;
    NSLog(@"tabBarHeight = %f",tabBarHeight);
    return tabBarHeight;
}
//顶部的安全距离
static inline CGFloat TopSafeAreaHeight(){
    return StatusBarHeight() - 20;
}
//底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
static inline CGFloat BottomSafeAreaHeight(){
    NSLog(@"%f",TabBarHeight());
    return TabBarHeight() - 49 - DouYinAppDelegate.sharedInstance.tabbarVC.myTabBar.offsetHeight;
}

#endif /* MacroDef_Size_h */
