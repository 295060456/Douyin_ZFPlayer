//
//  BaseVC+MJRefresh.h
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (MJRefresh)

-(MJRefreshGifHeader *)mjRefreshGifHeader;
-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter;
-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter;
-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter;
///下拉刷新
-(void)pullToRefresh;
///上拉加载更多
-(void)loadMoreRefresh;

@end

NS_ASSUME_NONNULL_END
