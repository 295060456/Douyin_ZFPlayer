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

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,copy)void(^scrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
