//
//  PlayerCell.h
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerCell : UITableViewCell

@property(nonatomic,strong,nullable)ZFPlayerController *player;
@property(nonatomic,assign)long index;

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockPlayerCell:(TwoDataBlock)playerCellBlock;

@end

NS_ASSUME_NONNULL_END
