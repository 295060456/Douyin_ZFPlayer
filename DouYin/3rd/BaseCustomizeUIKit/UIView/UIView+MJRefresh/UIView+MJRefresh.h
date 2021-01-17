//
//  UIView+MJRefresh.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/17.
//

#import <UIKit/UIKit.h>

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MJRefresh)
/// MJRefresh 作用于targetView
@property(nonatomic,weak)UIScrollView *targetView;

@end

NS_ASSUME_NONNULL_END
