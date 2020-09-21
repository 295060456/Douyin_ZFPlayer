//
//  FMARCNetwork.h
//  ZFMRACNetwork
//
//  Created by todriver02 on 2018/7/31.
//  Copyright © 2018年 zhufaming. All rights reserved.
//

/**
 *  网络请求工具类
 */
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RsponseStyle_JSON = 1,
    RsponseStyle_XML,
    RsponseStyle_DATA
} RsponseStyle;

@class FMHttpRequest;

@interface FMARCNetwork : NSObject

@property(nonatomic,assign)RsponseStyle rsponseStyle;
@property(nonatomic,assign)Boolean isEncryption;

@property(nonatomic,assign)BOOL isRequestFinish;//数据请求是否完毕

@property(nonatomic,copy)void (^ReachableViaWWANNetWorking)(void);//3G网络
@property(nonatomic,copy)void (^ReachableViaWiFiNetWorking)(void);//WiFi
@property(nonatomic,copy)void (^UnknownNetWorking)(void);//未知网络

@property(nonatomic,copy)void (^NotReachableNetWorking)(void);//无任何网络连接
@property(nonatomic,copy)void (^ReachableNetWorking)(void);//有网络

+(FMARCNetwork *)sharedInstance;

- (void)AFNReachability;
/**
 网络请求，简便方案 POST

 @param path 请求路径 --- 基本链接，请在 FMHttpRConstant.h 文件中设置
 @param params 参数字典
 @return RACSignal
 */
- (RACSignal *)requestSimpleNetworkPath:(NSString *)path
                                 params:(NSDictionary *)params;
/**
 网络请求,返回信号 POST
 按照， FMHttpRequest 参数化设置  区分加密与不加密
 @param req FMHttpRequest
 @return RACSignal
 */
- (RACSignal *)requestNetworkData:(FMHttpRequest *)req;
/**
 文件上传、可以当个文件、也可以多个文件

 @param path 文件上传服务器地址，这里单独给出来，是因为很大部分图片服务器和业务服务器不是同一个
 @param params 参数 没有可传 @{}
 @param fileDatas NSData 数组
 @param nameArr 指定数据关联的名称 数组
 @return RACSignal
 */
- (RACSignal *)uploadNetworkPath:(NSString *)path
                          params:(NSDictionary *)params
                       fileDatas:(NSArray<NSData *> *)fileDatas
                         nameArr:(NSArray <NSString *>*)nameArr
                        mimeType:(NSString *)mimeType;
/**
    视频文件上传、可以当个文件、也可以多个文件

 @param path 文件上传服务器地址，这里单独给出来，是因为很大部分图片服务器和业务服务器不是同一个
 @param params 参数 没有可传 @{}
 @param fileDatas NSData 数组
 @param nameArr 指定数据关联的名称 数组
 @return RACSignal
 */
- (RACSignal *)uploadViedoNetworkPath:(NSString *)path
                          params:(NSDictionary *)params
                       fileDatas:(NSArray<NSData *> *)fileDatas
                         nameArr:(NSArray <NSString *>*)nameArr
                        mimeType:(NSString *)mimeType;


/*
 * 文件下载
 */
- (void)downloadUrl:(NSString *)url
   downloadFilePath:(NSString *)downloadFilePath
            success:(void (^) (id responseObject))successful
            failure:(void (^) (NSError *error))failure;

//RsponseStyle_JSON
- (void)PUTUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void (^)(id responseObject))successful
       failure:(void (^)(NSError *error))failure;

- (void)DeleteUrl:(NSString *)url
       parameters:(NSDictionary *)parameters
          success:(void (^)(id responseObject))successful
          failure:(void (^) (NSError *error))failure;

@end

