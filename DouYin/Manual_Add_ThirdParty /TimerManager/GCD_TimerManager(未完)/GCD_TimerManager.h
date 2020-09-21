//
//  GCD_TimerManager.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerManager_DefineStructure.h"

//此类虽然为工具类，但是不允许用单例，因为timer需要被释放

/*
 *
    Grand Central Dispatch（GCD）是异步执行任务的技术之一。
    一般将应用程序中记述的线程管理用的代码在系统级中实现。
    开发者只需要定义想执行的任务并追加到适当的Dispatch Queue中，GCD就能生成必要的线程并计划执行任务。
    由于线程管理是作为系统的一部分来实现的，因此可统一管理，也可执行任务，这样就比以前的线程更有效率。
 */

/*
 * 串行队列只有一个线程，并行队列有多个线程。
 * Dispatch Queue种类
 * Serial Dispatch Queue    串行队列，任务按照追加顺序处理(FIFO)
 * Concurrent Dispatch Queue    并行队列
 */

/*
 * iOS8.0之后的权限
 
 * QOS_CLASS_USER_INTERACTIVE 与用户交互的任务，这些任务通常跟UI级别的刷新相关，比如动画，这些任务需要在一瞬间完成

 * QOS_CLASS_USER_INITIATED 由用户发起的并且需要立即得到结果的任务，
   比如滑动scroll view时去加载数据用于后续cell的显示，这些任务通常跟后续的用户交互相关，在几秒或者更短的时间内完成

 * QOS_CLASS_DEFAULT 优先级介于user-initiated 和 utility，当没有 QoS信息时默认使用，开发者不应该使用这个值来设置自己的任务

 * QOS_CLASS_UTILITY 一些可能需要花点时间的任务，这些任务不需要马上返回结果，比如下载的任务，这些任务可能花费几秒或者几分钟的时间

 * QOS_CLASS_BACKGROUND 这些任务对用户不可见，比如后台进行备份的操作，这些任务可能需要较长的时间，几分钟甚至几个小时

 * QOS_CLASS_UNSPECIFIED 未指定
 *
 */

/**
 * dispatch_group是GCD的一项特性，能够把任务分组。
 * 调用者可以等待这组任务执行完毕，也可以提供回调函数之后继续往下执行，这组任务完成时，调用者会得到通知。常用场景比如说，下载一个大的文件，分块下载，全部下载完成后再合成一个文件。
 * 再比如同时下载多个图片，监听全部下载完后的动作
 */

NS_ASSUME_NONNULL_BEGIN

@interface GCD_TimerManager : NSObject

@end

NS_ASSUME_NONNULL_END
