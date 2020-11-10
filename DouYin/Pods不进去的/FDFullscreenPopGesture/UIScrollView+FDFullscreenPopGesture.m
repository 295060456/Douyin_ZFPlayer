//
//  UIScrollView+FDFullscreenPopGesture.m
//  FDFullscreenPopGestureDemo
//
//  Created by Jobs on 2020/10/6.
//  Copyright © 2020 forkingdog. All rights reserved.
//

#import "UIScrollView+FDFullscreenPopGesture.h"

@implementation UIScrollView (FDFullscreenPopGesture)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}

@end
