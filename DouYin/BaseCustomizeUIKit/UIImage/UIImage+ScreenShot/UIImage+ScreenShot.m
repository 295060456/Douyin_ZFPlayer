//
//  UIImage+ScreenShot.m
//  DouYin
//
//  Created by Jobs on 2020/12/16.
//

#import "UIImage+ScreenShot.h"

@implementation UIImage (ScreenShot)

//将图片存本地相册 UIImageWriteToSavedPhotosAlbum

/*  iOS安全 —— 录屏、截屏判断
 *
 *UIApplicationUserDidTakeScreenshotNotification iOS7+ 截屏事件通知
 *
 *UIScreenCapturedDidChangeNotification 判断是否在录屏状态 而当录屏状态改变时，UIKit会发送录屏通知
 *
 */

/** 获取屏幕截图 */
+(UIImage *)getCurrentScreenShot{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size,
                                           YES,
                                           scale);
    [getMainWindow().layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/** 获取某个view 上的截图 */
+(UIImage *)getCurrentViewShot:(UIView *)view{
    CGSize size = view.frame.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size,
                                           YES,
                                           scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/** 获取某个scrollview 上的截图 */
+(UIImage *)getCurrentScrollviewShot:(UIScrollView *)scrollview{
    CGSize size = scrollview.contentSize;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size,
                                           YES,
                                           scale);

    //获取当前scrollview的frame 和 contentOffset
    CGRect saveFrame = scrollview.frame;
    CGPoint saveOffset = scrollview.contentOffset;
    //置为起点
    scrollview.contentOffset = CGPointZero;
    scrollview.frame = CGRectMake(0,
                                  0,
                                  scrollview.contentSize.width,
                                  scrollview.contentSize.height);

    [scrollview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //还原
    scrollview.frame = saveFrame;
    scrollview.contentOffset = saveOffset;

    return image;
}
/** 获取某个 范围内的 截图 */
+(UIImage *)getCurrentInnerViewShot:(UIView *)innerView
                                atFrame:(CGRect)rect{
    UIGraphicsBeginImageContext(innerView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [innerView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
