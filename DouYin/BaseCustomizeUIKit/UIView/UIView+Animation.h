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

#pragma mark —— 旋转动画
@property(nonatomic,assign)CGFloat rotateChangeAngle;
@property(nonatomic,assign)__block CGFloat currentAngle;
@property(nonatomic,assign)CGFloat durationTime;
@property(nonatomic,assign)CGFloat delayTime;
@property(nonatomic,assign)BOOL isStopRotateAnimation;//默认值为NO（一直旋转）
-(void)startRotateAnimation;//开始旋转动画
-(void)stopRotateAnimation;//停止旋转动画
#pragma mark —— 图片从小放大
+(void)animationAlert:(UIView *)view;
#pragma mark —— 重力弹跳动画效果
void shakerAnimation (UIView *view,
                      NSTimeInterval duration,
                      float height);
#pragma mark —— 视图上下一直来回跳动的动画
+(void)视图上下一直来回跳动的动画:(UIView *)view;
#pragma mark —— 点击放大再缩小
+(void)addViewAnimation:(UIView *)sender
        completionBlock:(MKDataBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
