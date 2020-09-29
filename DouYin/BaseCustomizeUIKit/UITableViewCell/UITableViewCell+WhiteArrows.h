//
//  UITableViewCell+WhiteArrows.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

//UITableViewCell 右侧的小箭头 白色

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (WhiteArrows)

@end

NS_ASSUME_NONNULL_END

//实现以下方法
//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 不用系统自带的箭头
//    if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
//        UIImage *arrowImage = KIMG(@"WhiteRightArrow");
//        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:arrowImage];
//        cell.accessoryView = arrowImageView;
//    }
//}
