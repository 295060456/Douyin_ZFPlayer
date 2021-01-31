//
//  NetworkingAPI+BlankList.h
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

@interface NetworkingAPI (BlankList)

#pragma mark —— APP黑名单相关接口
/// 添加
+(void)blackListAddPOST:(id)parameters
       withsuccessBlock:(MKDataBlock)successBlock;
/// 删除
+(void)blackListDeleteGET:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 黑名单列表
+(void)blackListGET:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
