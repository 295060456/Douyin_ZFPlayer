//
//  UIView+Rotate.h
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 旋转
@interface UIView (Rotate)

@property(nonatomic,assign)CGFloat rotateChangeAngle;
@property(nonatomic,assign)__block CGFloat currentAngle;
@property(nonatomic,assign)CGFloat durationTime;
@property(nonatomic,assign)CGFloat delayTime;
@property(nonatomic,assign)BOOL isStopRotateAnimation;//默认值为NO（一直旋转）

-(void)startRotateAnimation;//开始旋转动画
-(void)stopRotateAnimation;//停止旋转动画

@end

NS_ASSUME_NONNULL_END

/**
 使用方法：
 #pragma mark —— lazyLoad
 -(SuspendBtn *)suspendBtn{
     if (!_suspendBtn) {
         _suspendBtn = SuspendBtn.new;
         [_suspendBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                          @"Others",
                                          nil,
                                          @"旋转")
                      forState:UIControlStateNormal];
         _suspendBtn.panRcognize.enabled = YES;//悬浮效果必须要的参数
         @weakify(self)
         self.view.vc = weak_self;
         [self.view addSubview:_suspendBtn];
         _suspendBtn.frame = CGRectMake(80, 100, 50, 50);
         [UIView cornerCutToCircleWithView:_suspendBtn AndCornerRadius:25];
         [[_suspendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
             @strongify(self)
             [self->_suspendBtn startRotateAnimation];
             
         }];
     }return _suspendBtn;
 }

 */
