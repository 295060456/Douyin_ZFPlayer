//
//  NSTimerManager.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerManager_DefineStructure.h"
#import "TimeModel.h"
#import "NSObject+Time.h"

//此类虽然为工具类，但是不允许用单例，因为timer需要被释放

//NSTimer只有被加入到runloop, 才会生效, 即NSTimer才会被真正执行
//scheduledTimerWithTimeInterval相比它的小伙伴们不仅仅是创建了NSTimer对象, 还把该对象加入到了当前的runloop中，runloop的模式为默认模式（NSDefaultRunLoopMode）!
NS_ASSUME_NONNULL_BEGIN

@interface NSTimerManager : NSObject

@property(nonatomic,strong)NSInvocation *invocation;
@property(nonatomic,strong,nullable)id target;
@property(nonatomic,assign,nullable)SEL selector;
@property(nonatomic,strong,nullable)id userInfo;
@property(nonatomic,assign)ScheduledTimerType timerType;
@property(nonatomic,assign)TimerStyle timerStyle;//逆时针模式?顺时针模式？
@property(nonatomic,assign)CGFloat anticlockwiseTime;//【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】
@property(nonatomic,assign,readonly)NSTimerCurrentStatus timerCurrentStatus;// 定时器当前状态

@property(nonatomic,assign)NSTimeInterval timeSecIntervalSinceDate;//推移时间，秒数
@property(nonatomic,assign)NSTimeInterval timeInterval;//时间间距
@property(nonatomic,assign)BOOL repeats;
@property(nonatomic,strong,nullable)NSTimer *__block nsTimer;
///需要定时器做的事情，回调
-(void)actionNSTimerManagerRunningBlock:(MKDataBlock _Nullable)NSTimerManagerRunningBlock;
///定时器销毁的时候的回调
-(void)actionNSTimerManagerFinishBlock:(MKDataBlock _Nullable)NSTimerManagerFinishBlock;
///定时器启动 手动添加定时器到RunLoop
+(void)nsTimeStart:(NSTimerManager *_Nonnull)timerManager
       withRunLoop:(NSRunLoop *_Nullable)runLoop;//currentRunLoop可调用子线程；mainrunloop主线程
///定时器启动：newTimer + 系统自动添加到RunLoop
-(NSTimer *)nsTimeStartSysAutoInRunLoop;
///定时器

///定时器暂停
+(void)nsTimePause:(NSTimerManager *)timerManager;
///定时器继续
+(void)nsTimecontinue:(NSTimerManager *)timerManager;
///销毁定时器
-(void)nsTimeDestroy;

@end

NS_ASSUME_NONNULL_END

/*  关于 - (void)fire; 方法
 *  其实他并不是真的启动一个定时器，从之前的初始化方法中我们也可以看到，建立的时候，在适当的时间，定时器就会自动启动，也即NSTimer是不准时的
 *
 *  即  fire  方法只是提前出发定时器的执行，但不影响定时器的设定时间。
 */
