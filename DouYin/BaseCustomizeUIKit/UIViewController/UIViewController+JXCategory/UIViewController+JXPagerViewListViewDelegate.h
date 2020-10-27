//
//  UIViewController+JXPagingViewListViewDelegate.h
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import <UIKit/UIKit.h>
#if __has_include(<JXPagingView/JXPagerView.h>)
#import <JXPagingView/JXPagerView.h>
#else
#import "JXPagerView.h"
#endif

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JXPagerViewListViewDelegate)
<
JXPagerViewListViewDelegate,
UIScrollViewDelegate
>

@property(nonatomic,strong)UIScrollView *scrollView;//这个属性一旦有值，说明开启UITableViewHeaderFooterView不悬停。系统在UITableViewStylePlain模式下是默认悬停的
@property(nonatomic,strong)Class scrollViewClass;
@property(nonatomic,copy)void(^scrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
