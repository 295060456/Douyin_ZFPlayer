//
//  DispatchTimerManager.h
//  SelectorBlock
//
//  Created by Jobs on 2021/4/16.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DispatchTimerState) {
    DispatchTimerState_init = 0,
    DispatchTimerState_resume,
    DispatchTimerState_suspend
};

NS_ASSUME_NONNULL_BEGIN
/**
    前言：
    Dispatch Source Timer 是一种与 Dispatch Queue 结合使用的定时器。
    当需要在后台 queue 中定期执行任务的时候，使用 Dispatch Source Timer 要比使用 NSTimer 更加自然，也更加高效（无需在 main queue 和后台 queue 之前切换）。
    dispatch timer中用到的时间都是纳秒，即NSEC_PER_SEC
 
    优点：
    计时准确
    可以使用子线程，解决定时间跑在主线程上卡UI问题
 */
@interface DispatchTimerManager : NSObject

@property(nonatomic,assign)BOOL repeats;
@property(readonly,getter=isValid)BOOL valid;
@property(nonatomic,assign)NSTimeInterval start;
@property(nonatomic,assign)NSTimeInterval timeInterval;
@property(nonatomic,retain)dispatch_semaphore_t semaphore;
@property(nonatomic,assign)SEL selector;
@property(nonatomic,nullable,retain)id userInfo;
@property(nonatomic,weak)id target;
@property(nonatomic,assign)DispatchTimerState state;

/// 同下面的方法，不过自动开始执行
+(DispatchTimerManager *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                                 target:(id)aTarget
                                               selector:(SEL)aSelector
                                               userInfo:(nullable id)userInfo
                                                repeats:(BOOL)repeats;
/// 扩充block
+(DispatchTimerManager *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                                repeats:(BOOL)repeats
                                                  block:(void (^)(DispatchTimerManager *timer))block;
/// 创建一个定时器并返回，但是并不会自动执行，需要手动调用resume方法
/// @param start 定时器启动时间
/// @param interval   间隔多久开始执行selector
/// @param target 作用域
/// @param selector 执行的任务
/// @param userInfo 绑定信息
/// @param repeats 是否重复
-(instancetype)initWithTimeInterval:(NSTimeInterval)start
                           interval:(NSTimeInterval)interval
                             target:(id)target
                           selector:(SEL)selector
                           userInfo:(nullable id)userInfo
                            repeats:(BOOL)repeats;
-(void)createDispatchTimer;
/// 启动
-(void)resume;
/// 暂停
-(void)suspend;
/// 关闭
-(void)invalidate;

@end

NS_ASSUME_NONNULL_END

/* 使用示例：
     {
         self.dispatchTimer = [DispatchTimerManager scheduledTimerWithTimeInterval:.5f
                                                                           repeats:YES
                                                                             block:^(DispatchTimerManager * _Nonnull timer) {
             NSLog(@"sde");
         }];
     }
     // 或者
     {
         self.dispatchTimer = [[DispatchTimerManager alloc] initWithTimeInterval:3
                                                                        interval:1
                                                                          target:self
                                                                        selector:@selector(demo1:)
                                                                        userInfo:nil
                                                                         repeats:YES];
         [self.dispatchTimer resume];
     }
     // 亦或者
     {
         self.dispatchTimer = DispatchTimerManager.new;
         self.dispatchTimer.start = 3;
         self.dispatchTimer.timeInterval = 1;
         self.dispatchTimer.target = self;
         self.dispatchTimer.selector = @selector(demo1:);
         self.dispatchTimer.repeats = YES;

         [self.dispatchTimer createDispatchTimer];
         [self.dispatchTimer resume];
     }
 **/
