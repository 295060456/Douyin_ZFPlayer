//
//  UITextView+Extend.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/16.
//

#import "UITextView+Extend.h"

@implementation UITextView (Extend)

-(NSString *)getCurrentTextViewValueByReplacementText:(NSString *)text{
    NSLog(@"textField.text = %@",self.text);
    NSLog(@"string = %@",text);
    
#warning 过滤删除最科学的做法
    NSString *resString = nil;
    //textField.text 有值 && string无值 ————> 删除操作
    if (![NSString isNullString:self.text] && [NSString isNullString:text]) {
        
        if (self.text.length == 1) {
            resString = @"";
        }else{
            resString = [self.text substringToIndex:(self.text.length - 1)];//去掉最后一个
        }
    }
    //textField.text 无值 && string有值 ————> 首字符输入
    if ([NSString isNullString:self.text] && ![NSString isNullString:text]) {
        resString = text;
    }
    //textField.text 有值 && string有值 ————> 非首字符输入
    if (![NSString isNullString:self.text] && ![NSString isNullString:text]) {
        resString = [self.text stringByAppendingString:text];
    }

    NSLog(@"resString = %@",resString);
    return resString;
}

@end
