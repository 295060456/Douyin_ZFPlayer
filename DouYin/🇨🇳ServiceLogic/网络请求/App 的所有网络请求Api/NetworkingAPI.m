//
//  NetworkingAPI.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "NetworkingAPI.h"

@implementation NetworkingAPI

+(void)requestVedioWithBlock:(MKDataBlock)successBlock{
    
    NSDictionary *parameters = @{};
    NSDictionary *headers = @{};
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {
        
        request.URLString = append(@"%@%@",server_URL,[URL_Manager sharedInstance].MKVideosRecommendVideosPOST);
        
        NSLog(@"request.URLString = %@",request.URLString);
        
        request.methodType = ZBMethodTypePOST;//默认为GET
        request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
        request.parameters = parameters;//与公共配置 Parameters 兼容
        request.headers = headers;//与公共配置 Headers 兼容
        request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
        request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
        request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
        
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

+(void)temp{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/testImage.png"];
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
        request.URLString = @"https://www.bombom999.top/my-bucketname/images/iosimg.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minio%2F20201019%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201019T074421Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=61523129bacc68290a6de367080edd39e0bc9909882ffac0265fd8f4d03b212d";
        request.methodType = ZBMethodTypeUpload;
        request.requestSerializer = ZBHTTPResponseSerializer;
        
       // [request addFormDataWithName:@"image[]" fileData:fileData];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"];

//        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:path];
//        inputStream.delegate = self;
//        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [inputStream open];
        
        [request addFormDataWithName:@"11111" fileURL:[NSURL URLWithString:path]];
        
    } progress:^(NSProgress * _Nullable progress) {
        NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
        
    } success:^(id  responseObject,ZBURLRequest * request) {
        NSLog(@"responseObject: %@", responseObject);
    } failure:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error);
    }];
}

@end
