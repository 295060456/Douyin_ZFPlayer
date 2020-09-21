//
//  UIImage+Extras.h

//
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extras)
/**
 根据颜色生成图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;
/**
 根据颜色生成图片
 
 @param color 颜色
 @param rect 大小
 @return --
 */
+(UIImage *)imageWithColor:(UIColor *)color
                       rect:(CGRect)rect;
/**
 *  UIColor 转 UIImage
 */
+(UIImage *)createImageWithColor:(UIColor *)color;
///???
+(UIImage *)imageWithString:(NSString *)string
                       font:(UIFont *)font
                      width:(CGFloat)width
              textAlignment:(NSTextAlignment)textAlignment
            backGroundColor:(UIColor *)backGroundColor
                  textColor:(UIColor *)textColor;

///根据字符串生成二维码
+(UIImage *)createRRcode:(NSString *)sourceString;
///???
+(UIImage *)createNonInterpolatedUIImageFormString:(NSString *)string
                                          withSize:(CGFloat)size;


@end

NS_ASSUME_NONNULL_END
