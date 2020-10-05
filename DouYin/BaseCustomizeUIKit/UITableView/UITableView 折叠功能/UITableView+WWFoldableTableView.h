//
//  UITableView+WWFoldableTableView.h
//  WWFoldableTableView
//
//  https://github.com/Tidusww/WWFoldableTableView
//  Created by Tidus on 17/1/6.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (WWFoldableTableView)

/**
 *  设为YES，让tableView具备折叠功能
 */
@property(nonatomic,assign)BOOL ww_foldable;
/**
 *  返回某个section的折叠状态。YES - 折叠中
 */
-(BOOL)ww_isSectionFolded:(NSInteger)section;
/**
 *  设置指定section的折叠状态。
 */
-(void)ww_foldSection:(NSInteger)section
                 fold:(BOOL)fold;

@end

@interface NSObject (WWExtension)

+(void)ww_swizzInstanceMethod:(SEL)methodOrig
                   withMethod:(SEL)methodNew;
+(void)ww_swizzClassMethod:(SEL)methodOrig
                withMethod:(SEL)methodNew;

@end

/*
 * 使用方法：
 *  _tableView.ww_foldable = YES;//设置可折叠
 *  点击UITableViewHeaderFooterView子类触发： [self.tableView ww_foldSection:section fold:![self.tableView ww_isSectionFolded:section]];//设置可折叠
 */
