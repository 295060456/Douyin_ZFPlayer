//
//  UIImage+WebP_Diff.m
//  My_BaseProj
//
//  Created by Jobs on 2020/7/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIImage+WebP_Diff.h"

@implementation UIImage (WebP_Diff)

#if SD_MAC
- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            imageLoopCount = [[bitmapRep valueForProperty:NSImageLoopCount] unsignedIntegerValue];
            break;
        }
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            [bitmapRep setProperty:NSImageLoopCount withValue:@(sd_imageLoopCount)];
            break;
        }
    }
}

#else

- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    NSNumber *value = objc_getAssociatedObject(self, @selector(sd_imageLoopCount));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageLoopCount = value.unsignedIntegerValue;
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    NSNumber *value = @(sd_imageLoopCount);
    objc_setAssociatedObject(self, @selector(sd_imageLoopCount), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#endif

- (SDImageFormat)sd_imageFormat {
    SDImageFormat imageFormat = SDImageFormatUndefined;
    NSNumber *value = objc_getAssociatedObject(self, @selector(sd_imageFormat));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageFormat = value.integerValue;
        return imageFormat;
    }
    // Check CGImage's UTType, may return nil for non-Image/IO based image
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
    if (&CGImageGetUTType != NULL) {
        CFStringRef uttype = CGImageGetUTType(self.CGImage);
        imageFormat = [NSData sd_imageFormatFromUTType:uttype];
    }
#pragma clang diagnostic pop
    return imageFormat;
}

- (void)setSd_imageFormat:(SDImageFormat)sd_imageFormat {
    objc_setAssociatedObject(self, @selector(sd_imageFormat), @(sd_imageFormat), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
