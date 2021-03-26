//
//  NSObject+DefConfig.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DefConfig)

// 回到主线程
-(void)getMainQueue:(NoResultBlock)block;
// 开启一个子线程
-(void)getGlobalQueue:(NoResultBlock)block;

@end

NS_ASSUME_NONNULL_END
