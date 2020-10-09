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

#define rectOfNavigationbar self.navigationController.navigationBar.frame.size.height//获取导航栏的高


#endif /* MacroDef_Size_h */
