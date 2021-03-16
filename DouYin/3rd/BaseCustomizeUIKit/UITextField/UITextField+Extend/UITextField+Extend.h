//
//  UITextField+Extend.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Extras.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extend)

@property(nonatomic,strong)UIButton *customSysClearBtn;
/// 自定义系统的清除按钮
-(void)modifyClearButtonWithImage:(UIImage *)image;
/// 过滤删除最科学的做法,获得当前TextField当前时刻的具体文本值
-(NSString *)getCurrentTextFieldValueByReplacementString:(NSString *)replacementString;

@end

NS_ASSUME_NONNULL_END
