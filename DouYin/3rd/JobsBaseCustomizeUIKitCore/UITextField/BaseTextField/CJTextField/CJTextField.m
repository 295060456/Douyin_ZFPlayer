//
//  CJTextField.m
//  Feidegou
//
//  Created by Kite on 2019/11/24.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

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
