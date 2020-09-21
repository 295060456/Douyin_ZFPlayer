//
//  CustomerGPUImagePlayerVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
//特别需要指出的是，GPUImage 不支持网络视频流媒体url的解析以及播放，只可以播放本地视频
@interface CustomerGPUImagePlayerVC : BaseVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams//需要传资源地址 URL
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
