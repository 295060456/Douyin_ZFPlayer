//
//  PlaySound.h
//  JinXian Finance
//
//  Created by 刘赓 on 2017/6/8.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaySound : NSObject

+ (void)playSoundEffect:(NSString*)name
                   type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
