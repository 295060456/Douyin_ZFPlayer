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
