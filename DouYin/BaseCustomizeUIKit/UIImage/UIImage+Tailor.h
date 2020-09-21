//
//  UIImage+tailor.h
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tailor)

/**
*  以图片中心为中心，以最小边为边长，裁剪正方形图片
*
*  @param image       要裁剪的图片
*
*  @return 生成的圆形图片
*/
+(UIImage *)cropSquareImage:(UIImage *)image;

/**
 *  生成一张圆形图片
 *
 *  @param image       要裁剪的图片
 *
 *  @return 生成的圆形图片
 */
+(UIImage *)imageWithClipImage:(UIImage *)image;

/**
 *  生成一张带有边框的圆形图片
 *
 *  @param borderW     边框宽度
 *  @param borderColor 边框颜色
 *  @param image       要添加边框的图片
 *
 *  @return 生成的带有边框的圆形图片
 */
+(UIImage *)imageWithBorder:(CGFloat)borderW
                      color:(UIColor *)borderColor
                      image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
