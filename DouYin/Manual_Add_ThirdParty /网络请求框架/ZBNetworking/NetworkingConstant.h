//
//  NetworkingConstant.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#ifndef NetworkingConstant_h
#define NetworkingConstant_h

/********如果需要存储，相应的的 key 宏定义********/
/// 服务器相关
#define HTTPRequestTokenKey @"token"
/// 签名key
#define HTTPServiceSignKey @"sign"
/// 私钥key
#define HTTPServiceKey  @"privatekey"
/// 私钥Value
#define HTTPServiceKeyValue @"/** 你的私钥 **/"
/// 状态码key
#define HTTPServiceResponseCodeKey @"code"
/// 消息key
#define HTTPServiceResponseMsgKey @"msg"
/// 数据data
#define HTTPServiceResponseDataKey  @"data"

/// 请求数据返回的状态码、根据自己的服务端数据来
typedef NS_ENUM(NSUInteger, HTTPResponseCode) {//KKK
    ///请求成功 200
    HTTPResponseCodeSuccess = 200,
    ///未登录 & 被踢 401
    HTTPResponseCodeNotLogin = 401,
    ///550 后台业务代码参数异常 参数异常
    HTTPResponseCodeAnomalous = 550,
    ///后台代码异常 999
    HTTPResponseCodeError = 999,
};

static NSString *const HTTPServiceErrorDomain = @"HTTPServiceErrorDomain";/// The Http request error domain
static NSString *const HTTPServiceErrorResponseCodeKey = @"HTTPServiceErrorResponseCodeKey";/// 请求成功，但statusCode != 0
static NSString *const HTTPServiceErrorRequestURLKey = @"HTTPServiceErrorRequestURLKey";//请求地址错误
static NSString *const HTTPServiceErrorHTTPStatusCodeKey = @"HTTPServiceErrorHTTPStatusCodeKey";//请求错误的code码key: 请求成功了，但code码是错误提示的code,比如参数错误
static NSString *const HTTPServiceErrorDescriptionKey = @"HTTPServiceErrorDescriptionKey";//请求错误，详细描述key
static NSString *const HTTPServiceErrorMessagesKey = @"HTTPServiceErrorMessagesKey";//服务端错误提示，信息key

#define server_URL [URL_Manager sharedInstance].BaseUrl_1

#endif /* NetworkingConstant_h */
