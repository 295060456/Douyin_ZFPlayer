//
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by Aalto on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Measure.h"

typedef enum : NSUInteger {
    ShadowDirection_top = 0,
    ShadowDirection_down,
    ShadowDirection_left,
    ShadowDirection_right,
    ShadowDirection_leftTop,
    ShadowDirection_leftDown,
    ShadowDirection_rightTop,
    ShadowDirection_rightDown,
    ShadowDirection_All
} ShadowDirection;

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (Extras)
/// 指定描边
/// @param view 作用view
/// @param color 作用颜色
/// @param width 线宽
/// @param borderType 作用方向
+ (void)setBorderWithView:(UIView *__nonnull)view
              borderColor:(UIColor *__nonnull)color
              borderWidth:(CGFloat)width
               borderType:(UIBorderSideType)borderType;
/**
 切角
 
 @param view TargetView
 @param cornerRadiusValue 切角参数
 */
+(void)cornerCutToCircleWithView:(UIView *__nonnull)view
                 andCornerRadius:(CGFloat)cornerRadiusValue;

/**
 描边
 
 @param view TargetView
 @param colour 颜色
 @param WidthOfBorder 边线宽度
 */
+(void)colourToLayerOfView:(UIView *__nonnull)view
                withColour:(UIColor *__nonnull)colour
            andBorderWidth:(CGFloat)WidthOfBorder;

/**
 *  指定圆切角
 */
+(void)appointCornerCutToCircleWithTargetView:(UIView *__nonnull)targetView
                            byRoundingCorners:(UIRectCorner)corners
                                  cornerRadii:(CGSize)cornerRadii;
//旋转
+(void)setTransform:(float)radians
            forView:(UIView *__nonnull)view;
//view 转 image
+ (UIImage *__nonnull)getImageFromView:(UIView *__nonnull)view;
/// iOS 阴影效果 添加了shadowPath后消除了离屏渲染问题 。特别提示：不能存在 -(void)drawRect:(CGRect)rect 或者在-(void)drawRect:(CGRect)rect里面写，否则无效
/// @param targetShadowview 需要作用阴影效果的View
/// @param superview 该阴影效果的View的父View
/// @param ShadowDirection 阴影朝向
/// @param offsetX 贝塞尔曲线X轴偏移量
/// @param offsetY 贝塞尔曲线Y轴偏移量
/// @param cornerRadius 圆切角参数，传0表示不切
/// @param shadowOffset  阴影偏移量
/// @param shadowOpacity 阴影的不透明度,取值范围在0~1
/// @param layerShadowColor 阴影颜色
/// @param layerShadowRadius  模糊计算的半径
+(void)makeTargetShadowview:(UIView *__nonnull)targetShadowview
                  superView:(UIView *__nullable)superview
            shadowDirection:(ShadowDirection)ShadowDirection
          shadowWithOffsetX:(CGFloat)offsetX
                    offsetY:(CGFloat)offsetY
               cornerRadius:(CGFloat)cornerRadius
               shadowOffset:(CGSize)shadowOffset
              shadowOpacity:(CGFloat)shadowOpacity
           layerShadowColor:(UIColor *__nullable)layerShadowColor
          layerShadowRadius:(CGFloat)layerShadowRadius;

@end
