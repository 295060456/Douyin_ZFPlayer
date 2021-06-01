#import <UIKit/UIKit.h>
#import "NSObject+RichText.h"
#import "UITextField+Extend.h"
#import "LoadingImage.h"

typedef NS_ENUM(NSUInteger, PlaceHolderAlignment){
    PlaceHolderAlignmentLeft,// 左对齐 默认
    PlaceHolderAlignmentCenter,// 居中对齐
    PlaceHolderAlignmentRight// 右对齐
};

@interface ZYTextField : UITextField

@property(nonatomic,assign)CGFloat TFRiseHeight;// 键盘在此手机上的最高弹起，区别于全面屏结合非全面屏，有一个安全区域34

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
@property(nonatomic,assign)PlaceHolderAlignment placeHolderAlignment;//PlaceHolder的位置
@property(nonatomic,assign)CGFloat placeHolderOffset;//左/右/居中 对齐的时候的偏移量 传正值

@property(nonatomic,assign)CGFloat ZYTextFieldCornerRadius;
@property(nonatomic,assign)CGFloat ZYTextFieldBorderWidth;
@property(nonatomic,assign)UIColor *ZYTextFieldBorderColor;
@property(nonatomic,assign)BOOL ZYTextFieldMasksToBounds;

@property(nonatomic,assign)BOOL isShowMenu;//是否显示菜单 默认不显示

///输入的和某个预设定值不一致的时候，抖动动画
- (void)isValidate:(NSString *)validate;
///输入的为空，抖动动画
-(void)isEmptyText;

@end

/*

//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    NSLog(@"textField.text = %@",textField.text);
    NSLog(@"string = %@",string);
    
#warning 过滤删除最科学的做法
    
    NSString *resString = nil;
    //textField.text 有值 && string无值 ————> 删除操作
    if (![NSString isNullString:textField.text] && [NSString isNullString:string]) {
        
        if (textField.text.length == 1) {
            resString = @"";
        }else{
            resString = [textField.text substringToIndex:(textField.text.length - 1)];//去掉最后一个
        }
    }
    //textField.text 无值 && string有值 ————> 首字符输入
    if ([NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = string;
    }
    //textField.text 有值 && string有值 ————> 非首字符输入
    if (![NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = [textField.text stringByAppendingString:string];
    }

    NSLog(@"resString = %@",resString);
    return YES;
}

 */

