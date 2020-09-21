//
//  UIImage+Overlay.h
//  Shooting
//
//  Created by Jobs on 2020/8/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Overlay)
///融合两个图片为一个新图
+(UIImage *)addImage:(UIImage *)image1
           withImage:(UIImage *)image2
   image2Coefficient:(CGFloat)image2Coefficient;

@end

NS_ASSUME_NONNULL_END
