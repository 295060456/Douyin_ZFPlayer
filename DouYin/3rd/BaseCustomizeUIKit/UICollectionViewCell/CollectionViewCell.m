//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell
//由具体的子类进行覆写
+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//由具体的子类进行覆写
-(void)richElementsInCellWithModel:(id _Nullable)model{}
// 实现cell抖动方法
-(void)beginShake{
    CAKeyframeAnimation *anim = CAKeyframeAnimation.animation;
    anim.keyPath = @"transform.rotation";
    anim.duration = 0.2;
    anim.repeatCount = MAXFLOAT;
    anim.values = @[@(-0.03),
                    @(0.03),
                    @(-0.03)];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim
                      forKey:@"shake"];
}
// 实现cell停止抖动方法
-(void)stopShake{
    [self.layer removeAllAnimations];
}

@end
