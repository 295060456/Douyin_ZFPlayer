//
//  UIImage+SYS.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIImage+SYS.h"
#import <objc/message.h>

@implementation UIImage (SYS)

// 把类加载进内存的时候调用,只会调用一次
+ (void)load{
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method MKImageNamedMethod = class_getClassMethod(self, @selector(MKImageNamed:));
    method_exchangeImplementations(imageNamedMethod, MKImageNamedMethod);
}

+ (UIImage *)MKImageNamed:(NSString *)name{
    __block UIImage *image = nil;
    
    noResultBlock UIImageBlock_2 = ^UIImage *{
        image = [UIImage MKImageNamed:@"nodata"];//替换图片 保证一定要有
        if (!image) {
            image = nil;
        }return image;
    };
    
    mkDataBlock UIImageBlock_1 = ^UIImage *(NSString *name){//name 在这里一定不为空 过滤条件在上一层
        image = [UIImage MKImageNamed:name];
        if (!image) {
            if (UIImageBlock_2) {
                UIImageBlock_2();
            }
        }return image;
    };
    
    if ([NSString isNullString:name]) {
        if (UIImageBlock_2) {
            return UIImageBlock_2();
        }return nil;
    }else{
        if (UIImageBlock_1) {
           return UIImageBlock_1(name);
        }return nil;
    }
}

/*
 
这里MKImageNamed方法中不能调用imageNamed方法,
因为imageNamed实质已经是MKImageNamed方法了,
会出项死循环,
调用其自己的时候,
实质是调用imageNamed方法,
imageNamed中没有代用MKImageNamed,
这样就不会出现死循环;
 
*/


@end
