//
//  NetworkingAPI+EarnApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"
/*
各种环境的地址 和 接口文档地址 在这里写，方便调用
 
 */
NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (EarnApi)

#pragma mark —— APP看视频获得金币奖励
/// 首页宝箱奖励
+(void)boxRewardPOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 抖币领取开关
+(void)goldSwitchGET:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 抖币领取开关
+(void)goldSwitchPOST:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币奖励
+(void)randomRewardPOST:(id)parameters
       withsuccessBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotGET:(id)parameters
        withsuccessBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotPOST:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
