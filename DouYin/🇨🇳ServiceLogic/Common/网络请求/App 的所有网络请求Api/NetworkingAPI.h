//
//  NetworkingAPI.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import <Foundation/Foundation.h>
#import "RequestTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI : NSObject

+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
