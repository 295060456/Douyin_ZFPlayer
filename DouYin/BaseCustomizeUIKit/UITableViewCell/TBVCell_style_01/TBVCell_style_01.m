//
//  TBVCell_style_01.m
//  gt
//
//  Created by Administrator on 11/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import "TBVCell_style_01.h"

@interface TBVCell_style_01()

@property(nonatomic,assign)CGFloat margin;

@end

@implementation TBVCell_style_01

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                      margin:(CGFloat)margin{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        
        self.margin = margin;
    }return self;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += self.margin;
    frame.origin.y += self.margin;
    frame.size.height -= self.margin;
    frame.size.width -= self.margin * 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
