//
//  FMARCNetwork.m
//  ZFMRACNetwork
//
//  Created by todriver02 on 2018/7/31.
//  Copyright © 2018年 zhufaming. All rights reserved.
//

#import "FMARCNetwork.h"
#import "FMHttpConstant.h"
#import "FMHttpRequest.h"
#import "FMHttpResonse.h"

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "NetworkingConstant.h"

@interface FMARCNetwork()

@property(nonatomic,strong)AFHTTPSessionManager *manager;//网络管理工具
@property(nonatomic,strong)AFURLSessionManager *downLoadManager;
@property(nonatomic,strong)AFHTTPResponseSerializer *HTTPResponseSerializers;
@property(nonatomic,strong)AFJSONResponseSerializer *JSONResponseSerializer;
@property(nonatomic,strong)AFXMLParserResponseSerializer *XMLParserResponseSerializer;
@property(nonatomic,strong)AFSecurityPolicy *securityPolicy;//安全策略
@property(nonatomic,strong)AFNetworkReachabilityManager *afNetworkReachabilityManager;

@end

@implementation FMARCNetwork

@synthesize manager = _manager;

static FMARCNetwork *static_FMARCNetwork = nil;
+(FMARCNetwork *)sharedInstance{
    @synchronized(self){
        if (!static_FMARCNetwork) {
            static_FMARCNetwork = FMARCNetwork.new;
        }
    }return static_FMARCNetwork;
}

-(instancetype)init{
    if (self = [super init]) {
        static_FMARCNetwork = self;
        self.manager = AFHTTPSessionManager.manager;//初始化 网络管理器
        switch (self.rsponseStyle) {
            case RsponseStyle_JSON:{
                self.manager.responseSerializer = self.HTTPResponseSerializers;//JSON
            }
                break;
            case RsponseStyle_XML:{
                self.manager.responseSerializer = self.XMLParserResponseSerializer;//XML
            }
                break;
            case RsponseStyle_DATA:{
                self.manager.responseSerializer = self.JSONResponseSerializer;//DATA
            }
                break;
            default:
                self.manager.responseSerializer = self.JSONResponseSerializer;//DATA 如果属性值rsponseStyle不设置，那么默认使用此
                break;
        }
        //需要特别指出的是:AFNetworking默认把响应结果当成json来处理
        [self.manager.reachabilityManager startMonitoring];
    }return self;
}

- (void)AFNReachability {
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown          = 未知
     AFNetworkReachabilityStatusNotReachable     = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    @weakify(self)
    if (!_isRequestFinish) {
        //如果没有请求完成就检测网络
        [self.afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @strongify(self)
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:{
                    DLog(@"未知网络");
                    if (self.UnknownNetWorking) {
                        self.UnknownNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                        object:@(AFNetworkReachabilityStatusUnknown)];
                }break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    DLog(@"3G网络");//不是WiFi的网络都会识别成3G网络.比如2G/3G/4G网络
                    if (self.ReachableViaWWANNetWorking) {
                        self.ReachableViaWWANNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                        object:@(AFNetworkReachabilityStatusReachableViaWWAN)];
                }break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    DLog(@"WIFI网络");
                    if (self.ReachableViaWiFiNetWorking) {
                        self.ReachableViaWiFiNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                        object:@(AFNetworkReachabilityStatusReachableViaWiFi)];
                } break;
                case AFNetworkReachabilityStatusNotReachable:{
                    DLog(@"没有网络");
                    if (self.NotReachableNetWorking) {
                        self.NotReachableNetWorking();
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                        object:@(AFNetworkReachabilityStatusNotReachable)];
                }break;
                default:{
                    DLog(@"没有网络");
                    if (self.NotReachableNetWorking) {
                        self.NotReachableNetWorking();
                    }
                    [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                        object:@(AFNetworkReachabilityStatusNotReachable)];
                }break;
            }}];
    }
    [self.afNetworkReachabilityManager startMonitoring];
}

/**
 网络请求，简便方案
 
 @param path 请求路径 --- 基本链接，请在 FMHttpRConstant.h 文件中设置
 @param params 参数字典
 @return RACSignal
 */
- (RACSignal *)requestSimpleNetworkPath:(NSString *)path
                                 params:(NSDictionary *)params{
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:path
                                                     parameters:params];
    return [self requestNetworkData:req];
}
/**
 网络请求,返回信号
 按照， FMHttpRequest 参数化设置
 @param req FMHttpRequest
 @return RACSignal
 */
- (RACSignal *)requestNetworkData:(FMHttpRequest *)req{
    if (!req) return [RACSignal error:[NSError errorWithDomain:HTTPServiceErrorDomain
                                                          code:-1
                                                      userInfo:nil]];/// request 必须的有值
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        NSString *url = [@"" stringByAppendingString:req.path];//KKK
        NSLog(@"%@",url);//
        
        /// 获取request KKK
        NSError *serializationError = nil;
        NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:req.method
                                                                               URLString:url
                                                                              parameters:req.parameters
                                                                                   error:&serializationError];
#warning Token
//        if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
//            [request setValue:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token
//           forHTTPHeaderField:@"Authorization"];
//        }
        if (serializationError) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.manager.completionQueue ?: dispatch_get_main_queue(), ^{
                [subscriber sendError:serializationError];
            });
#pragma clang diagnostic pop
            return [RACDisposable disposableWithBlock:^{
            }];
        }
        __block NSURLSessionDataTask *task = nil;
        NSLog(@"%@",request.allHTTPHeaderFields);
        task = [self.manager
                dataTaskWithRequest:request
                uploadProgress:nil
                downloadProgress:nil
                completionHandler:^(NSURLResponse * _Nonnull response,
                                    id  _Nullable responseObject,
                                    NSError * _Nullable error){
            @strongify(self);
            if (!error) {//网络OK
                NSInteger statusCode = [responseObject[HTTPServiceResponseCodeKey] integerValue];
                //请求成功 200 只有在200的时候才有data
                if (statusCode == HTTPResponseCodeSuccess) {
                    
                    FMHttpResonse *response = [[FMHttpResonse alloc]initWithResponseSuccess:responseObject[HTTPServiceResponseDataKey]code:statusCode];
                    
                    [subscriber sendNext:response];//
                    [subscriber sendCompleted];
                    
                }
                
                ///用户尚未登录 401 //后台业务代码参数异常 参数异常 550 //后台代码异常 999
                else if (statusCode == HTTPResponseCodeNotLogin || statusCode == HTTPResponseCodeAnomalous || statusCode == HTTPResponseCodeError){
                    if (statusCode == HTTPResponseCodeNotLogin) {
                        //进入登录流程
                    }
                    [MBProgressHUD wj_showPlainText:responseObject[HTTPServiceResponseMsgKey] view:nil];
                    
                    FMHttpResonse *response = [[FMHttpResonse alloc] initWithResponseSuccess:responseObject[HTTPServiceResponseMsgKey] code:statusCode];
                    
                    NSLog(@"异常接口路径 %@ %@",request.URL.absoluteString,responseObject[HTTPServiceResponseMsgKey]);
                    
                    [subscriber sendNext:response];
                    
                    [subscriber sendCompleted];
                //抛其他异常
                    
                }else{
                    [MBProgressHUD wj_showPlainText:responseObject[HTTPServiceResponseMsgKey]
                                               view:nil];
                    
                    NSLog(@"异常接口路径 %@ %@",request.URL.absoluteString,responseObject[HTTPServiceResponseMsgKey]);
                    
                    FMHttpResonse *response = [[FMHttpResonse alloc] initWithResponseSuccess:responseObject[HTTPServiceResponseMsgKey]
                                                                                        code:statusCode];
                    
                    [subscriber sendNext:response];
                    [subscriber sendCompleted];
                }
            }
            else {//网络问题
                NSError *parseError = [self errorFromRequestWithTask:task
                                                        httpResponse:(NSHTTPURLResponse *)response
                                                      responseObject:responseObject
                                                               error:error];
                NSInteger code = [parseError.userInfo[HTTPServiceErrorHTTPStatusCodeKey] integerValue];
                NSString *msgStr = parseError.userInfo[HTTPServiceErrorDescriptionKey];
                FMHttpResonse *response = [[FMHttpResonse alloc] initWithResponseError:parseError
                                                                                  code:code
                                                                                   msg:msgStr];//初始化、返回数据模型
                [subscriber sendNext:response];//同样也返回到,调用的地址，也可处理，自己选择
                //                [subscriber sendError:parseError];
                [subscriber sendCompleted];
                //错误可以在此处处理---比如加入自己弹窗，主要是服务器错误、和请求超时、网络开小差
                [MBProgressHUD wj_showPlainText:msgStr
                                           view:nil];
                
            }
        }];
        [task resume];/// 开启请求任务
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];return [signal replayLazily]; //多次订阅同样的信号，执行一次
}
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
                        mimeType:(NSString *)mimeType{
    return [[self UploadRequestWithPath:path
                             parameters:params
              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger count = fileDatas.count;
        for (int i = 0; i< count; i++) {
            NSData *fileData = fileDatas[i];
            NSAssert([fileData isKindOfClass:NSData.class], @"fileData is not an NSData class: %@", fileData);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            static NSDateFormatter *formatter = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                formatter = [[NSDateFormatter alloc] init];
            });
            [formatter setDateFormat:@"yyyyMMddHHmmss"];// 设置时间格式
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"senba_empty_%@_%d.jpg", dateString , i];
            [formData appendPartWithFileData:fileData
                                        name:nameArr[i]
                                    fileName:fileName //自己生成
                                    mimeType:!(mimeType.length == 0 ||
                                               mimeType == nil ||
                                               [mimeType isKindOfClass:[NSNull class]]) ? mimeType:@"application/octet-stream"];
        }
    }] replayLazily];
}
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
                        mimeType:(NSString *)mimeType{
    return [[self UploadRequestWithPath:path
                             parameters:params
              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger count = fileDatas.count;
        for (int i = 0; i< count; i++) {
            NSData *fileData = fileDatas[i];
            NSAssert([fileData isKindOfClass:NSData.class], @"fileData is not an NSData class: %@", fileData);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            static NSDateFormatter *formatter = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                formatter = [[NSDateFormatter alloc] init];
            });
            [formatter setDateFormat:@"yyyyMMddHHmmss"];// 设置时间格式
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"senba_empty_%@_%d.mp4", dateString , i];
            [formData appendPartWithFileData:fileData
                                        name:nameArr[i]
                                    fileName:fileName //自己生成
                                    mimeType:!(mimeType.length == 0 ||
                                               mimeType == nil ||
                                               [mimeType isKindOfClass:[NSNull class]]) ? mimeType:@"application/octet-stream"];
        }
    }] replayLazily];
}

- (RACSignal *)UploadRequestWithPath:(NSString *)path
                          parameters:(id)parameters
           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block{
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *serializationError = nil;
        NSString *url = [@"" stringByAppendingString:path];
        NSMutableURLRequest *request = [self.manager.requestSerializer multipartFormRequestWithMethod:HTTTP_METHOD_POST
                                                                                            URLString:url
                                                                                           parameters:parameters
                                                                            constructingBodyWithBlock:block
                                                                                                error:&serializationError];
#warning Token
//        if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
//            [request setValue:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token
//           forHTTPHeaderField:@"Authorization"];
//        }
        if (serializationError) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.manager.completionQueue ?: dispatch_get_main_queue(), ^{
                [subscriber sendError:serializationError];
            });
#pragma clang diagnostic pop
            return [RACDisposable disposableWithBlock:^{
            }];
        }
        
        __block NSURLSessionDataTask *task = [self.manager uploadTaskWithStreamedRequest:request
                                                                                progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress = %@",uploadProgress);
            CGFloat _percent = uploadProgress.fractionCompleted * 100;
            NSString *str = [NSString stringWithFormat:@"上传文件中...%.2f",_percent];
            NSLog(@"%@",str);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [MBProgressHUD wj_showPlainText:str
                                           view:nil];
            }];
        } completionHandler:^(NSURLResponse * _Nonnull response,
                              id  _Nullable responseObject,
                              NSError * _Nullable error) {
            @strongify(self);
            if (error) {
                NSError *parseError = [self errorFromRequestWithTask:task
                                                        httpResponse:(NSHTTPURLResponse *)response
                                                      responseObject:responseObject
                                                               error:error];
                NSInteger code = [parseError.userInfo[HTTPServiceErrorHTTPStatusCodeKey] integerValue];
                NSString *msgStr = parseError.userInfo[HTTPServiceErrorDescriptionKey];
                FMHttpResonse *response = [[FMHttpResonse alloc] initWithResponseError:parseError
                                                                                  code:code
                                                                                   msg:msgStr];//初始化、返回数据模型
                //错误可以在此处处理---比如加入自己弹窗，主要是服务器错误、和请求超时、网络开小差
                //同样也返回到,调用的地址，也可处理，自己选择
                [subscriber sendNext:response];
                //[subscriber sendError:parseError];
                [subscriber sendCompleted];
                [MBProgressHUD wj_showPlainText:msgStr
                                           view:nil];
            } else {
                FMHttpResonse *response = [[FMHttpResonse alloc] initWithResponseSuccess:responseObject
                                                                                    code:0];
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            }
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
    /// replayLazily:replayLazily会在第一次订阅的时候才订阅sourceSignal
    /// 会提供所有的值给订阅者 replayLazily还是冷信号 避免了冷信号的副作用
    return [[signal replayLazily] setNameWithFormat:@"-enqueueUploadRequestWithPath: %@ parameters: %@", path, parameters];
}
/// 请求错误解析
- (NSError *)errorFromRequestWithTask:(NSURLSessionTask *)task
                         httpResponse:(NSHTTPURLResponse *)httpResponse
                       responseObject:(NSDictionary *)responseObject
                                error:(NSError *)error {
    NSInteger HTTPCode = httpResponse.statusCode;/// 不一定有值，则HttpCode = 0;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    NSString *errorDesc = @"服务器出错了，请稍后重试~";
    /// 其实这里需要处理后台数据错误，一般包在 responseObject
    /// HttpCode错误码解析 https://www.guhei.net/post/jb1153
    /// 1xx : 请求消息 [100  102]
    /// 2xx : 请求成功 [200  206]
    /// 3xx : 请求重定向[300  307]
    /// 4xx : 请求错误  [400  417] 、[422 426] 、449、451
    /// 5xx 、600: 服务器错误 [500 510] 、600
    NSInteger httpFirstCode = HTTPCode/100;
    if (httpFirstCode > 0) {
        if (httpFirstCode == 4) {
            /// 请求出错了，请稍后重试
            if (HTTPCode == 408) {
                errorDesc = @"请求超时，请稍后再试~";
            }else{
                errorDesc = @"请求出错了，请稍后重试~";
            }
        }else if (httpFirstCode == 5 ||
                  httpFirstCode == 6){
            errorDesc = @"服务器出错了，请稍后重试~";
        }else if (!self.manager.reachabilityManager.isReachable){
            errorDesc = @"网络开小差了，请稍后重试~";
        }
    }else{
        if (!self.manager.reachabilityManager.isReachable){
            errorDesc = @"网络开小差了，请稍后重试~";
        }
    }
    switch (HTTPCode) {
        case 400:{
            /// 请求失败
            break;
        }
        case 403:{
            /// 服务器拒绝请求
            break;
        }
        case 422:{
            /// 请求出错
            break;
        }
        default:
            if ([error.domain isEqual:NSURLErrorDomain]) {
                errorDesc = @"请求出错了，请稍后重试~";
                switch (error.code) {
                    case NSURLErrorTimedOut:{
                        errorDesc = @"请求超时，请稍后再试~";
                        break;
                    }
                    case NSURLErrorNotConnectedToInternet:{
                        errorDesc = @"网络开小差了，请稍后重试~";
                        break;
                    }
                }
            }
    }
    userInfo[HTTPServiceErrorHTTPStatusCodeKey] = @(HTTPCode);
    userInfo[HTTPServiceErrorDescriptionKey] = errorDesc;
    if (task.currentRequest.URL) userInfo[HTTPServiceErrorRequestURLKey] = task.currentRequest.URL.absoluteString;
    if (task.error) userInfo[NSUnderlyingErrorKey] = task.error;
    return [NSError errorWithDomain:HTTPServiceErrorDomain
                               code:HTTPCode
                           userInfo:userInfo];
}

- (void)downloadUrl:(NSString *)url
   downloadFilePath:(NSString *)downloadFilePath
            success:(void (^) (id responseObject))successful
            failure:(void (^) (NSError *error))failure{
    //下载地址
    NSURL *downloadURL = [NSURL URLWithString:url];
    //设置请求
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    //下载操作
    NSURLSessionDownloadTask *downloadTask = [self.downLoadManager downloadTaskWithRequest:request
                                                                                  progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"KKK = %@",downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath,
                                    NSURLResponse * _Nonnull response) {
        //文件夹创建等操作在外层完成
        NSString *filePath = [downloadFilePath stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        successful(filePath);
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response,
                          NSURL * _Nullable filePath,
                          NSError * _Nullable error) {
        if(error){
            failure(error);
        }
    }];
    //开始下载任务
    [downloadTask resume];
}

- (void)PUTUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(void (^)(id responseObject))successful
       failure:(void (^) (NSError *error))failure{
    NSError *error = nil;
    if (url.length == 0 || [url isEqualToString:@""]) {
        failure(error);
    }
    [self.manager PUT:url
           parameters:parameters
              headers:nil
              success:^(NSURLSessionDataTask * _Nonnull task,
                        id  _Nullable responseObject) {
        successful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)DeleteUrl:(NSString *)url
       parameters:(NSDictionary *)parameters
          success:(void (^)(id responseObject))successful
          failure:(void (^) (NSError *error))failure{
    NSError *error = nil;
    //判断接口是否是空值
    
    if (url.length == 0 || [url isEqualToString:@""]) {
        failure(error);
    }
    self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    //开始请求内容
    [self.manager DELETE:url
              parameters:parameters
                 headers:nil
                 success:^(NSURLSessionDataTask * _Nonnull task,
                           id  _Nullable responseObject) {
        successful(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark —— lazyLoad
-(AFHTTPResponseSerializer *)HTTPResponseSerializers{
    if (!_HTTPResponseSerializers) {
        _HTTPResponseSerializers = AFHTTPResponseSerializer.serializer;
    }return _HTTPResponseSerializers;
}

-(AFJSONResponseSerializer *)JSONResponseSerializer{
    if (!_JSONResponseSerializer) {
        _JSONResponseSerializer = AFJSONResponseSerializer.serializer;
        _JSONResponseSerializer.removesKeysWithNullValues = YES;
        _JSONResponseSerializer.readingOptions = NSJSONReadingAllowFragments;
    }return _JSONResponseSerializer;
}

-(AFXMLParserResponseSerializer *)XMLParserResponseSerializer{
    if (!_XMLParserResponseSerializer) {
        _XMLParserResponseSerializer = AFXMLParserResponseSerializer.serializer;
    }return _XMLParserResponseSerializer;
}

-(AFURLSessionManager *)downLoadManager{
    if (!_downLoadManager) {
        _downLoadManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }return _downLoadManager;
}

-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = AFHTTPSessionManager.manager;
        
        AFHTTPRequestSerializer *serializer = AFHTTPRequestSerializer.serializer;
        [serializer setValue:@"e6c171fa601c0464b35b7732a6c61b59"
          forHTTPHeaderField:@"Authorization"];
        [serializer setStringEncoding:NSUTF8StringEncoding];
        
        //        _manager.requestSerializer = AFHTTPRequestSerializer.serializer;
        //        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        [_manager setRequestSerializer:serializer];
        _manager.securityPolicy = self.securityPolicy;
        //设置token
        //        [_manager.requestSerializer setValue:@"e6c171fa601c0464b35b7732a6c61b59"
        //                          forHTTPHeaderField:@"Authorization"];
        // 设置请求超时
        _manager.requestSerializer.timeoutInterval = 10.f;
        
        [_manager.requestSerializer setValue:@"e6c171fa601c0464b35b7732a6c61b59" forHTTPHeaderField:@"Authorization"];
        
        
        NSLog(@"%@",_manager.requestSerializer.HTTPRequestHeaders);
        
        //        _manager.requestSerializer.HTTPRequestHeaders = @{@"Authorization":@"e6c171fa601c0464b35b7732a6c61b59"};
        //
        // 设置允许同时最大并发数量,过大容易出问题
        _manager.operationQueue.maxConcurrentOperationCount = 4;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                              @"text/json",
                                                              @"text/javascript",
                                                              @"text/html",
                                                              @"text/plain",
                                                              @"text/html; charset=UTF-8",
                                                              @"text/xml",
                                                              @"image/*",
                                                              nil];/// 支持解析 KKK
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusUnknown) {
                NSLog(@"--- 未知网络 ---");
                [MBProgressHUD wj_showPlainText:@"网络状态未知"
                                           view:nil];
                
            }else if (status == AFNetworkReachabilityStatusNotReachable) {
                [MBProgressHUD wj_showPlainText:@"网络不给力，请检查网络"
                                           view:nil];
            }else{
                NSLog(@"--- 有网络 ---");
            }
        }];
    }return _manager;
}

-(AFSecurityPolicy *)securityPolicy{
    if (!_securityPolicy) {
        _securityPolicy = AFSecurityPolicy.defaultPolicy;//[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        //如果是需要验证自建证书，需要设置为YES
        _securityPolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO
        //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        _securityPolicy.validatesDomainName = NO;
    }return _securityPolicy;
}

-(AFNetworkReachabilityManager *)afNetworkReachabilityManager{
    if (!_afNetworkReachabilityManager) {
        //        1.创建网络监听管理者
        _afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }return _afNetworkReachabilityManager;
}

@end
