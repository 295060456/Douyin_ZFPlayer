//
//  UITableView+MJRefreshAutoManger.h
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, MJFooterRefreshState) {
    MJFooterRefreshStateNormal,
    MJFooterRefreshStateLoadMore,
    MJFooterRefreshStateNoMore
};

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MJRefreshAutoManger)

@property(nonatomic,assign)MJFooterRefreshState footRefreshState;

@end

NS_ASSUME_NONNULL_END
/*
 
使用方法：
_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

}]; //1、之后初始化刷新状态：

_tableView.footRefreshState = MJFooterRefreshStateNormal;
2、用_tableView.footRefreshState = MJFooterRefreshStateLoadMore;
替代你代码的 [_tableView.mj_footerendRefreshing];
 
用_tableView.footRefreshState = MJFooterRefreshStateNoMore;
替代你代码的[_tableView.mj_footerendRefreshingWithNoMoreData];
 
*/
