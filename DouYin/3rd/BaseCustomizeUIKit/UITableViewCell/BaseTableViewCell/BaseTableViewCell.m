//
//  BaseTableViewCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/20.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:ReuseIdentifier];
//        [UIView cornerCutToCircleWithView:cell andCornerRadius:6];
    }return cell;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 0;
}
#pragma mark —— lazyLoad

@end
