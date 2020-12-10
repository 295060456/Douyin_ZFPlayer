//
//  NetworkingAPI+ConfigApi.h
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

@interface NetworkingAPI (ConfigApi)

#pragma mark —— APP获取配置信息
/// app启动参数
+(void)initializePOST:(id)parameters
     withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
