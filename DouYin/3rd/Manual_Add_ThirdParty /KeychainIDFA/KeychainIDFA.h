//
//  KeychainIDFA.h
//  KeychainIDFA
//
//  Created by Qixin on 14/12/18.
//  Copyright (c) 2014年 Qixin. All rights reserved.
//

#import <Foundation/Foundation.h>

//设置你deviceID的Keychain标示,该标示相当于key,而你的deviceID是value
#define IDFA_STRING @"com.xingxing.mk"
#define kIsStringValid(text) (text && text!=NULL && text.length > 0)

@interface KeychainIDFA : NSObject

//+(NSString*)deviceID;//获取IDFA
#pragma mark —— DeviceID
+(void)deleteDeviceID;
+(NSString*)deviceID;

#pragma mark —— Idfa
+(NSString*)getIdfaString;
+(BOOL)setIdfaString:(NSString *)secValue;

#pragma mark —— UUID
+(NSString *)getUUID;


@end
