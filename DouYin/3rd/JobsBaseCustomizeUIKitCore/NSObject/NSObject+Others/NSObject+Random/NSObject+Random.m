//
//  NSObject+Random.m
//  Shooting
//
//  Created by Jobs on 2020/8/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Random.h"
#import <ImageIO/CGImageSource.h>

@implementation NSObject (Random)

/// 获取一个随机整数，范围在[from,to），包括from，包括to
+(int)getRandomNumberFrom:(int)from
                       to:(int)to{
    return (int)(from + (arc4random() % to - from + 1));
}

+(NSMutableArray *)changeGifToImage:(NSData *)gifData{
    //通过文件的url来将gif文件读取为图片数据引用
    CFDataRef my_cfdata = CFBridgingRetain(gifData);
    CGImageSourceRef source = CGImageSourceCreateWithData(my_cfdata, NULL);
    //获取gif文件里图片的个数
    size_t count = CGImageSourceGetCount(source);
    //存放全部图片
    NSMutableArray * imageArray = [[NSMutableArray alloc]init];
    //遍历
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [imageArray addObject:[UIImage imageWithCGImage:image]];
        CGImageRelease(image);
        //获取图片信息
        NSDictionary * info = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        NSDictionary * timeDic = [info objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
    }
    return imageArray;
}

@end
