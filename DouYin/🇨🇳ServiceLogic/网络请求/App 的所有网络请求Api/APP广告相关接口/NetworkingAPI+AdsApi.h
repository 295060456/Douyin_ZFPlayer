//
//  NetworkingAPI+AdsApi.h
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

@interface NetworkingAPI (AdsApi)

#pragma mark —— APP广告相关接口
/// 查询开屏或视频广告
+(void)adInfoGET:(id)parameters
withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
