//
//  FMHttpRequest.h
//  ZFMRACNetwork
//
//  Created by todriver02 on 2018/7/31.
//  Copyright © 2018年 zhufaming. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 请求Method
/// GET 请求
#define HTTTP_METHOD_GET @"GET"
/// POST
#define HTTTP_METHOD_POST @"POST"
/// PUT
#define HTTTP_METHOD_PUT @"PUT"
/// DELETE
#define HTTTP_METHOD_DELETE @"DELETE"

@interface ExtendsParameters : NSObject

+ (instancetype)extendsParameters;

@property(nonatomic,readonly,copy)NSString *token;/// 用户token，默认空字符串
@property(nonatomic,readonly,copy)NSString *deviceid;/// 设备编号，自行生成
@property(nonatomic,readonly,copy)NSString *version;/// app版本号
@property(nonatomic,readonly,copy)NSString *platform;/// 平台 pc,wap,android,iOS
@property(nonatomic,readonly,copy)NSString *channel;/// 渠道 AppStore
@property(nonatomic,readonly,copy)NSString *t;/// 时间戳

@end

@interface FMHttpRequest : NSObject

@property(nonatomic,readwrite,copy)NSString *path;/// 路径 （v14/order）
@property(nonatomic,readwrite,strong)NSDictionary *parameters;/// 参数列表
@property(nonatomic,readwrite,copy)NSString *method;/// 方法 （POST/GET）
@property(nonatomic,readwrite,strong)ExtendsParameters *extendsParameters;/// 拓展的参数属性 (开发人员不必关心)
/**
 参数配置（统一用这个方法配置参数）
 https://api.xx.com/ : baseUrl
 https://api.xx.com/user/info?user_id=100013
 @param method 方法名 （GET/POST/...）
 @param path 文件路径 （user/info）
 @param parameters 具体参数 @{user_id:10013}
 @return 返回一个参数实例
 */
+(instancetype)urlParametersWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters;


@end
