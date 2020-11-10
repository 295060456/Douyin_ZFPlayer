//
//  MacroDef_Size.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Size_h
#define MacroDef_Size_h

///缩放比例
#define SCALING_RATIO(UISize) (UISize) * Device_Width / 375.0f//全局比例尺
#define KDeviceHeightScale Device_Height / 812    //獲取屏幕高度比例
#define KDeviceRealScale [[MKTools shared] deviceRealScaleMetod]
#define kButtonDefaultWidth (kIPhone4s ? 278 : 288)   //默认输入框宽
#define kButtonDefaultHeight 45  //默认输入框&按钮高
#define ELSareArea  (MAX(Device_Width, Device_Height)  == 812 ? 34.00 : 0.00)
#define NAVH (MAX(Device_Width, Device_Height)  == 812 ? 88 : 64)
#define TABBARH (MAX(Device_Width, Device_Height)  == 812 ? 83 : 49)
#define ELSareArea  (MAX(Device_Width, Device_Height)  == 812 ? 34.00 : 0.00)
#define kStatusBarHeight        (isiPhoneX ? 44 :20)
#define kNavigationBarHeight     44
#define kNavigationheightForIOS7 64
#define kContentHeight           (Device_Height - kNavigationheightForIOS7 - kTabBarHeight)
#define kTabBarHeight             (isiPhoneX ? 83 : 49)
#define KNavigationItemSpace     -15
#define KBottomHeight (isiPhoneX ? 34 :0)
#define Height_For_Section_Header 10.0   //Cell Header分隔
#define Height_For_Section_Footer 0.0001 //Cell Footer分隔
#define KCellLeftGap   12  //左边对齐间隙
#define KCellRightGap  12  //右边对齐间隙

#define isiPhoneX       (((kScreenHeight  == 812.0) || (kScreenHeight  == 896.0) || (kScreenHeight  == 852.0)) ? 1 : 0)
#define isiPhoneXR__XMax      ((kScreenHeight  == 896.0) ? 1 : 0)

#define isiPhoneX_seriesBottom 30
#define isiPhoneX_seriesTop 34

#define MianScreen          UIScreen.mainScreen.bounds.size
#define Device_Width        MianScreen.width//获取屏幕宽高
#define Device_Height       MianScreen.height
#define MAINSCREEN_WIDTH    Device_Width
#define MAINSCREEN_HEIGHT   Device_Height

#define SCREEN_MAX_LENGTH   (MAX(Device_Width, Device_Height))
#define SCREEN_MIN_LENGTH   (MIN(Device_Width, Device_Height))

#import <UIKit/UIKit.h>

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

#import "MacroDef_Func.h"
//非刘海屏：状态栏高度(20.f) + 导航栏高度(44.f) = 64.f
//刘海屏系列：状态栏高度(44.f) + 导航栏高度(44.f) = 88.f
static inline CGFloat Top(){
    static CGFloat value = 0;
    static dispatch_once_t once_t = 0;
    dispatch_once(&once_t, ^{
        value = isiPhoneX_series() ? 88.0f : 64.0f;
    });
    return value;
}
//获取状态栏的高度，全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
//状态栏高度
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
    return StatusBarHeight() + 44;
}
//tabbar高度
static inline CGFloat TabBarHeight(){
    return StatusBarHeight() == 44 ? 83 : 49;
}
//顶部的安全距离
static inline CGFloat TopSafeAreaHeight(){
    return StatusBarHeight() - 20;
}
//底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
static inline CGFloat BottomSafeAreaHeight(){
    return TabBarHeight() - 49;
}

#endif /* MacroDef_Size_h */
