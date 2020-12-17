//
//  UIViewController+MJRefresh.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "LOTAnimationMJRefreshHeader.h"
#import "MJRefreshConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MJRefresh)

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigHeader;//头部的配置信息
@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigFooter;//尾部的配置信息

#pragma mark —— MJRefreshHeader
-(LOTAnimationMJRefreshHeader *)lotAnimationMJRefreshHeader;
-(MJRefreshNormalHeader *)mjRefreshNormalHeader;
-(MJRefreshStateHeader *)mjRefreshStateHeader;
-(MJRefreshHeader *)mjRefreshHeader;
-(MJRefreshGifHeader *)mjRefreshGifHeader;

#pragma mark —— MJRefreshFooter
-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter;
-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter;
-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter;
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh;
///上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh;

@end

NS_ASSUME_NONNULL_END
