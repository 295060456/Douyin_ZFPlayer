//
//  DDNetworkingAPI+DemoTestApi.h
//  DouYin
//
//  Created by Jobs on 2021/4/17.
//

#import "DDNetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (DemoTestApi)
/*
    ❤️这里选用通用性较强的 MKDataBlock 的目的，而不是直接对【typedef void(^MKDataBlock)(id data)】进行确定类型 DDResponseModel 的原因：
    防止个别接口不按套路（msg、code、data）出牌
 */
+(void)appInterfaceTesting:(id)parameters
              successBlock:(MKDataBlock _Nullable)successBlock
              failureBlock:(MKDataBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
