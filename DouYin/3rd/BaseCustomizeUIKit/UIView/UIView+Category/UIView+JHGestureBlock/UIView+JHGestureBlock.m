//
//  UIView+JHGestureBlock.m
//  JHKit
//
//  Created by HaoCold on 2019/4/9.
//  Copyright © 2019 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIView+JHGestureBlock.h"
#import <objc/runtime.h>

static const char *JHGestureBlockKey;

@implementation UIView (JHGestureBlock)

- (__kindof UIGestureRecognizer *)addGestureRecognizer:(JHGestureType)type block:(JHGestureBlock)block
{
    if (block) {
        NSDictionary *dic = @{@"0":@"UITapGestureRecognizer",
                              @"1":@"UILongPressGestureRecognizer",
                              @"2":@"UISwipeGestureRecognizer",
                              @"3":@"UIPanGestureRecognizer",
                              @"4":@"UIRotationGestureRecognizer",
                              @"5":@"UIPinchGestureRecognizer"};
        
        NSString *string = dic[@(type).stringValue];
        UIGestureRecognizer *gesture = [[NSClassFromString(string) alloc] initWithTarget:self action:@selector(gestureAction:)];
        [self addGestureRecognizer:gesture];
        
        NSMutableDictionary *blockDic = objc_getAssociatedObject(self, JHGestureBlockKey);
        if (!blockDic) {
            blockDic = @{}.mutableCopy;
            objc_setAssociatedObject(self, JHGestureBlockKey, blockDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [blockDic setObject:block forKey:string];
    
        return gesture;
    }
    return nil;
}

- (void)gestureAction:(UIGestureRecognizer *)gesture
{
    NSMutableDictionary *blockDic = objc_getAssociatedObject(gesture.view, JHGestureBlockKey);
    JHGestureBlock block = blockDic[NSStringFromClass([gesture class])];
    
    if (block) {
        block(gesture.view, gesture);
    }
}

@end
