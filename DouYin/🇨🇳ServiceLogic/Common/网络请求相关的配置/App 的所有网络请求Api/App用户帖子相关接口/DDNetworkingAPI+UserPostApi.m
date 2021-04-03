//
//  DDNetworkingAPI+UserPostApi.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
//

#import "DDNetworkingAPI+UserPostApi.h"

/*
 * App端接口文档
 * http://172.24.135.53:8011/swagger-ui.html#/App%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E7%9B%B8%E5%85%B3%E6%8E%A5%E5%8F%A3
 
 开发环境：
 管理后台：http://172.24.135.55/
 app-api：http://172.24.135.55/api/
 h5：http://172.24.135.55/taskpage/

 测试环境(数据已初始化)：
 管理后台：http://172.24.135.54/dist/
 app-api：http://172.24.135.54/api/
 h5：http://172.24.135.54/taskpage/
 
 抖动生产环境
 web-admin：http://www.xiuwa.top/web/beBQJvUpWl
 H5：https://www.xiuwa.top/h5/
 API：https://www.xiuwa.top/api/
 
 抖动备用域名：
 www.vdutbr.cn
 www.peprh.cn
 www.msahe.cn
 
 */

/// 发帖 POST
//+(URLManagerModel *)postAddPostPOST;
///// 轮播图列表 GET
//+(URLManagerModel *)bannerListGET;
///// 评论帖子详情 GET
//+(URLManagerModel *)postCommentDetailInfoGET;
///// 删除帖子 POST
//+(URLManagerModel *)delPostPOST;
///// 用户帖子详情 GET
//+(URLManagerModel *)postDetailInfoGET;
///// 帖子列表 GET
//+(URLManagerModel *)postListGET;
///// 帖子我的(关注、点赞.发布) GET
//+(URLManagerModel *)postMyPostGET;
///// 帖子详情 GET
//+(URLManagerModel *)postInfoGET;
///// 点赞 POST
//+(URLManagerModel *)postPraisePostPOST;
///// 帖子图片上传 POST
//+(URLManagerModel *)postUploadImagePOST;
///// 帖子视频上传 POST
//+(URLManagerModel *)postuploadVideoPOST;
///// 用户详情  GET
//+(URLManagerModel *)postUserInfoGET;
///// 用户帖子列表 GET
//+(URLManagerModel *)userPostListGET;

@implementation DDNetworkingAPI (UserPostApi)

#pragma mark —— App用户帖子相关接口
/// 发帖 POST
NSString *postAddPostPOST;
+(void)postAddPostPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postAddPostPOST.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 轮播图列表 GET
NSString *bannerListGET;
+(void)bannerListGET:(id)parameters
        successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.bannerListGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 评论帖子详情 GET
NSString *postCommentDetailInfoGET;
+(void)postCommentDetailInfoGET:(id)parameters
                   successBlock:(MKDataBlock)successBlock{
    //    NSDictionary *parameterss = @{};
    //    NSDictionary *headers = @{};
        
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postCommentDetailInfoGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 删除帖子 POST
NSString *delPostPOST;
+(void)delPostPOST:(id)parameters
    successBlock:(MKDataBlock)successBlock{
    //    NSDictionary *parameterss = @{};
    //    NSDictionary *headers = @{};
        
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.delPostPOST.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 用户帖子详情 GET
NSString *postDetailInfoGET;
+(void)postDetailInfoGET:(id)parameters
            successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postDetailInfoGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 帖子列表 GET
NSString *postListGET;
+(void)postListGET:(id)parameters
      successBlock:(MKDataBlock)successBlock
      failureBlock:(MKDataBlock)failureBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postListGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 帖子我的(关注、点赞.发布) GET
NSString *postMyPostGET;
+(void)postMyPostGET:(id)parameters
        successBlock:(MKDataBlock)successBlock
        failureBlock:(MKDataBlock)failureBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postMyPostGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 帖子详情 GET
NSString *postInfoGET;
+(void)postInfoGET:(id)parameters
      successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postInfoGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 点赞 POST
NSString *postPraisePostPOST;
+(void)postPraisePostPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postPraisePostPOST.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 查询环体下载地址 GET
NSString *selectDowndSettingGET;
+(void)selectDowndSettingGET:(id)parameters
                successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.selectDowndSettingGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 帖子图片上传 POST
NSString *postUploadImagePOST;
+(void)postUploadImagePOST:(id)parameters
          uploadImageDatas:(NSMutableArray<UIImage *> *)uploadImageDatas
              successBlock:(MKDataBlock)successBlock
              failureBlock:(MKDataBlock)failureBlock{
    
    NSMutableArray *uploadDatas = NSMutableArray.array;
    for (int i = 0; i < uploadImageDatas.count; i++) {
        UIImage *image = uploadImageDatas[i];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
        NSString *fileName = [NSString stringWithFormat:@"%ld_%u.jpeg",time,arc4random() / 1000];
        ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                                     fileName:fileName
                                                     mimeType:@"image/jpeg"
                                                     fileData:imageData];
        [uploadDatas addObject:zbdata];
    }
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postUploadImagePOST.url];
        NSLog(@"request.URLString = %@",request.url);
        request.methodType = ZBMethodTypeUpload;
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
//        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        request.requestSerializer = ZBHTTPRequestSerializer;
        request.uploadDatas = uploadDatas;
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
    } progress:^(NSProgress * _Nullable progress) {
        NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
        [WHToast toastLoadingMsg:@"图片上传中...请稍后"];
    } success:^(id  responseObject,ZBURLRequest * request) {
        NSLog(@"responseObject: %@", responseObject);
        [WHToast toastHide];
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error);
        [WHToast toastHide];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
/// 帖子视频上传 POST
NSString *postuploadVideoPOST;
+(void)postuploadVideoPOST:(id)parameters
               uploadVideo:(NSMutableArray <NSData *>*)videoDatas
              successBlock:(MKDataBlock)successBlock
              failureBlock:(MKDataBlock)failureBlock{
    NSMutableArray *uploadDatas = NSMutableArray.array;
    for (int i = 0; i < videoDatas.count; i++) {
        NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
        NSString *fileName = [NSString stringWithFormat:@"%ld_%u.mp4", time, arc4random() / 1000];

        ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                                     fileName:fileName
                                                     mimeType:@"video/mp4"
                                                     fileData:videoDatas[i]];
        
    //    ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
    //                                                 fileName:fileName
    //                                                 mimeType:@"video/mp4"
    //                                                  fileURL:videoURL];
        [uploadDatas addObject:zbdata];
    }
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postuploadVideoPOST.url];
        NSLog(@"request.URLString = %@",request.url);
        request.methodType = ZBMethodTypeUpload;
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
//        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        request.requestSerializer = ZBHTTPRequestSerializer;
        request.uploadDatas = uploadDatas;
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
    } progress:^(NSProgress * _Nullable progress) {
        NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
        [WHToast toastLoadingMsg:@"视频上传中...请稍后"];
    } success:^(id  responseObject,ZBURLRequest * request) {
        NSLog(@"responseObject: %@", responseObject);
        [WHToast toastHide];
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error);
        [WHToast toastHide];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
/// 用户详情  GET
NSString *postUserInfoGET;
+(void)postUserInfoGET:(id)parameters
          successBlock:(MKDataBlock)successBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.postUserInfoGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}
/// 用户帖子列表 GET
NSString *userPostListGET;
+(void)userPostListGET:(id)parameters
          successBlock:(MKDataBlock)successBlock
          failureBlock:(MKDataBlock)failureBlock{
//    NSDictionary *parameterss = @{};
//    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

        request.server = NSObject.BaseUrl;
        request.url = [request.server stringByAppendingString:NSObject.userPostListGET.url];
        
        NSLog(@"request.URLString = %@",request.url);
        
        request.methodType = ZBMethodTypeGET;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        if (![NSString isNullString:[DataManager sharedInstance].tag]) {
            request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
        {
//            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
//            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
//            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
           
            /**
             多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做
             使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
             */
//            request.keepType=ZBResponseKeepNone;
        }//一些临时的其他的配置
        
    }progress:^(NSProgress * _Nullable progress){
        NSLog(@"进度 = %f",progress.fractionCompleted * 100);
    }success:^(id  _Nullable responseObject,
               ZBURLRequest * _Nullable request){
        if (successBlock) {
            successBlock(responseObject);
        }
    }failure:^(NSError * _Nullable error){
        NSLog(@"error = %@",error);
        if (failureBlock) {
            failureBlock(error);
        }
    }finished:^(id  _Nullable responseObject,
                NSError * _Nullable error,
                ZBURLRequest * _Nullable request){
        NSLog(@"请求完成 userInfo:%@",request.userInfo);
    }];
}

@end
