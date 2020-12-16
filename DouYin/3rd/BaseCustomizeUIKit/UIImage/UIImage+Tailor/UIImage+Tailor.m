//
//  UIImage+tailor.m
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIImage+Tailor.h"

@implementation UIImage (Tailor)
/// 以图片中心为中心，以最小边为边长，裁剪正方形图片
+(UIImage *)cropSquareImage:(UIImage *)image{
    
    CGImageRef sourceImageRef = [image CGImage];//将UIImage转换成CGImageRef
    
    CGFloat _imageWidth = image.size.width * image.scale;
    CGFloat _imageHeight = image.size.height * image.scale;
    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    CGFloat _offsetX = (_imageWidth - _width) / 2;
    CGFloat _offsetY = (_imageHeight - _width) / 2;
    
    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);//按照给定的矩形区域进行剪裁
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}
///生成一张圆形图片
+ (UIImage *)imageWithClipImage:(UIImage *)image{
    //1.开启跟原始图片一样大小的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.设置一个圆形裁剪区域
    //2.1绘制一个圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                           0,
                                                                           image.size.width,
                                                                           image.size.height)];
    //2.2.把圆形的路径设置成裁剪区域
    [path addClip];//超过裁剪区域以外的内容都给裁剪掉
    //3.把图片绘制到上下文当中(超过裁剪区域以外的内容都给裁剪掉)
    [image drawAtPoint:CGPointZero];
    //4.从上下文当中取出图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}
///生成一张带有边框的圆形图片
+(UIImage *)imageWithBorder:(CGFloat)borderW
                      color:(UIColor *)borderColor
                      image:(UIImage *)image{
    //1.开启一个上下文
    CGSize size = CGSizeMake(image.size.width + 2 * borderW,
                             image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //2.绘制大圆,显示出来
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,
                                                                           0,
                                                                           size.width,
                                                                           size.height)];
    [borderColor set];
    [path fill];
    //3.绘制一个小圆,把小圆设置成裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW,
                                                                               borderW,
                                                                               image.size.width,
                                                                               image.size.height)];
    [clipPath addClip];
    //4.把图片绘制到上下文当中
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    //5.从上下文当中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
