//
//  CADisplayLink_TimerManager.m
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CADisplayLink_TimerManager.h"

@interface CADisplayLink_TimerManager ()

@end

@implementation CADisplayLink_TimerManager

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)displayLinkMethod{
    if (self.CADisplayLinkTimerManagerBlock) {
        self.CADisplayLinkTimerManagerBlock(self.displayLink);
    }
}
///需要定时器做的事情，回调
-(void)actionCADisplayLinkTimerManagerBlock:(MKDataBlock _Nullable)CADisplayLinkTimerManagerBlock{
    _CADisplayLinkTimerManagerBlock = CADisplayLinkTimerManagerBlock;
}
#pragma mark —— lazyLoad
//CAD 目前有且仅有这一个初始化方法
-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(displayLinkMethod)];
    }return _displayLink;
}

@end
