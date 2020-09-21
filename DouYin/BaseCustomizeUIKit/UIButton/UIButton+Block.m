#import "UIButton+Block.h"
#import <objc/runtime.h>

@implementation UIButton (Block)

static char ActionTag;
/**
 *  button 添加点击事件 默认点击方式UIControlEventTouchUpInside
 */
- (void)addAction:(ButtonBlock)block {
    objc_setAssociatedObject(self,
                             &ActionTag,
                             block,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(action:)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)addActionAutoImage:(ButtonBlock)block{
     objc_setAssociatedObject(self,
                              &ActionTag,
                              block,
                              OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(actionAuto:)
   forControlEvents:UIControlEventTouchDown];
}

- (void)addActionAutoImageWithPI:(ButtonBlock)block{
     objc_setAssociatedObject(self,
                              &ActionTag,
                              block,
                              OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(actionAutoPI:)
   forControlEvents:UIControlEventTouchDown];
}
/**
 *  button 添加事件
 *  @param controlEvents 点击的方式
 */
- (void)addAction:(ButtonBlock)block
 forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self,
                             &ActionTag,
                             block,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(action:)
   forControlEvents:controlEvents];
}

- (void)actionAuto:(UIButton *)sender {
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        
#pragma mark —— 下面是让 button.imageView 旋转
        [UIView beginAnimations:@"rotate" context:nil];
        [UIView setAnimationDuration:0.25];
        if (CGAffineTransformEqualToTransform(sender.imageView.transform, CGAffineTransformIdentity)) {
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            sender.imageView.transform = CGAffineTransformIdentity;
        }
        [UIView commitAnimations];
        blockAction(self);
    }
}

- (void)actionAutoPI:(UIButton *)sender {
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        
#pragma mark —— 下面是让 button.imageView 旋转
//        [UIView beginAnimations:@"rotate" context:nil];
//        [UIView setAnimationDuration:0.25];
//        if (CGAffineTransformEqualToTransform(sender.imageView.transform, CGAffineTransformIdentity)) {
//            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//        }else{
////            sender.imageView.transform = CGAffineTransformIdentity;
////             sender.imageView.transform = CGAffineTransformMakeRotation(-M_PI);
//        }
//        [UIView commitAnimations];
//        [UIView animateWithDuration:0.25 animations:^{
//            if (CGAffineTransformEqualToTransform(sender.imageView.transform, CGAffineTransformIdentity)) {
//                sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//            }else{
//                sender.imageView.transform = CGAffineTransformIdentity;
//            }
//        }];
        blockAction(self);
    }
}
/**
 *  button 事件的响应方法
 */
- (void)action:(id)sender {
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, &ActionTag);
    if (blockAction) {
        blockAction(self);
    }
}

@end
