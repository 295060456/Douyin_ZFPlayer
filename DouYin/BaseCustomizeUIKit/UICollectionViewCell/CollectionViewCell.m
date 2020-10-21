//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell

-(void)shadowCellWithLayerCornerRadius:(CGFloat)layerCornerRadius
                      layerShadowColor:(UIColor *__nullable)layerShadowColor
                       backgroundColor:(UIColor *__nullable)backgroundColor
                     layerShadowRadius:(CGFloat)layerShadowRadius
                    layerShadowOpacity:(CGFloat)layerShadowOpacity{
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = (layerCornerRadius != 0) ? : 3;
    self.backgroundColor = backgroundColor ? :kClearColor;
    self.layer.cornerRadius = (layerCornerRadius != 0) ? : self.contentView.layer.cornerRadius;
    self.layer.shadowColor = (layerShadowColor ? :KDarkGrayColor).CGColor;
    self.layer.shadowOffset = CGSizeMake(self.contentView.layer.cornerRadius / 2, self.contentView.layer.cornerRadius / 2);
    self.layer.shadowRadius = (layerShadowRadius != 0) ? : 8.0f;
    self.layer.shadowOpacity = (layerShadowOpacity != 0) ? : 0.7f;
}

@end
