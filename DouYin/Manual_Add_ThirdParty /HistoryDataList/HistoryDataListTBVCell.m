//
//  HistoryDataListTBVCell.m
//  My_BaseProj
//
//  Created by Administrator on 05/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "HistoryDataListTBVCell.h"

@interface HistoryDataListTBVCell (){
}

@property(nonatomic,strong)UILabel *infoLab;
@property(nonatomic,copy)MKDataBlock block;

@end

@implementation HistoryDataListTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    HistoryDataListTBVCell *cell = (HistoryDataListTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[HistoryDataListTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:ReuseIdentifier];
    }return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
    }return self;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCALING_RATIO(50);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    self.backgroundColor = KLightGrayColor;//RandomColor;
    self.textLabel.text = model;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    [self layoutIfNeeded];
}
#pragma mark —— lazyLoad


@end
