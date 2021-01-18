//
//  UIImage+Extras.m
//
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "UIImage+Extras.h"

@implementation UIImage (Extras)
/// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f,
                             0.0f,
                             1.0f,
                             1.0f);
    return [self imageWithColor:color
                           rect:rect];
}
/// 根据颜色生成图片
/// @param color 颜色
/// @param rect 大小
+ (UIImage *)imageWithColor:(UIColor *)color
                       rect:(CGRect)rect{
    /// 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    /// 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    /// 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    /// 渲染上下文
    CGContextFillRect(context, rect);
    /// 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    /// 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}
/// UIColor 转 UIImage
+(UIImage*)createImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f,
                           0.0f,
                           1.0f,
                           1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/// NSString 转 UIImage
/// @param string 准备转换的字符串
/// @param font 该字符串的字号
/// @param width 该字符串的线宽
/// @param textAlignment 字符串位置
/// @param backGroundColor 背景色
/// @param textColor 字体颜色
+ (UIImage *)imageWithString:(NSString *)string
                        font:(UIFont *)font
                       width:(CGFloat)width
               textAlignment:(NSTextAlignment)textAlignment
             backGroundColor:(UIColor *)backGroundColor
                   textColor:(UIColor *)textColor{
    
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributeDic
                                       context:nil].size;
    if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]){
        if (UIScreen.mainScreen.scale == 2.0){
            UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
        } else{
            UIGraphicsBeginImageContext(size);
        }
    }else{
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [backGroundColor set];
    CGRect rect = CGRectMake(0,
                             0,
                             size.width + 1,
                             size.height + 1);
    CGContextFillRect(context, rect);
    NSMutableParagraphStyle *paragraph = NSMutableParagraphStyle.new;
    paragraph.alignment = textAlignment;
    NSDictionary *attributes = @ {
    NSForegroundColorAttributeName:textColor,
    NSFontAttributeName:font,
    NSParagraphStyleAttributeName:paragraph
    };
    [string drawInRect:rect
        withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// NSString 转 UIImage
/// @param string 准备转换的字符串
/// @param size 字符串的尺寸
+(UIImage *)createNonInterpolatedUIImageFormString:(NSString *)string
                                          withSize:(CGFloat)size{
    //二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    //将字符串转换成NSData
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    //将CIImage转换成UIImage,并放大显示
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil,
                                                   width,
                                                   height,
                                                   8,
                                                   0,
                                                   cs,
                                                   (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage
                                           fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef,
                      scale,
                      scale);
    CGContextDrawImage(bitmapRef,
                       extent,
                       bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
///根据字符串生成二维码
+(UIImage *)createRRcode:(NSString *)sourceString{
    //1.实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //1.1>设置filter的默认值
    //因为之前如果使用过滤镜，输入有可能会被保留，因此，在使用滤镜之前，最好恢复默认设置
    [filter setDefaults];
    //2将传入的字符串转换为NSData
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    //3.将NSData传递给滤镜（通过KVC的方式，设置inputMessage）
    [filter setValue:data forKey:@"inputMessage"];
    //4.由filter输出图像
    CIImage *outputImage = [filter outputImage];
    //5.将CIImage转换为UIImage
    UIImage *qrImage = [UIImage imageWithCIImage:outputImage];
    //6.返回二维码图像
    return qrImage;
}

+(UIImage *)imageResize:(UIImage*)img
            andResizeTo:(CGSize)newSize{
    CGFloat scale = UIScreen.mainScreen.scale;
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,
                               0,
                               newSize.width,
                               newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
// 获取视频第一帧
+(UIImage *)getVideoPreViewImage:(AVURLAsset *)asset{
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time
                                        actualTime:&actualTime
                                             error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
// 截图
+(UIImage *)rendImageWithView:(UIView *)view{
//  1、开始位图上下文
    UIGraphicsBeginImageContext(CGSizeMake(view.width,view.height - 80));
//  2、获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//  3、截图
    [view.layer renderInContext:ctx];
//  4、获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//  5、关闭上下文
    UIGraphicsEndImageContext() ;
    return newImage;
}

@end
