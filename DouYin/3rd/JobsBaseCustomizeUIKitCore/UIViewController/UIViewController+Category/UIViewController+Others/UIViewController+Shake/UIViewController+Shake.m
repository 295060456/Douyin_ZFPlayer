//
//  UIViewController+Shake.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIViewController+Shake.h"
#import "NSObject+Shake.h"
#import <objc/runtime.h>

@implementation UIViewController (Shake)

static char *UIViewController_motionManager = "UIViewController_motionManager";
@dynamic motionManager;

static char *UIViewController_ShakeBegan = "UIViewController_ShakeBegan";
@dynamic UIViewControllerShakeBeganBlock;

static char *UIViewController_ShakeCancel = "UIViewController_ShakeCancel";
@dynamic UIViewControllerShakeCancelBlock;

static char *UIViewController_ShakeEnd = "UIViewController_ShakeEnd";
@dynamic UIViewControllerShakeEndBlock;

-(void)VC_ShakeBegan:(MKDataBlock)UIViewControllerShakeBeganBlock{
    self.UIViewControllerShakeBeganBlock = UIViewControllerShakeBeganBlock;
}

-(void)VC_ShakeCancel:(MKDataBlock)UIViewControllerShakeCancelBlock{
    self.UIViewControllerShakeCancelBlock = UIViewControllerShakeCancelBlock;
}

-(void)VC_ShakeEnd:(MKDataBlock)UIViewControllerShakeEndBlock{
    self.UIViewControllerShakeEndBlock = UIViewControllerShakeEndBlock;
}

#pragma mark —— 系统方法
-(void)invokeWhenViewDidLoadUsingSysFunc{
    //设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
}
/// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {// 判断是否是摇动事件
        if (self.UIViewControllerShakeBeganBlock) {
            self.UIViewControllerShakeBeganBlock(self);
        }
    }
}
/// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {
    // 判断是否是摇动事件
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"摇一摇结束~~~~~");
        //摇动结束添加事件
        if (self.UIViewControllerShakeEndBlock) {
            self.UIViewControllerShakeEndBlock(self);
        }
    }
}
/// 摇一摇取消摇动
- (void)motionCancelled:(UIEventSubtype)motion
              withEvent:(UIEvent *)event {
    if (self.UIViewControllerShakeCancelBlock) {
        self.UIViewControllerShakeCancelBlock(self);
    }
}
#pragma mark —— 加速仪
-(void)invokeWhenViewDidAppearUsingCMMotionManager{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

-(void)startAccelerometer{
    //以push的方式更新并在block中接收加速度
    @weakify(self)
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                             withHandler:^(CMAccelerometerData *accelerometerData,
                                                           NSError *error) {
        @strongify(self)
        [self outputAccelertionData:accelerometerData.acceleration];
        if (error) {
            NSLog(@"motion error:%@",error);
        }
    }];
}

-(void)stopAccelerometerWhenViewDidDisappear{
    [self.motionManager stopAccelerometerUpdates];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}
//对应上面的通知中心回调的消息接收
-(void)receiveNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]){
        [self.motionManager stopAccelerometerUpdates];
    }else{
        [self startAccelerometer];
    }
}

-(void)outputAccelertionData:(CMAcceleration)acceleration{
    //综合3个方向的加速度
    double accelerameter = sqrt(pow( acceleration.x , 2 ) + pow( acceleration.y , 2 ) + pow( acceleration.z , 2));
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if (accelerameter > 1.5f) {
        //立即停止更新加速仪（很重要！）
        [self.motionManager stopAccelerometerUpdates];
        @weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            //设置开始摇晃时震动
            [NSObject shake];
            //加载动画
            if (self.UIViewControllerShakeBeganBlock) {
                self.UIViewControllerShakeBeganBlock(self);
            }
        });
    }
}
#pragma mark —— @property(nonatomic,strong)CMMotionManager *motionManager;
-(CMMotionManager *)motionManager{
    CMMotionManager *MotionManager = objc_getAssociatedObject(self, UIViewController_motionManager);
    if (!MotionManager) {
        MotionManager = CMMotionManager.new;
        MotionManager.accelerometerUpdateInterval = 0.5;//加速仪更新频率，以秒为单位
        objc_setAssociatedObject(self,
                                 UIViewController_motionManager,
                                 MotionManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MotionManager;
}

-(void)setMotionManager:(CMMotionManager *)motionManager{
    objc_setAssociatedObject(self,
                             UIViewController_motionManager,
                             motionManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock UIViewControllerShakeBeganBlock;
-(MKDataBlock)UIViewControllerShakeBeganBlock{
    return objc_getAssociatedObject(self, UIViewController_ShakeBegan);
}

-(void)setUIViewControllerShakeBeganBlock:(MKDataBlock)UIViewControllerShakeBeganBlock{
    objc_setAssociatedObject(self,
                             UIViewController_ShakeBegan,
                             UIViewControllerShakeBeganBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock UIViewControllerShakeCancelBlock;
-(MKDataBlock)UIViewControllerShakeCancelBlock{
    return objc_getAssociatedObject(self, UIViewController_ShakeCancel);
}

-(void)setUIViewControllerShakeCancelBlock:(MKDataBlock)UIViewControllerShakeCancelBlock{
    objc_setAssociatedObject(self,
                             UIViewController_ShakeCancel,
                             UIViewControllerShakeCancelBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock UIViewControllerShakeEndBlock;
-(MKDataBlock)UIViewControllerShakeEndBlock{
    return objc_getAssociatedObject(self, UIViewController_ShakeEnd);
}

-(void)setUIViewControllerShakeEndBlock:(MKDataBlock)UIViewControllerShakeEndBlock{
    objc_setAssociatedObject(self,
                             UIViewController_ShakeEnd,
                             UIViewControllerShakeEndBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
