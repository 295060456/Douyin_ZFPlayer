//
//  NetworkingAPI.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "NetworkingAPI.h"
#import "NetworkingAPI+StatisticsApi.h"//数据统计相关接口
#import "NetworkingAPI+LoginApi.h"//APP登录信息相关接口
#import "NetworkingAPI+AdsApi.h"//APP广告相关接口
#import "NetworkingAPI+FriendsRelationshipApi.h"//APP好友关系相关接口
#import "NetworkingAPI+BlankList.h"//APP黑名单相关接口
#import "NetworkingAPI+ConfigApi.h"//APP获取配置信息
#import "NetworkingAPI+EarnApi.h"//APP看视频获得金币奖励
#import "NetworkingAPI+CommentApi.h"//APP评论相关接口
#import "NetworkingAPI+WalletApi.h"//APP钱包相关接口
#import "NetworkingAPI+VideoApi.h"//APP视频相关接口
#import "NetworkingAPI+MsgApi.h"//App消息相关接口
#import "NetworkingAPI+MsgStateApi.h"//App消息状态相关接口
#import "NetworkingAPI+BankCardApi.h"//APP银行卡相关接口
#import "NetworkingAPI+UserFansApi.h"//APP用户粉丝相关接口
#import "NetworkingAPI+UserInfoApi.h"//APP用户信息相关接口
/*
 * 只定义successBlock处理我们想要的最正确的答案,并向外抛出
 * 错误在内部处理不向外抛出
 */
@implementation NetworkingAPI
#pragma mark —— 普通的网络请求
/// 【只有Body参数、不需要错误回调】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock{
    
    NSLog(@"接口名：%@，请求参数打印 %@",requestApi,parameters);
    
    {
        NSMutableArray *paramMutArr = NSMutableArray.array;
        [paramMutArr addObject:parameters];
        
        if (successBlock) {
            [paramMutArr addObject:successBlock];
        }

        NSString *funcName = [requestApi stringByAppendingString:@":successBlock:"];
        [NSObject methodName:funcName
                      target:self
                 paramarrays:paramMutArr];
    }
}
///【只有Body参数、需要错误回调的】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{
    
    NSLog(@"接口名：%@，请求参数打印 %@",requestApi,parameters);
    
    {
        NSMutableArray *paramMutArr = NSMutableArray.array;
        [paramMutArr addObject:parameters];
        
        if (successBlock) {
            [paramMutArr addObject:successBlock];
        }
        
        if (failureBlock) {
            [paramMutArr addObject:failureBlock];
        }

        NSString *funcName = [requestApi stringByAppendingString:@":successBlock:failureBlock:"];
        [NSObject methodName:funcName
                      target:self
                 paramarrays:paramMutArr];
    }
}
#pragma mark —— 特殊的上传文件的网络请求
/// 上传【图片】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadImagesParamArr:(NSArray *)uploadImagesParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{

    NSMutableArray *paramMutArr = [NSMutableArray arrayWithArray:uploadImagesParamArr];
    
    if (successBlock) {
        [paramMutArr addObject:successBlock];
    }
    
    if (failureBlock) {
        [paramMutArr addObject:failureBlock];
    }
    
    NSString *funcName = [requestApi stringByAppendingString:@":uploadImageDatas:successBlock:failureBlock:"];
    [NSObject methodName:funcName
                  target:self
             paramarrays:paramMutArr];
}
/// 上传【视频】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadVideosParamArr:(NSArray *)uploadVideosParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{

    NSMutableArray *paramMutArr = [NSMutableArray arrayWithArray:uploadVideosParamArr];
    
    if (successBlock) {
        [paramMutArr addObject:successBlock];
    }
    
    if (failureBlock) {
        [paramMutArr addObject:failureBlock];
    }
    
    NSString *funcName = [requestApi stringByAppendingString:@":uploadVideo:successBlock:failureBlock:"];
    [NSObject methodName:funcName
                  target:self
             paramarrays:paramMutArr];
}

@end
