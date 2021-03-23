//
//  UITextView+Extend.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/16.
//

#import "UITextView+Extend.h"

@implementation UITextView (Extend)
/// 过滤删除最科学的做法,获得当前TextView当前时刻的具体文本值
-(NSString *)getCurrentTextViewValueByReplacementText:(NSString *)replacementString{
    if (self.text.length >= 1) {
        return [replacementString isEqualToString:@""] ? [self.text substringToIndex:(self.text.length - 1)] : [self.text stringByAppendingString:replacementString];
    }else{
        return replacementString;
    }
}

@end
