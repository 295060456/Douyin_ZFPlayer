//
//  TBVCell_style_01.m
//  gt
//
//  Created by Administrator on 11/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import "TBVCell_style_02.h"

@interface TBVCell_style_02()

@property(nonatomic,assign)CGFloat marginX;
@property(nonatomic,assign)CGFloat marginY;

@end

@implementation TBVCell_style_02

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                      marginX:(CGFloat)marginX
                      marginY:(CGFloat)marginY{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.marginX = marginX;
        self.marginY = marginY;
    }return self;
}

-(void)shadowCell{
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 20.0f;
    self.backgroundColor = kClearColor;
    self.layer.cornerRadius = 20;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowRadius = 8.0f;
    self.layer.shadowOpacity = 0.7f;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += self.marginX;
    frame.origin.y += self.marginY;
    frame.size.height -= self.marginY;
    frame.size.width -= self.marginX * 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

@end
