//
//  UIView+ViewController.m
//  DouDong-II
//
//  Created by xxx on 2020/12/24.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)currentController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:UIViewController.class]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next);
    return nil;
}

@end
