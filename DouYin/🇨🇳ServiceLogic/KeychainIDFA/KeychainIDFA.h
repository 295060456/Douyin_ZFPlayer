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

@interface KeychainIDFA : NSObject

//获取IDFA
+ (NSString*)deviceID;


@end
