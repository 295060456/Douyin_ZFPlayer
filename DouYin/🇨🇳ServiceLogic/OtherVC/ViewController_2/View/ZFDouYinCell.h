//
//  ZFDouYinCell.h
//  DouYin
//
//  Created by Jobs on 2020/9/28.
//

#import <UIKit/UIKit.h>
#import "ZFTableData.h"
#import "ZFDouYinCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZFDouYinCell : UITableViewCell

@property(nonatomic,assign)long index;
@property(nonatomic,strong)VideoModel_Core *data;
@property(nonatomic,weak)id<ZFDouYinCellDelegate> delegate;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
