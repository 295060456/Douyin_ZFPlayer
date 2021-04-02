//
//  TimerManager_DefineStructure.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#ifndef TimerManager_DefineStructure_h
#define TimerManager_DefineStructure_h

typedef enum : NSUInteger {
    TimerStyle_clockwise = 0,//顺时针模式
    TimerStyle_anticlockwise//逆时针模式（倒计时模式）
} TimerStyle;

// 用哪一种模式进行初始化NSTimer定时器
typedef enum : NSUInteger {
    ScheduledTimerType_0 = 0,//scheduledTimerWithTimeInterval/repeats/block
    ScheduledTimerType_1,//scheduledTimerWithTimeInterval/invocation/repeats
    ScheduledTimerType_2//scheduledTimerWithTimeInterval/target/selector/userInfo/repeats
} ScheduledTimerType;
// NSTimer定时器当前状态
typedef enum : NSUInteger {
    NSTimerCurrentStatusUnknow = 0,// 定时器未知状态
    NSTimerCurrentStatusRun = 1,// 定时器正在运行
    NSTimerCurrentStatusStop = 2,// 定时器停止
    NSTimerCurrentStatusPause = 3,// 定时器暂停
    NSTimerCurrentStatusDestroy = 4// 定时器销毁
} NSTimerCurrentStatus;

#endif /* TimerManager_DefineStructure_h */
