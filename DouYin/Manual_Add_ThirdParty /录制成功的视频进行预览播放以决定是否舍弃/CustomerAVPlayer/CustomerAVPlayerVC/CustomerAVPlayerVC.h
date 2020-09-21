//
//  CustomerAVPlayerVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAVPlayerVC : BaseVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams//需要传资源地址 URL
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END



