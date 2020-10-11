//
//  UIView+Rotate.m
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import "UIView+Rotate.h"

@implementation UIView (Rotate)

static char *UIView_Rotate_rotateChangeAngle = "UIView_Rotate_rotateChangeAngle";
static char *UIView_Rotate_currentAngle = "UIView_Rotate_currentAngle";
static char *UIView_Rotate_durationTime = "UIView_Rotate_durationTime";
static char *UIView_Rotate_delayTime = "UIView_Rotate_delayTime";
static char *UIView_Rotate_isStopRotateAnimation = "UIView_Rotate_isStopRotateAnimation";

@dynamic rotateChangeAngle;
@dynamic currentAngle;
@dynamic durationTime;
@dynamic delayTime;
@dynamic isStopRotateAnimation;
//开始旋转动画
-(void)startRotateAnimation{
    @weakify(self)
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.currentAngle * (M_PI / 180.0f));
    [UIView animateWithDuration:self.durationTime
                          delay:self.delayTime
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        @strongify(self)
        self.transform = endAngle;
    } completion:^(BOOL finished) {
        @strongify(self)
        self.currentAngle += self.rotateChangeAngle;
        if (!self.isStopRotateAnimation) {
            [self startRotateAnimation];
        }
    }];
}
//停止旋转动画
-(void)stopRotateAnimation{
    self.isStopRotateAnimation = !self.isStopRotateAnimation;
}
#pragma mark —— @property(nonatomic,assign)CGFloat rotateChangeAngle;
-(CGFloat)rotateChangeAngle{
    CGFloat RotateChangeAngle = [objc_getAssociatedObject(self, UIView_Rotate_rotateChangeAngle) floatValue];
    if (RotateChangeAngle == 0) {
        RotateChangeAngle = 20;
        objc_setAssociatedObject(self,
                                 UIView_Rotate_rotateChangeAngle,
                                 [NSNumber numberWithFloat:RotateChangeAngle],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return RotateChangeAngle;
}

-(void)setRotateChangeAngle:(CGFloat)rotateChangeAngle{
    objc_setAssociatedObject(self,
                             UIView_Rotate_rotateChangeAngle,
                             [NSNumber numberWithFloat:rotateChangeAngle],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat currentAngle;
-(CGFloat)currentAngle{
    return [objc_getAssociatedObject(self, UIView_Rotate_currentAngle) floatValue];
}

-(void)setCurrentAngle:(CGFloat)currentAngle{
    objc_setAssociatedObject(self,
                             UIView_Rotate_currentAngle,
                             [NSNumber numberWithFloat:currentAngle],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat durationTime;
-(CGFloat)durationTime{
    CGFloat DurationTime = [objc_getAssociatedObject(self, UIView_Rotate_durationTime) floatValue];
    if (DurationTime == 0) {
        DurationTime = 0.1;//缺省值
    }return DurationTime;
}

-(void)setDurationTime:(CGFloat)durationTime{
    objc_setAssociatedObject(self,
                             UIView_Rotate_durationTime,
                             [NSNumber numberWithFloat:durationTime],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat delayTime;
-(CGFloat)delayTime{
    CGFloat DelayTime = [objc_getAssociatedObject(self, UIView_Rotate_delayTime) floatValue];
    if (DelayTime == 0) {
        DelayTime = 0.01;//缺省值
    }return DelayTime;
}

-(void)setDelayTime:(CGFloat)delayTime{
    objc_setAssociatedObject(self,
                             UIView_Rotate_delayTime,
                             [NSNumber numberWithFloat:delayTime],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)BOOL isStopRotateAnimation;
-(BOOL)isStopRotateAnimation{
    return [objc_getAssociatedObject(self, UIView_Rotate_isStopRotateAnimation) boolValue];
}

-(void)setIsStopRotateAnimation:(BOOL)isStopRotateAnimation{
    objc_setAssociatedObject(self,
                             UIView_Rotate_isStopRotateAnimation,
                             [NSNumber numberWithBool:isStopRotateAnimation],
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
