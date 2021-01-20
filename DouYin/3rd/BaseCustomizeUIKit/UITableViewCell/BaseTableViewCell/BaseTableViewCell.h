//
//  BaseTableViewCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/20.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)richElementsInCellWithModel:(id _Nullable)model;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
