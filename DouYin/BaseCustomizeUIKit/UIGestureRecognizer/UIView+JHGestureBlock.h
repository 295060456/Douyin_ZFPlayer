//
//  UIView+JHGestureBlock.h
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

#import <UIKit/UIKit.h>

typedef void(^JHGestureBlock)(__kindof UIView *view, __kindof UIGestureRecognizer *gesture);

typedef NS_ENUM(NSUInteger, JHGestureType) {
    JHGestureType_Tap,          // 点击
    JHGestureType_LongPress,    // 长按
    JHGestureType_Swipe,        // 轻扫
    JHGestureType_Pan,          // 移动
    JHGestureType_Rotate,       // 旋转
    JHGestureType_Pinch,        // 缩放
};

@interface UIView (JHGestureBlock)

- (__kindof UIGestureRecognizer *)addGestureRecognizer:(JHGestureType)type block:(JHGestureBlock)block;

@end

