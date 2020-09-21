//
//  CADisplayLink_TimerManager.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerManager_DefineStructure.h"

//此类虽然为工具类，但是不允许用单例，因为timer需要被释放
NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLink_TimerManager : NSObject

@property(nonatomic,strong)CADisplayLink *displayLink;
@property(nonatomic,copy)MKDataBlock CADisplayLinkTimerManagerBlock;

@end

NS_ASSUME_NONNULL_END
