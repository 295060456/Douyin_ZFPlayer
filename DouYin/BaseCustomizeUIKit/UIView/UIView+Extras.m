//
//  UIView+Extension.m
//  MJRefreshExample
//
//  Created by Aalto on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIView+Extras.h"

static const void *leftLittleButtonEventBlockKey = &leftLittleButtonEventBlockKey;
static const void *leftButtonEventBlockKey = &leftButtonEventBlockKey;
static const void *rightButtonEventBlockKey = &rightButtonEventBlockKey;

@implementation UIView (Extras)

- (void)setBorderWithView:(UIView *)view
              borderColor:(UIColor *)color
              borderWidth:(CGFloat)width
               borderType:(UIBorderSideType)borderType{
    /// 左
    if (borderType & UIBorderSideTypeLeft) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 0,
                                 width,
                                 view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 右
    if (borderType & UIBorderSideTypeRight){
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width,
                                 0,
                                 width,
                                 view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 上
    if (borderType & UIBorderSideTypeTop) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 0,
                                 view.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    /// 下
    if (borderType & UIBorderSideTypeBottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0,
                                 view.frame.size.height - width,
                                 view.frame.size.width,
                                 width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
/**
 切角
 
 @param view TargetView
 @param cornerRadiusValue 切角参数
 */
+(void)cornerCutToCircleWithView:(UIView *)view
                 AndCornerRadius:(CGFloat)cornerRadiusValue{
    view.layer.cornerRadius = cornerRadiusValue;
    view.layer.masksToBounds = YES;
}
/**
 描边
 
 @param view TargetView
 @param colour 颜色
 @param WidthOfBorder 边线宽度
 */
+(void)colourToLayerOfView:(UIView *)view
                WithColour:(UIColor *)colour
            AndBorderWidth:(CGFloat)WidthOfBorder{
    view.layer.borderColor = colour.CGColor;
    view.layer.borderWidth = WidthOfBorder;
}
/**
 *  指定圆切角
 */
+(void)appointCornerCutToCircleWithTargetView:(UIView *)targetView
                            byRoundingCorners:(UIRectCorner)corners
                                  cornerRadii:(CGSize)cornerRadii{
    //设置切哪个直角
    //    UIRectCornerTopLeft     = 1 << 0,  左上角
    //    UIRectCornerTopRight    = 1 << 1,  右上角
    //    UIRectCornerBottomLeft  = 1 << 2,  左下角
    //    UIRectCornerBottomRight = 1 << 3,  右下角
    //    UIRectCornerAllCorners  = ~0UL     全部角
    if (CGSizeEqualToSize(cornerRadii, CGSizeZero)) {
        cornerRadii = CGSizeMake(10,10);
    }
    //得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:targetView.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    //创建 layer
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = targetView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    targetView.layer.mask = maskLayer;
}

+(void)setTransform:(float)radians
            forView:(UIView *)view{
    view.transform = CGAffineTransformMakeRotation(M_PI * radians);
    //    使用:例如逆时针旋转40度
    //    [setTransform:40/180 forLable:label]
}

+ (UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,
                                           NO,
                                           [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

