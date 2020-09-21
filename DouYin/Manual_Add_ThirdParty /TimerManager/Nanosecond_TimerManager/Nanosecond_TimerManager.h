//
//  Nanosecond_TimerManager.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerManager_DefineStructure.h"

#import <mach/mach.h>
#import <mach/mach_time.h>

//此类虽然为工具类，但是不允许用单例，因为timer需要被释放
NS_ASSUME_NONNULL_BEGIN

@interface Nanosecond_TimerManager : NSObject

static uint64_t nanos_to_abs(uint64_t nanos);
void waitSeconds(int seconds);

@end

NS_ASSUME_NONNULL_END
