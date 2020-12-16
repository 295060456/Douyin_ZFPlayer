//
//  NSObject+Random.h
//  Shooting
//
//  Created by Jobs on 2020/8/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Random)

/// 获取一个随机整数，范围在[from,to），包括from，包括to
+(int)getRandomNumberFrom:(int)from
                       to:(int)to;

+(NSMutableArray *)changeGifToImage:(NSData *)gifData;

@end

NS_ASSUME_NONNULL_END
