//
//  MacroDef_Size.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Size_h
#define MacroDef_Size_h

#import <UIKit/UIKit.h>
#import "MacroDef_Func.h"
#import "MacroDef_AppDeviceScreenSize.h"

#define MainScreen          UIScreen.mainScreen.bounds.size
#define Device_Width        MainScreen.width//获取屏幕宽高
#define Device_Height       MainScreen.height
#define SCREEN_WIDTH        Device_Width
#define SCREEN_HEIGHT       Device_Height

#define SCREEN_MAX_LENGTH   (MAX(Device_Width, Device_Height))
#define SCREEN_MIN_LENGTH   (MIN(Device_Width, Device_Height))

#pragma mark —— 安全区域
//顶部的安全距离
static inline CGFloat TopSafeAreaHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.top;
    } else {
        return 0.f;
    }
}
//底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
static inline CGFloat BottomSafeAreaHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.bottom;
    } else {
        return 0.f;
    }
}
#pragma mark —— 状态栏高度：全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
//方法一：状态栏高度
static inline CGFloat rectOfStatusbar(){
    SuppressWdeprecatedDeclarationsWarning(
        if (@available(iOS 13.0, *)){
            UIStatusBarManager *statusBarManager = getMainWindow().windowScene.statusBarManager;
            return statusBarManager.statusBarHidden ? 0 : statusBarManager.statusBarFrame.size.height;
        }else{
            return UIApplication.sharedApplication.statusBarFrame.size.height;
        });
}
//方法二：状态栏高度
static inline CGFloat StatusBarHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.top;
    } else {
        return rectOfStatusbar();
    }
}
/// 导航栏高度
/// @param navigationController 传nil为系统默认navigationController高度；因为navigationController可以自定义高度，传自定义navigationController返回自定义的navigationController的高度
static inline CGFloat NavigationHeight(UINavigationController * _Nullable navigationController){
    if (navigationController) {
        return navigationController.navigationBar.frame.size.height;
    }else{
        return 44.f;
    }
}
/// 状态栏 + 导航栏高度
/// 非刘海屏：状态栏高度(20.f) + 导航栏高度(44.f) = 64.f
/// 刘海屏系列：状态栏高度(44.f) + 导航栏高度(44.f) = 88.f
static inline CGFloat NavigationBarAndStatusBarHeight(UINavigationController * _Nullable navigationController){
    return StatusBarHeight() + NavigationHeight(navigationController);
}
/// tabbar高度：全面屏手机比普通手机多34的安全区域
/// @param tabBarController 传nil为系统默认tabbar高度；因为tabBarController可以自定义高度，传自定义tabBarController返回自定义的tabBarController的高度
static inline CGFloat TabBarHeight(UITabBarController * _Nullable tabBarController){
    //因为tabbar可以自定义高度，所以这个地方返回系统默认的49像素的高度
    if (tabBarController) {
        return tabBarController.tabBar.frame.size.height;;
    }else{
        return 49.f;
    }
}
//tabbar高度：【包括了底部安全区域的TabBar高度，一般用这个】
static inline CGFloat TabBarHeightByBottomSafeArea(UITabBarController * _Nullable tabBarController){
    return TabBarHeight(tabBarController) + BottomSafeAreaHeight();
}

#endif /* MacroDef_Size_h */
