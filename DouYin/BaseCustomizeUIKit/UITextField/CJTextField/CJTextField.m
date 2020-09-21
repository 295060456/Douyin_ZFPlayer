//
//  CJTextField.m
//  Feidegou
//
//  Created by Kite on 2019/11/24.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

///输入的和某个预设定值不一致的时候，抖动动画
- (void)isValidate:(NSString *)validate{
    if (![self.text isEqualToString:validate]) {
        [self shakeAnimationForView:self];
    }
}
///输入的为空，抖动动画
-(void)isEmptyText{
    if ([NSString isNullString:self.text]) {
        [self shakeAnimationForView:self];
    }
}

-(void)shakeAnimationForView:(UIView *)view{
    CALayer *lay_lb = [view layer];
    CGPoint pos_lb = [lay_lb position];
    CGPoint y = CGPointMake(pos_lb.x-10, pos_lb.y);
    CGPoint x = CGPointMake(pos_lb.x+10, pos_lb.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lay_lb addAnimation:animation forKey:nil];
}

- (void)deleteBackward{
    [super deleteBackward];
    if ([self.cj_delegate respondsToSelector:@selector(cjTextFieldDeleteBackward:)]) {
        [self.cj_delegate cjTextFieldDeleteBackward:self];
    }
}

- (BOOL)keyboardInputShouldDelete:(UITextField *)textField{
    BOOL shouldDelete = YES;
    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
      
        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }
  
    if (![textField.text length] &&
        ([[[UIDevice currentDevice] systemVersion] intValue] == 8) &&
        ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3f)) {
        [self deleteBackward];
    }return shouldDelete;
}

@end
