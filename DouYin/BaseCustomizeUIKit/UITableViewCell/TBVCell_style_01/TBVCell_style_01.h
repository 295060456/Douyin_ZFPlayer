//
//  TBVCell_style_01.h
//  gt
//
//  Created by Administrator on 11/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
    重设内边距
 */
@interface TBVCell_style_01 : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                      margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
