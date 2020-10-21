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

-(void)shadowCellWithLayerCornerRadius:(CGFloat)layerCornerRadius
                      layerShadowColor:(UIColor *__nullable)layerShadowColor
                       backgroundColor:(UIColor *__nullable)backgroundColor
                     layerShadowRadius:(CGFloat)layerShadowRadius
                    layerShadowOpacity:(CGFloat)layerShadowOpacity{
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = (layerCornerRadius != 0) ? : 20.0f;
    self.backgroundColor = backgroundColor ? :kClearColor;
    self.layer.cornerRadius = (layerCornerRadius != 0) ? : self.contentView.layer.cornerRadius;
    self.layer.shadowColor = (layerShadowColor ? :KDarkGrayColor).CGColor;
    self.layer.shadowOffset = CGSizeMake(self.contentView.layer.cornerRadius / 2, self.contentView.layer.cornerRadius / 2);
    self.layer.shadowRadius = (layerShadowRadius != 0) ? : 8.0f;
    self.layer.shadowOpacity = (layerShadowOpacity != 0) ? : 0.7f;
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
