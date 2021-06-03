//
//  UITextView+IndicateWordLimit.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/25.
//

#import <UIKit/UIKit.h>

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#import "UIView+Measure.h"

NS_ASSUME_NONNULL_BEGIN
/// 用于实现右下角的字符数量监控
@interface UITextView (IndicateWordLimit)

@property(nonatomic,strong)UILabel *indicateWordLimitLab;
@property(nonatomic,assign)NSInteger currentWordNum;//当前输入的字符数
@property(nonatomic,assign)NSInteger wordLimitNum;//字符输入上限
@property(nonatomic,assign)CGFloat offsetX;
@property(nonatomic,assign)CGFloat offsetY;

@end

NS_ASSUME_NONNULL_END

/**
 示例代码：
 
 说明：
 1、用SZTextView替代UITextView；
 2、indicateWordLimitLab要依赖于textView的frame，如果用Masonry则需要刷新UI得出textView以后才可以用

 -(SZTextView *)textView{
     if (!_textView) {
         _textView = SZTextView.new;
         _textView.delegate = self;
         _textView.placeholder = @"在这里畅所欲言，留下您的宝贵意见吧！";
         
         _textView.placeholderTextColor = RGB_COLOR(132, 134, 140);
         _textView.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
         [self.view addSubview:_textView];
         [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.equalTo(self.view);
             make.top.equalTo(self.chooseFeedbackTypeBtn.mas_bottom).offset(KHeight(8));
             make.size.mas_equalTo(CGSizeMake(KWidth(343), KHeight(150)));
         }];
         [self.view layoutIfNeeded];
         _textView.indicateWordLimitLab.alpha = 1;
         [UIView cornerCutToCircleWithView:_textView andCornerRadius:6];
     }return _textView;
 }
 
与之相对应的协议方法：
 - (BOOL)textView:(UITextView *)textView
 shouldChangeTextInRange:(NSRange)range
  replacementText:(NSString *)text{
     
     NSLog(@"textField.text = %@",textView.text);
     NSLog(@"string = %@",text);
     
     
 #warning 过滤删除最科学的做法
     
     NSString *resString = nil;
     //textField.text 有值 && string无值 ————> 删除操作
     if (![NSString isNullString:textView.text] && [NSString isNullString:text]) {
         
         if (textView.text.length == 1) {
             resString = @"";
         }else{
             resString = [textView.text substringToIndex:(textView.text.length - 1)];//去掉最后一个
         }
     }
     //textField.text 无值 && string有值 ————> 首字符输入
     if ([NSString isNullString:textView.text] && ![NSString isNullString:text]) {
         resString = text;
     }
     //textField.text 有值 && string有值 ————> 非首字符输入
     if (![NSString isNullString:textView.text] && ![NSString isNullString:text]) {
         resString = [textView.text stringByAppendingString:text];
     }

     NSLog(@"SSSresString = %@",resString);
     self.textView.currentWordNum = resString.length;//关键代码
     if ([NSString isNullString:resString]) {
         [self.submitBtn setBackgroundImage:KIMG(@"填写邀请码——不可提交") forState:UIControlStateNormal];
         self.submitBtn.userInteractionEnabled = NO;
     }else{
         [self.submitBtn setBackgroundImage:KIMG(@"填写邀请码——可提交") forState:UIControlStateNormal];
         self.submitBtn.userInteractionEnabled = YES;
     }return YES;
 }
 
 */
