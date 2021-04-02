//
//  NSTimerManager.m
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSTimerManager.h"

@interface NSTimerManager ()

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,copy)MKDataBlock NSTimerManagerRunningBlock;
@property(nonatomic,copy)MKDataBlock NSTimerManagerFinishBlock;
@property(nonatomic,assign)NSTimerCurrentStatus timerCurrentStatus;// 定时器当前状态

@end

@implementation NSTimerManager

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    if (_nsTimer) {
        [self nsTimeDestroy];
    }
}

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)actionNSTimerManagerRunningBlock:(MKDataBlock _Nullable)NSTimerManagerRunningBlock{
    self.NSTimerManagerRunningBlock = NSTimerManagerRunningBlock;
}

-(void)actionNSTimerManagerFinishBlock:(MKDataBlock _Nullable)NSTimerManagerFinishBlock{
    self.NSTimerManagerFinishBlock = NSTimerManagerFinishBlock;
}
///定时器启动：newTimer + 系统自动添加到RunLoop
-(NSTimer *)nsTimeStartSysAutoInRunLoop{
    switch (self.timerType) {
        case ScheduledTimerType_0:{
            @weakify(self)
            if (!_nsTimer) {
                self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                               repeats:self.repeats
                                                                 block:^(NSTimer * _Nonnull timer) {//在block里面进行内循环
                    @strongify(self)
                    // 时间处理完再回调出去
                    switch (self.timerStyle) {
                        case TimerStyle_clockwise:{//顺时针模式
                            self.anticlockwiseTime += self.timeInterval;
                            if (self.NSTimerManagerRunningBlock) {
                                self.NSTimerManagerRunningBlock(self);//在这里可以将self.anticlockwiseTime回调出去，是当前时间
                            }
                        }break;
                        case TimerStyle_anticlockwise:{//逆时针模式（倒计时）
                            self.anticlockwiseTime -= self.timeInterval;
                            if (self.anticlockwiseTime >= 1) {
                                if (self.NSTimerManagerRunningBlock) {
                                    self.NSTimerManagerRunningBlock(self);//在这里可以将self.anticlockwiseTime回调出去，是当前时间
                                }
                            }else{
                                if (weak_self.nsTimer) {
                                    [weak_self nsTimeDestroy];
                                    if (self.NSTimerManagerFinishBlock) {
                                        self.NSTimerManagerFinishBlock(self);
                                    }
                                }
                            }
                        }break;
                            
                        default:
                            break;
                    }
                }];
                self.timerCurrentStatus = NSTimerCurrentStatusRun;
            }
        }break;
        case ScheduledTimerType_1:{
            if (!_nsTimer) {
                self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                            invocation:self.invocation
                                                               repeats:self.repeats];
                self.timerCurrentStatus = NSTimerCurrentStatusRun;
            }
        }break;
        case ScheduledTimerType_2:{
            if (!_nsTimer) {
                self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                                target:self.target
                                                              selector:self.selector
                                                              userInfo:self.userInfo
                                                               repeats:self.repeats];
                self.timerCurrentStatus = NSTimerCurrentStatusRun;
            }
        }break;

        default:{
            self.nsTimer = nil;
        }break;
    }return self.nsTimer;
}
///定时器启动 手动添加定时器到RunLoop
+(void)nsTimeStart:(NSTimerManager *_Nonnull)timerManager
       withRunLoop:(NSRunLoop *_Nullable)runLoop{
    if (timerManager.nsTimer) {
        if (!runLoop) {
            runLoop = NSRunLoop.mainRunLoop;
        }
        [runLoop addTimer:timerManager.nsTimer
                  forMode:NSRunLoopCommonModes];
        timerManager.timerCurrentStatus = NSTimerCurrentStatusRun;
    }else{
         NSAssert(0,@"属性 nsTimer 没有被成功创建,请检查");
    }
}
///定时器暂停
+(void)nsTimePause:(NSTimerManager *)timerManager{
    if (timerManager.nsTimer) {
        [timerManager.nsTimer setFireDate:NSDate.distantFuture];
        timerManager.timerCurrentStatus = NSTimerCurrentStatusPause;
    }
}
///定时器继续
+(void)nsTimecontinue:(NSTimerManager *)timerManager{
    if (timerManager.nsTimer) {
        [timerManager.nsTimer setFireDate:NSDate.distantPast];
        timerManager.timerCurrentStatus = NSTimerCurrentStatusRun;
    }
}
///销毁定时器
-(void)nsTimeDestroy{
    if (_nsTimer) {
        [_nsTimer invalidate];//这个是唯一一个可以将计时器从runloop中移出的方法
        _nsTimer = nil;
        self.timerCurrentStatus = NSTimerCurrentStatusDestroy;
    }
}
#pragma mark —— lazyLoad
#pragma mark —— 系统Api暴露出来的未被废弃的 NSTimer 的初始化方法有如下几种:

//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
//                                invocation:(NSInvocation *)invocation
//                                   repeats:(BOOL)yesOrNo;
//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
//                                    target:(id)aTarget
//                                  selector:(SEL)aSelector
//                                  userInfo:(nullable id)userInfo//????
//                                   repeats:(BOOL)yesOrNo;
//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
//                                   repeats:(BOOL)repeats
//                                     block:(void (^)(NSTimer *timer))block;

/*
*   scheduledTimerWithTimeInterval相比它的小伙伴们不仅仅是创建了NSTimer对象,
*   还把该对象加入到了当前的runloop中
*   runloop的模式为默认模式（NSRunLoopCommonModes）!
*   NSTimer只有被加入到runloop, 才会生效, 即NSTimer才会被真正执行
*/

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti
//                       invocation:(NSInvocation *)invocation
//                          repeats:(BOOL)yesOrNo;

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti
//                           target:(id)aTarget
//                         selector:(SEL)aSelector
//                         userInfo:(nullable id)userInfo//????
//                          repeats:(BOOL)yesOrNo;

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
//                          repeats:(BOOL)repeats
//                            block:(void (^)(NSTimer *timer))block;

//-(instancetype)initWithFireDate:(NSDate *)date
//                       interval:(NSTimeInterval)interval
//                        repeats:(BOOL)repeats
//                          block:(void (^)(NSTimer *timer))block;

-(NSTimer *)nsTimer{
    if (!_nsTimer) {
        @weakify(self)
        _nsTimer = [[NSTimer alloc] initWithFireDate:self.date
                                            interval:self.timeInterval
                                             repeats:self.repeats
                                               block:^(NSTimer * _Nonnull timer) {
            @strongify(self)
            switch (self.timerStyle) {
                case TimerStyle_clockwise:{//顺时针模式
                    if (self.NSTimerManagerRunningBlock) {
                        self.NSTimerManagerRunningBlock(self);//在这里可以将self.anticlockwiseTime回调出去，是当前时间
                    }
                }break;
                case TimerStyle_anticlockwise:{//逆时针模式（倒计时）
                    if (self.anticlockwiseTime >= 1) {
                        if (self.NSTimerManagerRunningBlock) {
                            self.NSTimerManagerRunningBlock(self);//在这里可以将self.anticlockwiseTime回调出去，是当前时间
                        }
                        self.anticlockwiseTime -= self.timeInterval;
                    }else{
                        [self nsTimeDestroy];
                        if (self.NSTimerManagerFinishBlock) {
                            self.NSTimerManagerFinishBlock(self);
                        }
                    }
                }break;
                    
                default:
                    break;
            }
        }];
        self.timerCurrentStatus = NSTimerCurrentStatusRun;
    }return _nsTimer;
}

-(NSDate *)date{
    if (!_date) {
        _date = [NSObject getDateFromCurrentAfterTimeInterval:self.timeSecIntervalSinceDate];
    }return _date;
}

-(NSTimeInterval)timeInterval{
    if (_timeInterval == 0) {
        _timeInterval = 1.0f;
    }return _timeInterval;
}

-(BOOL)repeats{
    if (!_repeats) {
        _repeats = YES;
    }return _repeats;
}

-(id)target{
    @weakify(self)
    if (!_target) {
        _target = weak_self;
    }return _target;
}

-(NSInvocation *)invocation{
    if (!_invocation) {
        //需要补充
    }return _invocation;
}

-(TimerStyle)timerStyle{
    if (_timerStyle == TimerStyle_anticlockwise) {
        self.repeats = YES;
    }return _timerStyle;
}

@end
