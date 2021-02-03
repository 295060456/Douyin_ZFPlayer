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
// 不需要错误回调的
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock{
    NSString *funcName = [requestApi stringByAppendingString:@":withsuccessBlock:"];
    //字符串不正确，遍历后没有会崩溃
    SuppressWarcPerformSelectorLeaksWarning([self performSelector:NSSelectorFromString(funcName)
                                                       withObject:parameters
                                                       withObject:successBlock]);
}
// 需要错误回调的
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock{
    
    NSLog(@"接口名：%@，请求参数打印 %@",requestApi,parameters);
    NSString *funcName = [requestApi stringByAppendingString:@":success:failure:"];
    //字符串不正确，遍历后没有会崩溃
    SuppressWarcPerformSelectorLeaksWarning([self performSelector:NSSelectorFromString(funcName)
                                                       withObject:parameters
                                                       withObject:successBlock]);
}

@end
