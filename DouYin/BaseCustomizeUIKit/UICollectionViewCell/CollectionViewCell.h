//
//  CollectionViewCell.h
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

-(void)shadowCellWithLayerCornerRadius:(CGFloat)layerCornerRadius
                      layerShadowColor:(UIColor *__nullable)layerShadowColor
                       backgroundColor:(UIColor *__nullable)backgroundColor
                     layerShadowRadius:(CGFloat)layerShadowRadius
                    layerShadowOpacity:(CGFloat)layerShadowOpacity;

@end

NS_ASSUME_NONNULL_END
