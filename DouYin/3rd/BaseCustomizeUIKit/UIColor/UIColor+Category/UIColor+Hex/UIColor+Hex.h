//
//  UIColor+Hex.h
//  MicroProductShipped
//
//  Created by 刘赓 on 16/5/11.
//  Copyright © 2016年 jiweiyunwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color
                          alpha:(CGFloat)alpha;
//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
