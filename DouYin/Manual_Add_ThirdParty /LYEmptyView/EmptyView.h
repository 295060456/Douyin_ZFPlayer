//
//  EmptyView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#if __has_include(<LYEmptyView/LYEmptyViewHeader.h>)
#import <LYEmptyView/LYEmptyViewHeader.h>
#else
#import "LYEmptyViewHeader.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface EmptyView : LYEmptyView

+ (instancetype)diyEmptyView;

+ (instancetype)diyEmptyActionViewWithTarget:(id)target
                                      action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
