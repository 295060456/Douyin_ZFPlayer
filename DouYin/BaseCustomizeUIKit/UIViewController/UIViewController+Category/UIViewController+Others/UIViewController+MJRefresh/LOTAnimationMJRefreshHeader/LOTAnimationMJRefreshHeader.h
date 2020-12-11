//
//  UBLCustomGifHeader.h
//  DouYin
//
//  Created by John on 2020/11/14.
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

NS_ASSUME_NONNULL_BEGIN

/// 下拉刷新动画
@interface LOTAnimationMJRefreshHeader : MJRefreshGifHeader

@end

NS_ASSUME_NONNULL_END
