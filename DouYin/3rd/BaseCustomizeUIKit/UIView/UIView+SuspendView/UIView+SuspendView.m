//
//  UIView+SuspendView.m
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+SuspendView.h"
#import <objc/runtime.h>

@implementation UIView (SuspendView)

static char *UIView_SuspendView_vc = "UIView_SuspendView_vc";
static char *UIView_SuspendView_panRcognize = "UIView_SuspendView_panRcognize";

@dynamic vc;
@dynamic panRcognize;

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer{
    //移动状态
    UIGestureRecognizerState recState = recognizer.state;
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint translation = [recognizer translationInView:self.vc.navigationController.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                                 recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:{
            CGPoint stopPoint = CGPointMake(0, SCREEN_HEIGHT / 2.0);
            if (recognizer.view.center.x < SCREEN_WIDTH / 2.0) {
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //左上
                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x,
                                                self.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.width/2.0,
                                                recognizer.view.center.y);
                    }
                }else{
                    //左下
                    if (recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x,
                                                SCREEN_HEIGHT - self.width/2.0);
                    }else{
                        stopPoint = CGPointMake(self.width / 2.0,
                                                recognizer.view.center.y);
                    }
                }
            }else{
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //右上
                    if (SCREEN_WIDTH - recognizer.view.center.x  >= recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x,
                                                self.width/2.0);
                    }else{
                        stopPoint = CGPointMake(SCREEN_WIDTH - self.width/2.0,
                                                recognizer.view.center.y);
                    }
                }else{
                    //右下
                    if (SCREEN_WIDTH - recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                        stopPoint = CGPointMake(recognizer.view.center.x,
                                                SCREEN_HEIGHT - self.width/2.0);
                    }else{
                        stopPoint = CGPointMake(SCREEN_WIDTH - self.width/2.0,
                                                recognizer.view.center.y);
                    }
                }
            }
            //如果按钮超出屏幕边缘
            if (stopPoint.y + self.width + 40 >= SCREEN_HEIGHT) {
                stopPoint = CGPointMake(stopPoint.x, SCREEN_HEIGHT - self.width / 2.0 - 49);
                NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
            }
            if (stopPoint.x - self.width / 2.0 <= 0) {
                stopPoint = CGPointMake(self.width / 2.0, stopPoint.y);
            }
            if (stopPoint.x + self.width / 2.0 >= SCREEN_WIDTH) {
                stopPoint = CGPointMake(SCREEN_WIDTH - self.width/2.0, stopPoint.y);
            }
            if (stopPoint.y - self.width / 2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.width/2.0);
            }
  
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0)
                        inView:self.vc.view];
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,weak)UIViewController *vc;
-(UIViewController *)vc{
    UIViewController *VC = objc_getAssociatedObject(self, UIView_SuspendView_vc);
    if (!VC) {
        NSLog(@"VC 不能为空");
    }return VC;
}

-(void)setVc:(UIViewController *)vc{
    objc_setAssociatedObject(self,
                             UIView_SuspendView_vc,
                             vc,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIPanGestureRecognizer *panRcognize;
-(UIPanGestureRecognizer *)panRcognize{
    UIPanGestureRecognizer *PanRcognize = objc_getAssociatedObject(self, UIView_SuspendView_panRcognize);
    if (!PanRcognize) {
        PanRcognize = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(handlePanGesture:)];
        
        [PanRcognize setMinimumNumberOfTouches:1];
        [PanRcognize delaysTouchesEnded];
        [PanRcognize cancelsTouchesInView];
        [self addGestureRecognizer:PanRcognize];
        
        objc_setAssociatedObject(self,
                                 UIView_SuspendView_panRcognize,
                                 PanRcognize,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PanRcognize;
}

-(void)setPanRcognize:(UIPanGestureRecognizer *)panRcognize{
    objc_setAssociatedObject(self,
                             UIView_SuspendView_panRcognize,
                             panRcognize,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
