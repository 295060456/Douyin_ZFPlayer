//
//  NetworkingAPI+DemoApi.h
//  DouYin
//
//  Created by Jobs on 2020/12/10.
//

#import "NetworkingAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (DemoApi)

+(void)demoRequestDataPOST:(id)parameters
          withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
