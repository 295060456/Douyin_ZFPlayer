//
//  MacroDef_Func.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Func_h
#define MacroDef_Func_h

#import "SceneDelegate.h"
#import "MacroDef_Sys.h"

static inline UIWindow * getMainWindow(){
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        window = [SceneDelegate sharedInstance].window;
    }else{
        window = UIApplication.sharedApplication.delegate.window;
//        [UIApplication sharedApplication].keyWindow
    }return window;
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

static inline id getSceneDelegate(){
    id sceneDelegate = nil;
    if (@available(iOS 13.0, *)) {
        sceneDelegate = UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    }return sceneDelegate;
}
#pragma mark ======================================== 字体 ================================================
#define kFontSize(x) [UIFont systemFontOfSize:x weight:UIFontWeightRegular]

#pragma mark ======================================== 沙盒路径 =============================================
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark ======================================== UserDefault ========================================
#define SetUserDefaultKeyWithValue(key,value) [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define SetUserDefaultKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
#define SetUserBoolKeyWithObject(key,object) [[NSUserDefaults standardUserDefaults] setBool:object forKey:key]
#define GetUserDefaultValueForKey(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define GetUserDefaultObjForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define GetUserDefaultBoolForKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define DeleUserDefaultWithKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define UserDefaultSynchronize  [[NSUserDefaults standardUserDefaults] synchronize]




//判断是否登录,没有登录进行跳转
#define kGuardLogin if ([IsLogin isLogin]) { \
UIViewController *rootViewController = kKeyWindow.rootViewController; \
TopicLoginViewController *vc = [[TopicLoginViewController alloc] init]; \
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc]; \
[rootViewController presentViewController:nav animated:YES completion:nil]; \
return; \
} \

#pragma mark ======================================== 本地化字符串 ========================================
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
#define StringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]
#pragma mark ======================================== 强弱引用 ==============================================
#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(self) strongSelf = self;
#pragma mark ======================================== 其他 =================================================
#define ReuseIdentifier NSStringFromClass ([self class])
#define CurrentThread [NSThread currentThread]
#define PrintRetainCount(obj) printf("Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(obj)));
//- (void)add:(NSString *)txt{}
#define addText(fmt, ...) [self add:[NSString stringWithFormat:fmt, ##__VA_ARGS__]]//多参数

#pragma mark ======================================== 队列相关 ==============================================
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

#endif /* MacroDef_Func_h */
