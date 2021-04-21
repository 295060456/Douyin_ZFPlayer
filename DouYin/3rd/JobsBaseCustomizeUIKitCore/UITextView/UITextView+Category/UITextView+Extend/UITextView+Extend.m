//
//  UITextView+Extend.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/16.
//

#import "UITextView+Extend.h"

@implementation UITextView (Extend)

static char *UITextView_Extend_replacementText = "UITextView_Extend_replacementText";
@dynamic replacementText;

static char *UITextView_Extend_resStr = "UITextView_Extend_resStr";
@dynamic resStr;
/*
    如果执行的是删除动作，那么textView.text 去掉最后一个字符向外输出
    否则textView.text + replacementString进行输出
 */
-(NSString *)getCurrentTextViewValueByReplacementText:(NSString *)replacementString{
    if (self.text.length >= 1) {
        return [replacementString isEqualToString:@""] ? [self.text substringToIndex:(self.text.length - 1)] : [self.text stringByAppendingString:replacementString];
    }else{
        return replacementString;
    }
}
/*
    一般用于终值部分，对应协议方法:textViewDidChange
    因为在- (void)textViewDidChange:(UITextView *)textView里面的textView.text = textView确定值 + 输入法拼音模式下的占位符值
    我们在某些业务场景下需要对此进行区分，也就是只锚点textView的确定值
 /// @param valueBlock 回调TextView的确定值，以表明占位符有值
 /// @param invalidBlock 回调占位符无值的状态
 */
-(void)markedTextValue:(MKDataBlock)valueBlock
          invalidBlock:(NoResultBlock)invalidBlock{
    NSString *placeholderValue = [self textInRange:self.markedTextRange];
    if (placeholderValue.length) {//占位符有值
        NSString *str = [self.text stringByReplacingOccurrencesOfString:placeholderValue
                                                             withString:@""];
        if (valueBlock) {
            valueBlock(str);// 回调TextView的确定值
        }
    }else{//占位符无值
        if (invalidBlock) {
            invalidBlock();
        }
    }
}
/*
    一般用于- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
    对提行、删除【包含删除Emoji表情】、正向输入【包含汉字拼音输入法中的占位符】操作进行区分
 */
-(BOOL)replacementText:(NSString *)replacementText
     beginNewLineBlock:(MKDataBlock)beginNewLineBlock
              delBlock:(MKDataBlock)delBlock
      normalInputBlock:(MKDataBlock)normalInputBlock{
    self.replacementText = replacementText;
    if ([replacementText isEqualToString:@"\n"]) {//提行
        if (beginNewLineBlock) {
            beginNewLineBlock(self.text);
        }return NO;
    }else if([replacementText isEqualToString:@""]){//删除
        /*
             删除操作是系统接收@“”作为指令内部进行删除操作
             获取需要操作的字符，最后2位，如果是emoji则删除2个字符，否则删除一个字符
             截取 textView.text 最后2位
         */
        NSString *res = @"";
        NSLog(@"MMM = %@",self.text);
        if (self.text.length >= 2) {
            // 这里的emoji判断有点问题，不识别新版本系统的emoji，以前的旧的emoji是可以识别的，我已经给apple提了单让他们给我们写一个api
            if ([[self.text substringFromIndex:self.text.length - 2] validateContainsEmoji]) {
                res = [self.text substringWithRange:NSMakeRange(0, self.text.length - 2)];
                NSLog(@"res = %@",res);
            }else{
                res = [self.text substringWithRange:NSMakeRange(0, self.text.length - 1)];
                NSLog(@"res = %@",res);
            }
        }else if (self.text.length == 1){
            res = [self.text substringWithRange:NSMakeRange(0, self.text.length - 1)];
            NSLog(@"res = %@",res);
        }else{
            res = @"";
            NSLog(@"res = %@",res);
        }
        self.currentWordNum = res.length;
        NSLog(@"SSS = %ld",self.currentWordNum);
        if (delBlock) {
            delBlock(res);
        }return YES;
    }else{//正向输入
        if ([replacementText isAllLetterCharacter]) {//还在占位符拼音阶段
            if ([self textInRange:self.markedTextRange].length) {
                if (normalInputBlock) {
                    normalInputBlock([self.text stringByAppendingString:replacementText]);
                }
            }else{
                NSString *res = @"";
                if (replacementText.length == 1) {//单字母输入
                    res = [self.text stringByAppendingString:replacementText];
                }else{//按下确定键
                    res = replacementText;
                }
                
                self.currentWordNum = res.length;

                if (normalInputBlock) {
                    normalInputBlock(res);
                }
//                NSLog(@"QQQQQ = %ld",self.currentWordNum);
                
                if (self.currentWordNum - 2 >= self.wordLimitNum) {
                    self.currentWordNum = self.wordLimitNum;
                }
                NSLog(@"QQQQQ = %ld",self.currentWordNum);
            }
        }else{//最终确定的中文
            NSString *res = [[self.text stringByReplacingOccurrencesOfString:[self textInRange:self.markedTextRange]
                                                                  withString:@""] stringByAppendingString:replacementText];
            self.currentWordNum = res.length;
            /// 截断，最新输入的截取字符来满足textView到顶抵满
            if (self.currentWordNum + 1 > self.wordLimitNum) {
                self.text = [res substringWithRange:NSMakeRange(0, self.wordLimitNum)];
                self.currentWordNum = self.text.length;
            }
            self.resStr = res;
            if (normalInputBlock) {
                normalInputBlock(res);
            }
        }
        return self.currentWordNum < self.wordLimitNum;
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)NSString *replacementText;
-(NSString *)replacementText{
    return objc_getAssociatedObject(self, UITextView_Extend_replacementText);
}

-(void)setReplacementText:(NSString *)replacementText{
    objc_setAssociatedObject(self,
                             UITextView_Extend_replacementText,
                             replacementText,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *resStr;
-(NSString *)resStr{
    return objc_getAssociatedObject(self, UITextView_Extend_resStr);
}

-(void)setResStr:(NSString *)resStr{
    objc_setAssociatedObject(self,
                             UITextView_Extend_resStr,
                             resStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
