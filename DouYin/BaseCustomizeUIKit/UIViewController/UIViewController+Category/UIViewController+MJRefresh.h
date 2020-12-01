//
//  UIViewController+MJRefresh.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MJRefresh)

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
