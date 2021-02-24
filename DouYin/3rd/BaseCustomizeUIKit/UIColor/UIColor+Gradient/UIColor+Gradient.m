//
//  UIColor+Gradient.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/1.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

+(UIColor *)gradientCorDataMutArr:(NSMutableArray <UIColor *>*_Nullable)CorDataMutArr
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                           opaque:(BOOL)opaque
                   targetViewRect:(CGRect)targetViewRect{
    
    if (!CorDataMutArr) {
        CorDataMutArr = NSMutableArray.array;
        [CorDataMutArr addObject:(id)UIColor.redColor.CGColor];
        [CorDataMutArr addObject:(id)UIColor.greenColor.CGColor];
    }else{
        for (int t = 0; t < CorDataMutArr.count; t++) {
            [CorDataMutArr replaceObjectAtIndex:t
                                     withObject:(id)CorDataMutArr[t].CGColor];
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetViewRect.size,
                                           opaque,
                                           [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制渐变层
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef,
                                                           (__bridge CFArrayRef)CorDataMutArr,
                                                           NULL);
    
    CGPoint EndPoint = endPoint;
    if (CGPointEqualToPoint(endPoint, CGPointZero)) {
        EndPoint = CGPointMake(CGRectGetMaxX(targetViewRect),
                               CGRectGetMaxY(targetViewRect));
    }

    CGContextDrawLinearGradient(context,
                                gradientRef,
                                startPoint,
                                EndPoint,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    //取到渐变图片
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放资源
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradientRef);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:gradientImage];
}

@end
