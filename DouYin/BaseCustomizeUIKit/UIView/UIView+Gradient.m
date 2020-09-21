//
//  UIView+Gradient.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

+(void)setView:(UIView *)view
         layer:(CALayer *)layer
  gradientLayer:(UIColor *)startColor
       endColor:(UIColor *)endColor{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
//    [view.layer addSublayer:gradientLayer];
    [view.layer insertSublayer:gradientLayer
                         below:layer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    //    gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
    //                                  (__bridge id)[UIColor redColor].CGColor];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,
                             (__bridge id)endColor.CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
}

@end
