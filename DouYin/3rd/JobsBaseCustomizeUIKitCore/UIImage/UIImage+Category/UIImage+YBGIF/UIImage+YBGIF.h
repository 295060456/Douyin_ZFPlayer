//
//  UIImage+YBGIF.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YBGIF)
/**
 根据图片名字创建gif图片

 @param name 图片名字
 @return UIImage*
 */
+ (UIImage *)animatedGIFNamed:(NSString *)name;

/**
 根据NSData* 创建gif图片

 @param data NSData *
 @return UIImage *
 */
+ (UIImage *)animatedGIFWithData:(NSData *)data;

/**
 根据大小裁剪图片

 @param size 裁剪大小
 @return UIImage*
 */
- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;//貌似废弃了，不管用，再研究

@end

NS_ASSUME_NONNULL_END
