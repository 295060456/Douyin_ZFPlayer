//
//  UIControl+XY.m
//  JinXian Finance
//
//  Created by 刘赓 on 2017/7/17.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import "UIControl+XY.h"
#import <objc/runtime.h>

@implementation UIControl (XY)

//增加两个属性
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

//时间间隔
- (NSTimeInterval)uxy_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval{
    objc_setAssociatedObject(self,
                             UIControl_acceptEventInterval,
                             @(uxy_acceptEventInterval),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//是否响应事件的标志位
-(BOOL)uxy_ignoreEvent{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

-(void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent{
    objc_setAssociatedObject(self,
                             UIControl_ignoreEvent,
                             @(uxy_ignoreEvent),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load{
    //将系统的sendAction方法和自己实现的方法进行互换
    Method a=class_getInstanceMethod(self,@selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self,@selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a,b);
}
//点击后会先进入这里
- (void)__uxy_sendAction:(SEL)action
                      to:(id)target
                forEvent:(UIEvent *)event{
    if (self.uxy_ignoreEvent) return;//根据状态判断是否继续执行
    if (self.uxy_acceptEventInterval > 0){
        self.uxy_ignoreEvent = YES;
        //周期性清空标志位
        [self performSelector:@selector(setUxy_ignoreEvent:)
                   withObject:@(NO)
                   afterDelay:self.uxy_acceptEventInterval];
    }
    //这里其实是系统的原来的sendAction to方法。
    [self __uxy_sendAction:action
                        to:target
                  forEvent:event];
}

@end

