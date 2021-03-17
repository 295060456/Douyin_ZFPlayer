//
//  UITextField+Extend.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "UITextField+Extend.h"
#import <objc/runtime.h>

@implementation UITextField (Extend)

static char *UITextField_Extend_customSysClearBtn = "UITextField_Extend_customSysClearBtn";
@dynamic customSysClearBtn;

-(NSString *)getCurrentTextFieldValueByReplacementString:(NSString *)replacementString{
    NSLog(@"textField.text = %@",self.text);
    NSLog(@"string = %@",replacementString);
    
#warning 过滤删除最科学的做法
    NSString *resString = nil;
    //textField.text 有值 && string无值 ————> 删除操作
    if (![NSString isNullString:self.text] && [NSString isNullString:replacementString]) {
        
        if (self.text.length == 1) {
            if ([replacementString isEqualToString:@""]) {
                resString = @"";
            }else if ([replacementString isEqualToString:@" "]){
                resString = self.text;
            }else{}
        }else{
            resString = [self.text substringToIndex:(self.text.length - 1)];//去掉最后一个
        }
    }
    //textField.text 无值 && string有值 ————> 首字符输入
    if ([NSString isNullString:self.text] && ![NSString isNullString:replacementString]) {
        resString = replacementString;
    }
    //textField.text 有值 && string有值 ————> 非首字符输入
    if (![NSString isNullString:self.text] && ![NSString isNullString:replacementString]) {
        resString = [self.text stringByAppendingString:replacementString];
    }

    NSLog(@"resString = %@",resString);
    return resString;
}
/// 自定义系统的清除按钮
- (void)modifyClearButtonWithImage:(UIImage *)image{
    [self.customSysClearBtn setImage:image
                            forState:UIControlStateNormal];
    self.rightView = self.customSysClearBtn;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}
#pragma mark SET | GET
-(UIButton *)customSysClearBtn{
    UIButton *CustomSysClearBtn = objc_getAssociatedObject(self, UITextField_Extend_customSysClearBtn);
    if (!CustomSysClearBtn) {
        CustomSysClearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CustomSysClearBtn.adjustsImageWhenHighlighted = NO;
        [CustomSysClearBtn setFrame:CGRectMake(0.0f,
                                               0.0f,
                                               15.0f,
                                               15.0f)];
        @weakify(self)
        [[CustomSysClearBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.text = @"";
        }];
        objc_setAssociatedObject(self,
                                 UITextField_Extend_customSysClearBtn,
                                 CustomSysClearBtn,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return CustomSysClearBtn;
}

-(void)setCustomSysClearBtn:(UIButton *)customSysClearBtn{
    objc_setAssociatedObject(self,
                             UITextField_Extend_customSysClearBtn,
                             customSysClearBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
