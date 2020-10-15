//
//  UIView+Animation.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)
//图片从小放大
+(void)animationAlert:(UIView *)view;

// 重力弹跳动画效果
void shakerAnimation (UIView *view,
                      NSTimeInterval duration,
                      float height);

+(void)视图上下一直来回跳动的动画:(UIView *)view;

///点击放大再缩小
+ (void)addViewAnimation:(UIView *)sender
         completionBlock:(MKDataBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
