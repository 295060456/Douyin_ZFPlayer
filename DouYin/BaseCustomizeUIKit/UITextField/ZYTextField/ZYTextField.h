#import <UIKit/UIKit.h>
#import "CJTextField.h"

@interface ZYTextField : CJTextField

@property(nonatomic,assign)BOOL isInputting;//是否正在输入(键盘弹起中)

@property(nonatomic,strong)UIFont *ZYtextFont;//字体大小
@property(nonatomic,strong)UIColor *ZYtextColor;//文本颜色
@property(nonatomic,strong)UIColor *ZYtintColor;//光标颜色
//
@property(nonatomic,strong)UIColor *ZYplaceholderLabelTextColor_1;//占位文字颜色 失去焦点
@property(nonatomic,strong)UIColor *ZYplaceholderLabelTextColor_2;//占位文字颜色 聚焦状态
@property(nonatomic,strong)UIFont *ZYplaceholderLabelFont_1;//占位文字字体 失去焦点
@property(nonatomic,strong)UIFont *ZYplaceholderLabelFont_2;//占位文字字体 聚焦状态

@property(nonatomic,assign)CGFloat offset;
@property(nonatomic,assign)CGFloat leftViewOffsetX;
@property(nonatomic,assign)CGFloat rightViewOffsetX;

@property(nonatomic,assign)CGFloat ZYTextFieldCornerRadius;
@property(nonatomic,assign)CGFloat ZYTextFieldBorderWidth;
@property(nonatomic,assign)UIColor *ZYTextFieldBorderColor;
@property(nonatomic,assign)BOOL ZYTextFieldMasksToBounds;

@property(nonatomic,assign)BOOL __block isEditting;//当前TF是否正在发起攻击（正在编辑之中）

@end
