//
//  NSObject+DefConfig.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/24.
//

#import "NSObject+DefConfig.h"

//https://www.jianshu.com/p/564b5da57ea1

@implementation NSObject (DefConfig)
// 回到主线程
-(void)getMainQueue:(NoResultBlock)block{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}
// 开启一个子线程
-(void)getGlobalQueue:(NoResultBlock)block{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        if (block) {
            block();
        }
    });
}

@end
