//
//  NetworkingAPI+BankCardApi.h
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

@interface NetworkingAPI (BankCardApi)

#pragma mark —— APP银行卡相关接口
/// 添加银行卡
+(void)bankAddPOST:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 获取银行卡信息
+(void)bankInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 删除
+(void)bankDeleteGET:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 银行卡列表
+(void)bankListGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 修改银行卡
+(void)bankUpdatePOST:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
