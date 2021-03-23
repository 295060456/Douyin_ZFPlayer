//
//  UITextView+Extend.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Extend)
/// 过滤删除最科学的做法,获得当前TextView当前时刻的具体文本值
-(NSString *)getCurrentTextViewValueByReplacementText:(NSString *)replacementString;

@end

NS_ASSUME_NONNULL_END
