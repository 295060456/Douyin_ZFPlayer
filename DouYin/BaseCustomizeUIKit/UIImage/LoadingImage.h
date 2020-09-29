//
//  LoadingImage.h
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/29.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline UIImage *KIMG(NSString *imgName){
    return [UIImage imageNamed:imgName];
}

static inline UIImage *KBuddleIMG(NSString *pathForResource,NSString *oftype){
    NSString *path = [[NSBundle mainBundle] pathForResource:pathForResource ofType:oftype];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

static inline NSData *KDataByBuddleIMG(NSString *pathForResource,NSString *oftype){
    NSString *filePath = [[NSBundle mainBundle] pathForResource:pathForResource ofType:oftype];
    NSData *imgData = [NSData dataWithContentsOfFile:filePath];
    return imgData;
}

static inline UIImage *KIMGByDataFromBuddleIMG(NSString *pathForResource,NSString *oftype){
    UIImage *image = [UIImage imageWithData:KDataByBuddleIMG(pathForResource, oftype)];
    return image;
}

/*
 *
 1、imageNamed,其参数为图片的名字。
    这个方法用一个指定的名字在系统缓存中查找并返回一个图片对象如果它存在的话。
    如果缓存中没有找到相应的图片，这个方法从指定的文档中加载然后缓存并返回这个对象。
    因此imageNamed的优点是当加载时会缓存图片。
    所以当图片会频繁的使用时，那么用imageNamed的方法会比较好。
    例如：你需要在 一个TableView里的TableViewCell里都加载同样一个图标，那么用imageNamed加载图像效率很高。
    系统会把那个图标Cache到内存，在TableViewCell里每次利用那个图 像的时候，只会把图片指针指向同一块内存。
    正是因此使用imageNamed会缓存图片，即将图片的数据放在内存中，iOS的内存非常珍贵并且在内存消耗过大时，会强制释放内存，即会遇到 memory warnings。
    而在iOS系统里面释放图像的内存是一件比较麻烦的事情，有可能会造成内存泄漏。
    例如：当一个UIView对象的animationImages是一个装有UIImage对象动态数组NSMutableArray，并进行逐帧动画。
    当使用imageNamed的方式加载图像到一个动态数组NSMutableArray，这将会很有可能造成内存泄露。
    原因很显然的。
 
 2、imageWithContentsOfFile，其参数也是图片文件的路径。
    仅加载图片，图像数据不会缓存。
    因此对于较大的图片以及使用情况较少时，那就可以用该方法，降低内存消耗。
 *
 */

