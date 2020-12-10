//
//  NetworkingAPI+UserAttentionApi.h
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

@interface NetworkingAPI (UserAttentionApi)

#pragma mark —— APP用户关注相关接口
/// 添加
+(void)userFocusAddPOST:(id)parameters
       withsuccessBlock:(MKDataBlock)successBlock;
/// 删除
+(void)userFocusDeleteGET:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 关注用户列表
+(void)userFocusListGET:(id)parameters
       withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
