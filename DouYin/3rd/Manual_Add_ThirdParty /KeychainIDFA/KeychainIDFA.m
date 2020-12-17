//
//  KeychainIDFA.m
//  KeychainIDFA
//
//  Created by Qixin on 14/12/18.
//  Copyright (c) 2014年 Qixin. All rights reserved.
//

#import "KeychainIDFA.h"
#import "KeychainHelper.h"

@implementation KeychainIDFA

#pragma mark —— DeviceID
+(void)deleteDeviceID{
    [KeychainHelper delete:IDFA_STRING];
}

+(NSString*)deviceID{
    //0.读取keychain的缓存
    NSString *deviceID = [KeychainHelper load:IDFA_STRING];
    if (kIsStringValid(deviceID)){
        return deviceID;
    }else{
        deviceID = UIDevice.currentDevice.identifierForVendor.UUIDString;
        [KeychainHelper save:IDFA_STRING
                        data:deviceID];
        return deviceID;
    }
}
#pragma mark —— Idfa
+(NSString*)getIdfaString{
    NSString *idfaStr = [KeychainHelper load:IDFA_STRING];
    if (kIsStringValid(idfaStr)){
        return idfaStr;
    }else{
        return nil;
    }
}

+(BOOL)setIdfaString:(NSString *)secValue{
    if (kIsStringValid(secValue)){
        [KeychainHelper save:IDFA_STRING
                        data:secValue];
        return YES;
    }else{
        return NO;
    }
}
#pragma mark —— UUID
+(NSString *)getUUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref = CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);

    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    if (!kIsStringValid(uuid)){
        uuid = @"";
    }
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
