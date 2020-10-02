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

@property(nonatomic,strong)UIImage *img;
@property(nonatomic,assign)CGSize size;

-(void)customAccessoryView:(MKDataBlock)customAccessoryViewBlock;

@end

NS_ASSUME_NONNULL_END

/*
 
//实现以下方法
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.img = KIMG(@"删除");
    @weakify(self)
    [cell customAccessoryView:^(id data) {
        @strongify(self)
        JobsSearchShowHistoryDataTBVCell *cell = (JobsSearchShowHistoryDataTBVCell *)data;
        NSLog(@"MMM - %ld",cell.index);
    }];
}
 
*/
