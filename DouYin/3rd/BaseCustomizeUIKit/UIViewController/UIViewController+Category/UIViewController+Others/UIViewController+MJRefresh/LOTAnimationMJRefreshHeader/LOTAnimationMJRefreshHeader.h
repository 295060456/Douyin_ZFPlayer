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

#import "MJRefreshConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    RefreshingType_beginRefreshing = 0,//开始刷新
    RefreshingType_endRefreshing//结束刷新
} RefreshingType;

/// 下拉刷新动画
@interface LOTAnimationMJRefreshHeader : MJRefreshGifHeader

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigModel;
@property(nonatomic,assign)CGSize lOTAnimationViewSize;

-(void)actionBlockRefresh:(MKDataBlock)refreshBlock;//开始刷新和结束刷新可以做的动作

@end

NS_ASSUME_NONNULL_END
