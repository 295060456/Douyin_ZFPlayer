//
//  TBVCell_style_02.h
//  Feidegou
//
//  Created by Kite on 2019/12/16.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBVCell_style_02 : UITableViewCell

@property(nonatomic,strong)MJRefreshAutoGifFooter *tableViewFooter;
@property(nonatomic,strong)MJRefreshGifHeader *tableViewHeader;

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                     marginX:(CGFloat)marginX
                     marginY:(CGFloat)marginY;
///外部调用实现cell阴影功能
-(void)shadowCell;

@end

NS_ASSUME_NONNULL_END
