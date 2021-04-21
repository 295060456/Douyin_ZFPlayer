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

#import "UIView+Measure.h"

NS_ASSUME_NONNULL_BEGIN

/// 上拉加载Lottie动画
@interface LOTAnimationMJRefreshFooter : MJRefreshAutoGifFooter

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigModel;
@property(nonatomic,assign)CGSize lOTAnimationViewSize;

-(void)actionBlockRefreshFooter:(MKDataBlock)refreshFooterBlock;//开始刷新和结束刷新可以做的动作

@end

NS_ASSUME_NONNULL_END
