//
//  BaseTableViewCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/20.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"
#import "BaseCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell<BaseCellProtocol>

@property(nonatomic,assign)MKDataBlock baseTableViewCellBlock;

#pragma mark —— 功能方法
/// iOS UITableViewCell 第一行和最后一行圆角设置
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *)tableView
makeFirstAndLastCell:(nonnull UITableViewCell *)cell
     roundCorner:(CGFloat)radius
              dx:(CGFloat)dx
              dy:(CGFloat)dy
     atIndexPath:(nonnull NSIndexPath *)indexPath;
/*
    用于以此为基类的BaseTableViewCell的具体子类所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseTableViewCell:(MKDataBlock)baseTableViewCellBlock;

@end

NS_ASSUME_NONNULL_END

/**
 
 示例代码：
 
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(nonnull UITableViewCell *)cell
 forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     ///  UITableViewCell 第一行和最后一行圆角设置
     [BaseTableViewCell tableView:tableView
             makeFirstAndLastCell:cell
                      roundCorner:6
                               dx:KWidth(16)
                               dy:0
                      atIndexPath:indexPath];
 }
 **/
