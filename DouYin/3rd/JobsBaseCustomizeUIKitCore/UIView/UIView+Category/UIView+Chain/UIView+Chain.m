//
//  UIView+Chain.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Chain.h"
#import <objc/runtime.h>

@implementation UIView (Chain)

+ (void)load {
    Class class = self;
    Method originMethod = class_getInstanceMethod(class, @selector(hitTest:withEvent:));
    Method targetMethod = class_getInstanceMethod(class, @selector(exchange_hitTest:withEvent:));
    if (!originMethod || !targetMethod) {
        NSLog(@"交换失败");
        return;
    }
    BOOL didAddMethod = class_addMethod(class,
                                        @selector(hitTest:withEvent:),
                                        method_getImplementation(targetMethod),
                                        method_getTypeEncoding(targetMethod));
 
    if (didAddMethod) {
        class_replaceMethod(class,
                            @selector(exchange_hitTest:withEvent:),
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, targetMethod);
    }
}
 
- (UIView *)exchange_hitTest:(CGPoint)point
                   withEvent:(UIEvent *)event {
    UIView * view = [self exchange_hitTest:point
                                 withEvent:event];
    if (view) {
        return view;
    } else {
        for (UIView * v in self.subviews) {
            if (v.ableRespose) {
                if (CGRectContainsPoint(v.frame, point)) {
                    return v;
                }
            }
        }return nil;
    }
}
#pragma mark —— @property(nonatomic,assign)BOOL ableRespose
- (void)setAbleRespose:(BOOL)ableRespose {
    objc_setAssociatedObject(self,
                             @selector(ableRespose),
                             @(ableRespose),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
 
- (BOOL)ableRespose {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

@end
