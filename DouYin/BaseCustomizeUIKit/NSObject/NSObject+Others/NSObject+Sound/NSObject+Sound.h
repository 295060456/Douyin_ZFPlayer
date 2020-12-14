//
//  NSObject+Sound.h
//  Feidegou
//
//  Created by Kite on 2019/12/2.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIControl+XY.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Sound)
/**
 播放自定义本地声音
 
 @param fileName 文件名 包含后缀
 */
+(void)playSoundWithFileName:(NSString *)fileName;

+(void)playSoundEffect:(NSString*)name
                  type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
