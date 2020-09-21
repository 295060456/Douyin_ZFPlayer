//
//  CALayer+Anim.m
//  Carpenter
//
//  Created by 冯成林 on 15/4/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CALayer+Anim.h"

@implementation CALayer (Anim)

-(CAAnimation *)anim_shake:(NSArray *)rotations
                  duration:(NSTimeInterval)duration
               repeatCount:(NSUInteger)repeatCount{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];//创建关键帧动画
    kfa.values = rotations;//指定值
    kfa.duration = duration;//时长
    kfa.repeatCount=repeatCount;//重复次数
    kfa.removedOnCompletion = YES;//完成删除
    [self addAnimation:kfa
                forKey:@"rotation"];//添加
    return kfa;
}

-(CAAnimation *)anim_revers:(AnimReverDirection)direction
                   duration:(NSTimeInterval)duration
                  isReverse:(BOOL)isReverse
                repeatCount:(NSUInteger)repeatCount
             timingFuncName:(NSString *)timingFuncName{
    
    NSString *key = @"reversAnim";
    if([self animationForKey:key]) [self removeAnimationForKey:key];
    NSString *directionStr = nil;
    if(AnimReverDirectionX == direction)directionStr=@"x";
    if(AnimReverDirectionY == direction)directionStr=@"y";
    if(AnimReverDirectionZ == direction)directionStr=@"z";
    CABasicAnimation *reversAnim = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"transform.rotation.%@",directionStr]];//创建普通动画
    reversAnim.fromValue=@(0);//起点值
    reversAnim.toValue = @(M_PI_2);//终点值
    reversAnim.duration = duration;//时长
    reversAnim.autoreverses = isReverse;//自动反转
    reversAnim.removedOnCompletion = YES;//完成删除
    reversAnim.repeatCount = repeatCount;//重复次数
    [self addAnimation:reversAnim
                forKey:key];//添加
    return reversAnim;
}



@end
