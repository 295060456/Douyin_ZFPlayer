//
//  NetworkingAPI+WalletApi.h
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

@interface NetworkingAPI (WalletApi)

#pragma mark —— APP钱包相关接口
/// 抖币兑换余额提示
+(void)chargeBalanceTipsGET:(id)parameters
           withsuccessBlock:(MKDataBlock)successBlock;
/// 金币兑换
+(void)chargeGoldPOST:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;
/// 余额兑换会员
+(void)chargeVipPOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 获取余额兑换会员类型下拉框
+(void)getToMemTypeGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 获取提现兑换类型下拉框
+(void)getWithdrawTypeGET:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 我的钱包流水
+(void)myFlowsGET:(id)parameters
 withsuccessBlock:(MKDataBlock)successBlock;
/// 获取用户信息
+(void)myWalletPOST:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;
/// 余额提现
+(void)withdrawBalancePOST:(id)parameters
          withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
