//
//  UIView+Gradient.h
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gradient)
///颜色渐变
+(void)setView:(UIView *)view
         layer:(CALayer *)layer
 gradientLayer:(UIColor *)startColor
      endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
