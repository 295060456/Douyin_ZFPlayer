//
//  CJTextField.h
//  Feidegou
//
//  Created by Kite on 2019/11/24.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//
//https://www.jianshu.com/p/b5100f498f12

#import <UIKit/UIKit.h>
#import "UITextField+Extend.h"

NS_ASSUME_NONNULL_BEGIN
//iOS监听键盘删除事件
@class CJTextField;

@protocol CJTextFieldDeleteDelegate <NSObject>

-(void)cjTextFieldDeleteBackward:(CJTextField *)textField;

@end

@interface CJTextField : UITextField

@property(nonatomic,assign)BOOL isShowSecurityMode;
@property(nonatomic,weak)id <CJTextFieldDeleteDelegate>cj_delegate;
///输入的和某个预设定值不一致的时候，抖动动画
-(void)isValidate:(NSString *)validate;
///输入的为空，抖动动画
-(void)isEmptyText;

@end

NS_ASSUME_NONNULL_END
