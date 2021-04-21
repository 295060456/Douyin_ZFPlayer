//
//  UITableView+Expand.h
//  DouDong-II
//
//  Created by Jobs on 2021/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Expand)

/**
 隐藏每个分区最后一个cell的分割线:系统分割线,移到屏幕外
 在此方法内调用：
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath；
 
 _tableView.separatorColor = HEXCOLOR(0xeeeeee);//改变分割线颜色
 cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);//改变分割线长度

 */
-(void)hideSeparatorLineAtLast:(NSIndexPath *)indexPath
                          cell:(UITableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
