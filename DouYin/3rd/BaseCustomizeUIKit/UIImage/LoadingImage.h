//
//  LoadingImage.h
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/29.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extras.h"

/// 直接拖图片在项目文件夹，没用Bundle进行管理，也没有用Assets.xcassets
/// @param imgName 文件可以不强制要求带后缀名，系统会自动识别png文件
static inline UIImage *__nullable KIMG(NSString *__nonnull imgName){
    return [UIImage imageNamed:imgName];
}
/// 读取自定义Bundle文件里面的图片 输出 NSString *
/// @param bundle_folderName 如果在此自定义Bundle下还存在文件夹，不管几级都在此写，属于中间路径，函数内部是进行字符串拼接
/// @param pathForResource 自定义 Bundle 的名字
/// @param fileFullNameWithSuffix 目标图片的名字，如果不带后缀名，函数内部直接强制加 @".png" 后缀
/// @param blueFolderName 如果资源存在于蓝色文件夹下则blueFolderName是蓝色文件夹的名字，如果资源位于黄色文件夹下则不填
static inline NSString *__nullable pathForBuddleIMG(NSString *__nullable blueFolderName,
                                                    NSString *__nullable pathForResource,
                                                    NSString *__nullable bundle_folderName,
                                                    NSString *__nonnull fileFullNameWithSuffix){
    NSString *filePath = nil;
    if ([NSString isNullString:blueFolderName]) {//最外层是黄色文件夹
        filePath = [[NSBundle mainBundle] pathForResource:pathForResource
                                                   ofType:@"bundle"];
    }else{//最外层是蓝色文件夹
        filePath = [[NSBundle mainBundle] pathForResource:pathForResource
                                                   ofType:@"bundle"
                                              inDirectory:blueFolderName];//蓝色文件夹下是bundle
        
        if ([NSString isNullString:filePath]) {//蓝色文件夹下是蓝色文件夹
            filePath = blueFolderName;
        }
    }
    
    if (![NSString isNullString:bundle_folderName]) {
        filePath = [filePath stringByAppendingPathComponent:bundle_folderName];
    }
    
    //容错处理
    if (![fileFullNameWithSuffix containsString:@"."]) {//如果是其他格式资源请自带后缀名
        fileFullNameWithSuffix = [fileFullNameWithSuffix stringByAppendingString:@".png"];
    }
    
    filePath = [filePath stringByAppendingPathComponent:fileFullNameWithSuffix];
    return filePath;
}
/// 读取自定义Bundle文件里面的图片 输出 UIImage *
/// @param bundle_folderName 如果在此自定义Bundle下还存在文件夹，不管几级都在此写，属于中间路径，函数内部是进行字符串拼接
/// @param pathForResource 自定义 Bundle 的名字
/// @param fileFullNameWithSuffix 目标图片的名字，如果不带后缀名，函数内部直接强制加 @".png" 后缀
/// @param blueFolderName 如果资源存在于蓝色文件夹下则blueFolderName是蓝色文件夹的名字，如果资源位于黄色文件夹下则不填
static inline UIImage *__nullable KBuddleIMG(NSString *__nullable blueFolderName,
                                             NSString *__nullable pathForResource,
                                             NSString *__nullable bundle_folderName,
                                             NSString *__nonnull fileFullNameWithSuffix){
    
    NSString *filePath = pathForBuddleIMG(blueFolderName, pathForResource, bundle_folderName, fileFullNameWithSuffix);
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}
/// 读取自定义Bundle文件里面的图片 输出 NSData *
/// @param pathForResource 自定义 Bundle 的名字
/// @param bundle_folderName 如果在此自定义Bundle下还存在文件夹，不管几级都在此写，属于中间路径，函数内部是进行字符串拼接
/// @param fileFullNameWithSuffix  目标图片的名字，如果不带后缀名，函数内部直接强制加 @".png" 后缀
/// @param blueFolderName 如果资源存在于蓝色文件夹下则blueFolderName是蓝色文件夹的名字，如果资源位于黄色文件夹下则不填
static inline NSData *__nullable KDataByBuddleIMG(NSString *__nonnull pathForResource,
                                                  NSString *__nullable blueFolderName,
                                                  NSString *__nullable bundle_folderName,
                                                  NSString *__nonnull fileFullNameWithSuffix){
    NSString *filePath = pathForBuddleIMG(blueFolderName, pathForResource, bundle_folderName, fileFullNameWithSuffix);
    NSData *imgData = [NSData dataWithContentsOfFile:filePath];
    return imgData;
}

static inline UIImage *__nullable KIMGByDataFromBuddleIMG(NSString *__nonnull pathForResource,
                                                          NSString *__nullable blueFolderName,
                                                          NSString *__nullable bundle_folderName,
                                                          NSString *__nonnull fileFullNameWithSuffix){
    UIImage *image = [UIImage imageWithData:KDataByBuddleIMG(pathForResource,
                                                             blueFolderName,
                                                             bundle_folderName,
                                                             fileFullNameWithSuffix)];
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

