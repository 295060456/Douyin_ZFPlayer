//
//  UIDevice+XMUtils.m
//  AwesomeTips
//
//  Created by kangzubin on 2018/9/20.
//  Copyright © 2018 KANGZUBIN. All rights reserved.
//

#import "UIDevice+XMUtils.h"
#import <sys/sysctl.h>

@implementation UIDevice (XMUtils)

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine",
                 NULL,
                 &size,
                 NULL,
                 0);
    char *machine = (char *)malloc(size);
    if (machine == NULL) {
        return nil;
    }
    sysctlbyname("hw.machine",
                 machine,
                 &size,
                 NULL,
                 0);
    NSString *platform = [NSString stringWithCString:machine
                                            encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

// See also: https://www.theiphonewiki.com/wiki/Models
+ (NSString *)platformString {
    NSString *platform = [self platform];
    
    if (!platform) {
        return [UIDevice currentDevice].model; // e.g. @"iPhone", @"iPod touch"
    }
    
    // iPhone
    if ([platform isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";         // GSM
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";    // GSM
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";         // GSM
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";         // Global
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";    // Global
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";         // Global
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";    // GSM
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";         // GSM
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";    // Global
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";         // Global
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    // iPod touch
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch 6G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod touch 5G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod touch 4G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod touch 3G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    
    // iPad
    if ([platform isEqualToString:@"iPad7,6"])      return @"iPad 6 (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])      return @"iPad 6 (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch 2nd-gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch 2nd-gen (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])     return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina (China)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([platform isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    // Simulator
    if ([platform isEqualToString:@"i386"])         return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    if ([platform isEqualToString:@"x86_64"])       return [NSString stringWithFormat:@"%@ Simulator", [UIDevice currentDevice].model];
    
    // For new device, return the hardware string directly.
    return platform;
}

#pragma mark —— 判断当前机型是否是iphone6 及其以上机型,过滤掉对ipad的判断
+(BOOL)judgementUpperIphone6{
    NSString *str = [UIDevice platformString];
    if ([str isEqualToString:@"iPhone 2G"]) return NO;
    if ([str isEqualToString:@"iPhone 3G"]) return NO;
    if ([str isEqualToString:@"iPhone 3GS"]) return NO;
    if ([str isEqualToString:@"iPhone 4"]) return NO;
    if ([str isEqualToString:@"iPhone 4S"]) return NO;
    if ([str isEqualToString:@"iPhone 5"]) return NO;
    if ([str isEqualToString:@"iPhone 5c"]) return NO;
    if ([str isEqualToString:@"iPhone 5s"]) return NO;
    if ([str isEqualToString:@"iPhone Simulator"]) return NO;//test
    return YES;
}

+(BOOL)isSimulator{
    NSString *str = [UIDevice platformString];
    return [str isEqualToString:@"iPhone Simulator"]?YES:NO;
}

+ (NSString *)deviceName {
    static NSString *deviceName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceName = [self platformString];
        if (deviceName.length == 0) {
            deviceName = @"iPhone";
        }
    });return deviceName;
}

@end

