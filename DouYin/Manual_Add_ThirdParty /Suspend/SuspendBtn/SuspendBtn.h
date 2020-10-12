//
//  suspendBtn.h
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspendBtn : UIButton

@property(nonatomic,assign)BOOL isAllowDrag;//是否允许托拽手势

@end

NS_ASSUME_NONNULL_END
/**
使用方法：
 如果是View：在需要作用的UIView的子类
 
 @property(nonatomic,weak)UIViewController *vcer;//这个属性掌管悬浮效果，具体实现见  @interface UIView (SuspendView)
 -(void)drawRect:(CGRect)rect{
     [super drawRect:rect];
     if (self.isSuspend) {
         //开启悬浮效果
         self.vc = self.vcer;//外界传进来的，父承接的VC
         self.panRcognize.enabled = YES;
     }else{
         self.vc = nil;
     }
 }
 
 如果是ViewController
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
