//
//  DDNetworkingAPI+EarnApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
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

///// 首页宝箱奖励 POST
//+(URLManagerModel *)boxRewardPOST;
///// 抖币领取开关 GET
//+(URLManagerModel *)goldSwitchGET;
///// 抖币领取开关 POST
//+(URLManagerModel *)goldSwitchPOST;
///// 首页看视频得抖币奖励 POST
//+(URLManagerModel *)randomRewardPOST;
///// 首页看视频得抖币配置 GET
//+(URLManagerModel *)rewardSnapshotGET;
///// 首页看视频得抖币配置 POST
//+(URLManagerModel *)rewardSnapshotPOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (EarnApi)

#pragma mark —— App看视频获得金币奖励
/// 首页宝箱奖励
+(void)boxRewardPOST:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 抖币领取开关
+(void)goldSwitchGET:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 抖币领取开关
+(void)goldSwitchPOST:(id)parameters
         successBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币奖励
+(void)randomRewardPOST:(id)parameters
           successBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotGET:(id)parameters
            successBlock:(MKDataBlock)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
