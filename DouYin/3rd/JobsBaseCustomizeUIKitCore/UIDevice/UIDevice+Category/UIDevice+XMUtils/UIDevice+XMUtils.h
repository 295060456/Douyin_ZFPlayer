//
//  UIDevice+XMUtils.h
//  AwesomeTips
//
//  Created by kangzubin on 2018/9/20.
//  Copyright © 2018 KANGZUBIN. All rights reserved.
//

#import <UIKit/UIKit.h>
//https://kangzubin.com/ios-device-model/
//https://gist.github.com/kangzubin/5b4f989d6b1113bfbe43c5772f3ba1fd

typedef enum : NSUInteger {
    iPhoneScreen_default = 0,// iPhone Simulator 或者 新出的机型
    iPhoneScreen_3GS = 1,
    iPhoneScreen_4_4S = 2,
    iPhoneScreen_5_5S_5C_SE = 3,
    iPhoneScreen_6_6S_7_8 = 4,
    iPhoneScreen_6_6S_7_8_Plus = 5,
    iPhoneScreen_X_XS = 6,
    iPhoneScreen_XR = 7,
    iPhoneScreen_XSMAX = 8
} iPhoneScreen;

@interface UIDevice (XMUtils)

/**
 获取硬件平台名称，叫 device model 或者 machine name

 @return 硬件平台名称，如 iPhone3,1、iPad7,4 等
 */
+ (NSString *)platform;

/**
 获取设备型号名称

 @return 设备型号名称，如 iPhone 7、iPhone X、iPad Pro 10.5-inch 等
 */
+ (NSString *)platformString;

/**
 获取设备型号名称

 @return 设备型号名称，与 platformString 一致，只查询一次然后缓存
 */
+ (NSString *)deviceName;

+(BOOL)judgementUpperIphone6;//判断当前机型是否是iphone6 及其以上机型,过滤掉对ipad的判断

+(BOOL)isSimulator;

@end

static inline iPhoneScreen iPhone_seriesScreen(){
    NSString *str = [UIDevice platformString];
    if ([str isEqualToString:@"iPhone 3GS"]) {
        return iPhoneScreen_3GS;
    }else if ([str isEqualToString:@"iPhone 4S"] ||
              [str isEqualToString:@"iPhone 4 (CDMA)"] ||
              [str isEqualToString:@"iPhone 4 (GSM Rev A)"] ||
              [str isEqualToString:@"iPhone 4 (GSM)"]){
        return iPhoneScreen_4_4S;
    }else if ([str isEqualToString:@"iPhone 5s"] ||
              [str isEqualToString:@"iPhone 5c"] ||
              [str isEqualToString:@"iPhone 5 (CDMA)"] ||
              [str isEqualToString:@"iPhone 5 (GSM)"] ||
              [str isEqualToString:@"iPhone SE"]){
        return iPhoneScreen_5_5S_5C_SE;
    }else if (
              [str isEqualToString:@"iPhone 6s"] ||
              [str isEqualToString:@"iPhone 6"] ||
              [str isEqualToString:@"iPhone 8"] ||
              [str isEqualToString:@"iPhone 7"]){
        return iPhoneScreen_6_6S_7_8;
    }else if ([str isEqualToString:@"iPhone 6s Plus"] ||
              [str isEqualToString:@"iPhone 6 Plus"] ||
              [str isEqualToString:@"iPhone 8 Plus"] ||
              [str isEqualToString:@"iPhone 7 Plus"]){
        return iPhoneScreen_6_6S_7_8_Plus;
    }else if ([str isEqualToString:@"iPhone X"] || [str isEqualToString:@"iPhone XS"]){
        return iPhoneScreen_X_XS;
    }else if ([str isEqualToString:@"iPhone XR"]){
        return iPhoneScreen_XR;
    }else if ([str isEqualToString:@"iPhone XS Max"]){
        return iPhoneScreen_XSMAX;
    }else{
        //    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
        //    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
        return iPhoneScreen_default;
    }
}
