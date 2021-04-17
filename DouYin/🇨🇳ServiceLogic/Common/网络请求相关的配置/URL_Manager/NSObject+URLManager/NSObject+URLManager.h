//
//  NSObject+URLManager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLManagerModel.h"
#import "DefineStructure.h"

#define HTTP @"http://"
#define append(fmt, ...) [self append:[URLManagerModel stringWithFormat:fmt, ##__VA_ARGS__]]//多参数

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (URLManager)

#pragma mark —— BaseURL
+(NSString *)BaseUrl;
+(NSString *)BaseUrl_H5;

#pragma mark —— App接口示例
+(URLManagerModel *)appInterfaceTesting;

@end

NS_ASSUME_NONNULL_END

