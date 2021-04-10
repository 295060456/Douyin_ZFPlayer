//
//  UITableView+Expand.m
//  DouDong-II
//
//  Created by Jobs on 2021/4/10.
//

#import "UITableView+Expand.h"

@implementation UITableView (Expand)
/**
 隐藏每个分区最后一个cell的分割线:系统分割线,移到屏幕外
 在此方法内调用：
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath；

 */
-(void)hideSeparatorLineTableView:(UITableView *)tableView
                             last:(NSIndexPath *)indexPath
                             cell:(UITableViewCell *)cell{
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    }
}

@end
