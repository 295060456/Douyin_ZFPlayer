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

+ (instancetype)diyEmptyViewWithTitle:(NSString *_Nullable)title;

+ (instancetype)diyEmptyActionViewWithTarget:(id)target
                                      action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
/*
 _tableView.ly_emptyView = [EmptyView diyEmptyViewWithTitle:@"您还未关注账号"];
 */
