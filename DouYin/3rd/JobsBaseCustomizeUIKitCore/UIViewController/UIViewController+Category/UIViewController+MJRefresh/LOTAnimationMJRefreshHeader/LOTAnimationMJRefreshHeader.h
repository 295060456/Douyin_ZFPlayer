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

#import "UIView+Measure.h"

#import "MJRefreshConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 下拉刷新Lottie动画
@interface LOTAnimationMJRefreshHeader : MJRefreshGifHeader

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigModel;
@property(nonatomic,assign)CGSize lOTAnimationViewSize;

-(void)actionBlockRefreshHeader:(MKDataBlock)refreshHeaderBlock;//开始刷新和结束刷新可以做的动作

@end

NS_ASSUME_NONNULL_END
