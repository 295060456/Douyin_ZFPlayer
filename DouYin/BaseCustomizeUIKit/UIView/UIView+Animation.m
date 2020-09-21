//
//  UIView+Animation.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

+(void)animationAlert:(UIView *)view{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 1;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f,
                                                                                   0.01f,
                                                                                   1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f,
                                                                                   1.1f,
                                                                                   1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f,
                              @0.5f,
                              @0.75f,
                              @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation
                      forKey:nil];
}


@end
