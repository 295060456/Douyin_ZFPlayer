//
//  UIImage+WebP_Diff.h
//  My_BaseProj
//
//  Created by Jobs on 2020/7/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WebP_Diff)

/**
 * UIKit:
 * For static image format, this value is always 0.
 * For animated image format, 0 means infinite looping.
 * @note Note that because of the limitations of categories this property can get out of sync if you create another instance with CGImage or other methods.
 * AppKit:
 * NSImage currently only support animated via GIF imageRep unlike UIImage.
 * The getter of this property will get the loop count from GIF imageRep
 * The setter of this property will set the loop count from GIF imageRep
 */
@property (nonatomic, assign) NSUInteger sd_imageLoopCount;

/**
 * The image format represent the original compressed image data format.
 * If you don't manually specify a format, this information is retrieve from CGImage using `CGImageGetUTType`, which may return nil for non-CG based image. At this time it will return `SDImageFormatUndefined` as default value.
 * @note Note that because of the limitations of categories this property can get out of sync if you create another instance with CGImage or other methods.
 */
@property (nonatomic, assign) SDImageFormat sd_imageFormat;

@end

NS_ASSUME_NONNULL_END
