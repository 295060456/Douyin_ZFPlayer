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
