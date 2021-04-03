//
//  DDNetworkingAPI.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "DDNetworkingAPI.h"
#import "DDNetworkingAPI+CommunityApi.h"//App社区相关接口
#import "DDNetworkingAPI+StatisticsApi.h"//数据统计相关接口
#import "DDNetworkingAPI+LoginApi.h"//App登录信息相关接口
#import "DDNetworkingAPI+AdsApi.h"//App广告相关接口
#import "DDNetworkingAPI+FriendsRelationshipApi.h"//App好友关系相关接口
#import "DDNetworkingAPI+BlankList.h"//App黑名单相关接口
#import "DDNetworkingAPI+ConfigApi.h"//App获取配置信息
#import "DDNetworkingAPI+EarnApi.h"//App看视频获得金币奖励
#import "DDNetworkingAPI+CommentApi.h"//App评论相关接口
#import "DDNetworkingAPI+WalletApi.h"//App钱包相关接口
#import "DDNetworkingAPI+VideoApi.h"//App视频相关接口
#import "DDNetworkingAPI+PostFansApi.h"//App帖子粉丝相关接口
#import "DDNetworkingAPI+PostFocusApi.h"//App帖子关注相关接口
#import "DDNetworkingAPI+PostCommentApi.h"//App帖子评论相关接口
#import "DDNetworkingAPI+MsgApi.h"//App消息相关接口
#import "DDNetworkingAPI+MsgStateApi.h"//App消息状态相关接口
#import "DDNetworkingAPI+FeedBackApi.h"//App意见反馈相关接口
#import "DDNetworkingAPI+BankCardApi.h"//App银行卡相关接口
#import "DDNetworkingAPI+UserFansApi.h"//App用户粉丝相关接口
#import "DDNetworkingAPI+UserAttentionApi.h"//App用户关注相关接口
#import "DDNetworkingAPI+UserPostApi.h"//App用户帖子相关接口
#import "DDNetworkingAPI+UserInfoApi.h"//App用户信息相关接口
#import "DDNetworkingAPI+Vip.h"//AppVip相关接口
/*
 * 只定义successBlock处理我们想要的最正确的答案,并向外抛出
 * 错误在内部处理不向外抛出
 */
@implementation DDNetworkingAPI
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
        
        if (parameters) {
            [paramMutArr addObject:parameters];
        }
        
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
