//
//  ToolMacro.h
//  Aa
//
//  Created by Aalto on 2018/11/18.
//  Copyright © 2018 Aalto. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

#pragma mark ======================================== Sys.========================================
#define HDAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//标识应用程序的发布版本号
#define HDAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]//APP BUILD 版本号
#define HDAppDisplayName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"]// APP名字
#define HDLocalLanguage [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]//当前语言
#define HDLocalCountry [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]//当前国家
#define HDDevice [UIDevice currentDevice]
#define HDDeviceName HDDevice.name                           // 设备名称
#define HDDeviceModel HDDevice.model                         // 设备类型
#define HDDeviceLocalizedModel HDDevice.localizedModel       // 本地化模式
#define HDDeviceSystemName HDDevice.systemName               // 系统名字
#define HDDeviceSystemVersion HDDevice.systemVersion         // 系统版本
#define HDDeviceOrientation HDDevice.orientation             // 设备朝向
#define CURRENTLANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])// 当前语言
#define UDID HDDevice.identifierForVendor.UUIDString // UUID // 使用苹果不让上传App Store!!!
#define HDiPhone ([HDDeviceModel rangeOfString:@"iPhone"].length > 0)
#define HDiPod ([HDDeviceModel rangeOfString:@"iPod"].length > 0)
#define isPad (HDDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)// 是否iPad
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)//是否iPhone
#define isRetina ([[UIScreen mainScreen] scale] >= 2.0)// 非Retain屏幕 1.0

#define isiPhoneX       (((kScreenHeight  == 812.0) || (kScreenHeight  == 896.0) || (kScreenHeight  == 852.0)) ? 1 : 0)
#define isiPhoneXR__XMax      ((kScreenHeight  == 896.0) ? 1 : 0)

#import "SceneDelegate.h"

static inline UIWindow * getMainWindow(){
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        window = [SceneDelegate sharedInstance].window;
    }else{
        window = UIApplication.sharedApplication.delegate.window;
//        [UIApplication sharedApplication].keyWindow 
    }
//    window.backgroundColor = [UIColor redColor];
    return window;
}
/**
 是否是iPhone刘海屏系列：   X系列（X/XS/XR/XS Max)、11系列（11、pro、pro max）
 @return YES 是该系列 NO 不是该系列
 */
static inline BOOL isiPhoneX_series() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }

    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = getMainWindow();
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }return iPhoneXSeries;
}

////判断是否登录,没有登录进行跳转
//#define kGuardLogin if ([IsLogin isLogin]) { \
//UIViewController *rootViewController = kKeyWindow.rootViewController; \
//TopicLoginViewController *vc = [[TopicLoginViewController alloc] init]; \
//UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc]; \
//[rootViewController presentViewController:nav animated:YES completion:nil]; \
//return; \
//} \

#endif /* ToolMacro_h */

#define kApplyShadowForView(view, radius) view.layer.masksToBounds = NO; \
view.layer.shadowOffset = CGSizeMake(0, 1.5); \
view.layer.shadowRadius = radius; \
view.layer.shadowOpacity = 0.4; \
view.layer.shadowColor = [UIColor lightGrayColor].CGColor; \

#pragma mark ======================================== 色彩相关 ========================================
#define kTableViewBackgroundColor HEXCOLOR(0xf6f5fa)
///常见颜色
#define kClearColor     [UIColor clearColor]
#define kBlackColor     [UIColor blackColor]
#define kBlueColor      [UIColor blueColor]
#define kWhiteColor     [UIColor whiteColor]
#define kCyanColor      [UIColor cyanColor]
#define kGrayColor      [UIColor grayColor]
#define kOrangeColor    [UIColor orangeColor]
#define kRedColor       [UIColor redColor]
#define KBrownColor     [UIColor brownColor]
#define KDarkGrayColor  [UIColor darkGrayColor]
#define KDarkTextColor  [UIColor darkTextColor]
#define KYellowColor    [UIColor yellowColor]
#define KPurpleColor    [UIColor purpleColor]
#define KLightTextColor [UIColor lightTextColor]
#define KLightGrayColor [UIColor lightGrayColor]
#define KGreenColor     [UIColor greenColor]
#define KMagentaColor   [UIColor magentaColor]
///System colors
/* Some colors that are used by system elements and applications.
* These return named colors whose values may vary between different contexts and releases.
* Do not make assumptions about the color spaces or actual colors used.
*/
#define KSystemRedColor [UIColor systemRedColor]
#define KSystemGreenColor [UIColor systemGreenColor]
#define KSystemBlueColor [UIColor systemBlueColor]
#define KSystemOrangeColor [UIColor systemOrangeColor]
#define KSystemYellowColor [UIColor systemYellowColor]
#define KSystemPinkColor [UIColor systemPinkColor]
#define KSystemPurpleColor [UIColor systemPurpleColor]
#define KSystemTealColor [UIColor systemTealColor]
#define KSystemIndigoColor [UIColor systemIndigoColor]
#define KSystemGrayColor [UIColor systemGrayColor]
/* The numbered variations, systemGray2 through systemGray6, are grays which increasingly
* trend away from systemGray and in the direction of systemBackgroundColor.
*
* In UIUserInterfaceStyleLight: systemGray1 is slightly lighter than systemGray.
*                               systemGray2 is lighter than that, and so on.
* In UIUserInterfaceStyleDark:  systemGray1 is slightly darker than systemGray.
*                               systemGray2 is darker than that, and so on.
*/
#define KSystemGray2Color [UIColor systemGray2Color]
#define KSystemGray3Color [UIColor systemGray3Color]
#define KSystemGray4Color [UIColor systemGray4Color]
#define KSystemGray5Color [UIColor systemGray5Color]
#define KSystemGray6Color [UIColor systemGray6Color]
/* Foreground colors for static text and related elements.
*/
#define KLabelColor [UIColor labelColor]
#define KSecondaryLabelColor [UIColor secondaryLabelColor]
#define KTertiaryLabelColor [UIColor tertiaryLabelColor]
#define KQuaternaryLabelColor [UIColor quaternaryLabelColor]
/* Foreground color for standard system links.
*/
#define KLinkColor [UIColor linkColor]
#define KPlaceholderTextColor [UIColor placeholderTextColor]
#define KSeparatorColor [UIColor separatorColor]
#define KOpaqueSeparatorColor [UIColor opaqueSeparatorColor]
///Background colors
/* We provide two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
*
* Each stack has three "levels" of background colors. The first color is intended to be the
* main background, farthest back. Secondary and tertiary colors are layered on top
* of the main background, when appropriate.
*
* Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
* We do not recommend mixing and matching background colors between stacks.
* The foreground colors above are designed to work in both stacks.
*
* 1. systemBackground
*    Use this stack for views with standard table views, and designs which have a white
*    primary background in light mode.
*/
#define KSystemBackgroundColor [UIColor systemBackgroundColor]
#define KSecondarySystemBackgroundColor [UIColor secondarySystemBackgroundColor]
#define KTertiarySystemBackgroundColor [UIColor tertiarySystemBackgroundColor]
/* 2. systemGroupedBackground
*    Use this stack for views with grouped content, such as grouped tables and
*    platter-based designs. These are like grouped table views, but you may use these
*    colors in places where a table view wouldn't make sense.
*/
#define KSystemGroupedBackgroundColor [UIColor systemGroupedBackgroundColor]
#define KSecondarySystemGroupedBackgroundColor [UIColor secondarySystemGroupedBackgroundColor]
#define KTertiarySystemGroupedBackgroundColor [UIColor tertiarySystemGroupedBackgroundColor]
///Fill colors
/* Fill colors for UI elements.
* These are meant to be used over the background colors, since their alpha component is less than 1.
*
* systemFillColor is appropriate for filling thin and small shapes.
* Example: The track of a slider.
*/
#define KSystemFillColor [UIColor systemFillColor]
/* secondarySystemFillColor is appropriate for filling medium-size shapes.
* Example: The background of a switch.
*/
#define KSecondarySystemFillColor [UIColor secondarySystemFillColor]
/* tertiarySystemFillColor is appropriate for filling large shapes.
* Examples: Input fields, search bars, buttons.
*/
#define KTertiarySystemFillColor [UIColor tertiarySystemFillColor]
/* quaternarySystemFillColor is appropriate for filling large areas containing complex content.
* Example: Expanded table cells.
*/
#define KQuaternarySystemFillColor [UIColor quaternarySystemFillColor]
///Other colors
/* lightTextColor is always light, and darkTextColor is always dark, regardless of the current UIUserInterfaceStyle.
* When possible, we recommend using `labelColor` and its variants, instead.
*/
#define KLightTextColor [UIColor lightTextColor]
#define KDarkTextColor [UIColor darkTextColor]
/* groupTableViewBackgroundColor is now the same as systemGroupedBackgroundColor.
*/
#define KGroupTableViewBackgroundColor [UIColor groupTableViewBackgroundColor]
#define KViewFlipsideBackgroundColor [UIColor viewFlipsideBackgroundColor]
#define KScrollViewTexturedBackgroundColor [UIColor scrollViewTexturedBackgroundColor]
#define KUnderPageBackgroundColor [UIColor underPageBackgroundColor]
///RGB颜色
#define RGBSAMECOLOR(x) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:1]
#define COLOR_RGB(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
///随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 \
green:arc4random_uniform(256) / 255.0 \
blue:arc4random_uniform(256) / 255.0 \
alpha:1] \
///十六进制颜色
#define HEXCOLOR(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1]
#define COLOR_HEX(hexValue, al)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:al]

#pragma mark ======================================== 字体 ========================================
#define kFontSize(x) [UIFont systemFontOfSize:x]

#pragma mark ======================================== 图片 ========================================
#define kIMG(imgName) [UIImage imageNamed:imgName]

#pragma mark ======================================== 尺寸相关 ========================================
#define isiPhoneX_seriesBottom 34
#define isiPhoneX_seriesTop 44

#define MianScreen          UIScreen.mainScreen.bounds.size
#define Device_Width        MianScreen.width//获取屏幕宽高
#define Device_Height       MianScreen.height
#define MAINSCREEN_WIDTH    Device_Width
#define MAINSCREEN_HEIGHT   Device_Height

#define SCREEN_MAX_LENGTH   (MAX(Device_Width, Device_Height))
#define SCREEN_MIN_LENGTH   (MIN(Device_Width, Device_Height))

///系统控件高度
static inline id getSceneDelegate(){
    id sceneDelegate = nil;
    if (@available(iOS 13.0, *)) {
        sceneDelegate = UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    }return sceneDelegate;
}

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

///缩放比例
#define SCALING_RATIO(UISize) (UISize) * Device_Width / 375.0f//全局比例尺
//#define KDeviceScale ((Device_Width/375)>1.3?1.3:(Device_Width/375))
#define KDeviceScale [[MKTools shared] deviceScaleMetod]
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

#pragma mark ======================================== 强弱引用 ========================================
#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(self) strongSelf = self;

#pragma mark ======================================== 其他 ========================================
#define ReuseIdentifier NSStringFromClass ([self class])
#define CurrentThread [NSThread currentThread];
#define PrintRetainCount(obj) printf("Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));
#pragma mark ======================================== 本地化字符串 ========================================
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
#define StringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)
#define LRToast(str) [NSString stringWithFormat:@"%@",@#str]
#define API(DomainName,api) [NSString stringWithFormat:@"%@%@",DomainName,api]

#pragma mark ======================================== UserDefault ========================================
#define SetUserDefaultKeyWithValue(key,value) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define SetUserDefaultKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
#define SetUserBoolKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setBool:object forKey:key]
#define GetUserDefaultValueForKey(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define GetUserDefaultObjForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define GetUserDefaultBoolForKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define DeleUserDefaultWithKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define UserDefaultSynchronize  [[NSUserDefaults standardUserDefaults] synchronize]

#pragma mark ======================================== 沙盒路径 ========================================
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark ======================================== 队列相关 ========================================
///异步获取某个队列
#define GET_QUEUE_ASYNC(queue, block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(queue)) == 0) {\
block();\
} else {\
dispatch_async(queue, block);\
}
///获取主队列
#define GET_MAIN_QUEUE_ASYNC(block) GET_QUEUE_ASYNC(dispatch_get_main_queue(), block)

#pragma mark ======================================== 时间相关 ========================================
/** 时间间隔 */
#define kHUDDuration            (1.f)
/** 一天的秒数 */
#define SecondsOfDay            (24.f * 60.f * 60.f)
/** 秒数 */
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))
/** 一天的毫秒数 */
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
/** 毫秒数 */
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))

//// 判断是真机还是模拟器
#if TARGET_OS_IPHONE
// iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
// iPhone Simulator
#endif

/** DEBUG LOG **/
#ifdef DEBUG

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DLog( s, ... )

#endif
///单例模式宏
#define MACRO_SHARED_INSTANCE_INTERFACE +(instancetype)sharedInstance;
#define MACRO_SHARED_INSTANCE_IMPLEMENTATION(CLASS) \
+(instancetype)sharedInstance \
{ \
static CLASS * sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[CLASS alloc] init]; \
}); \
return sharedInstance; \
}
///宏替换代码
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)\
///断点Assert
#define ITTAssert(condition, ...)\
\
do {\
if (!(condition))\
{\
[[NSAssertionHandler currentHandler]\
handleFailureInFunction:[NSString stringWithFormat:@"< %s >", __PRETTY_FUNCTION__]\
file:[[NSString stringWithUTF8String:__FILE__] lastPathComponent]\
lineNumber:__LINE__\
description:__VA_ARGS__];\
}\
} while(0)
///条件LOG
#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...)\
\
{\
if ((condition))\
{\
ITTDPRINT(xx, ##__VA_ARGS__);\
}\
}
#else
#define ITTDCONDITIONLOG(condition, xx, ...)\
\
((void)0)
#endif

#pragma mark ======================================== 重写NSLog,Debug模式下打印日志和当前行数 ========================================
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define NSLog(FORMAT, ...) nil
#endif
///DEBUG模式
#define ITTDEBUG
///LOG等级
#define ITTLOGLEVEL_INFO        10
#define ITTLOGLEVEL_WARNING     3
#define ITTLOGLEVEL_ERROR       1
///LOG最高等级
#ifndef ITTMAXLOGLEVEL
#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif
#endif
