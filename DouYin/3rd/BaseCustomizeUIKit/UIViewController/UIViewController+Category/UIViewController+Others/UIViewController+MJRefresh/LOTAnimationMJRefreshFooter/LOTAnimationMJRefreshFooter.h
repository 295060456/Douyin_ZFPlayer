//
//  LOTAnimationMJRefreshFooter.h
//  DouYin
//
//  Created by Jobs on 2021/1/8.
//

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<lottie-ios/Lottie.h>)
#import <lottie-ios/Lottie.h>
#else
#import "Lottie.h"
#endif

#import "MJRefreshConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LOTAnimationMJRefreshFooter : MJRefreshAutoGifFooter

@end

NS_ASSUME_NONNULL_END
