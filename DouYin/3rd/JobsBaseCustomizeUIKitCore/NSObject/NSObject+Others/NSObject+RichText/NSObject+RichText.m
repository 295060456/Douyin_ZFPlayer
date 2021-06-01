//
//  UILabel+RichText.m
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import "NSObject+RichText.h"

@implementation RichTextConfig

#pragma mark —— default
-(NSMutableParagraphStyle *)paragraphStyle{
    if (!_paragraphStyle) {
        _paragraphStyle = NSMutableParagraphStyle.new;
        //行间距
        _paragraphStyle.lineSpacing = 10;
        //段落间距
        _paragraphStyle.paragraphSpacing = 20;
        //对齐方式
        _paragraphStyle.alignment = NSTextAlignmentLeft;
        //指定段落开始的缩进像素
        _paragraphStyle.firstLineHeadIndent = 30;
        //调整全部文字的缩进像素
        _paragraphStyle.headIndent = 10;
    }return _paragraphStyle;
}

-(NSString *)urlStr{
    if (!_urlStr) {
        _urlStr = @"www.google.com";
    }return _urlStr;
}

@end

@implementation NSObject (RichText)

+(NSAttributedString *)richTextWithDataConfigMutArr:(NSArray <RichTextConfig *>*_Nonnull)richTextDataConfigMutArr{
    
    NSString *resultString = @"";
    //先拼接字符串
    for (RichTextConfig *config in richTextDataConfigMutArr) {
        if (config.targetString) {
            resultString = [resultString stringByAppendingString:config.targetString];
            NSLog(@"resultString = %@",resultString);
        }
    }
    
    NSLog(@"resultString = %@",resultString);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:resultString];

    // 因为NSArray <RichTextConfig *>* 是动态。进方法以后为固定，那么以此计算真正的range
    NSUInteger currentFrontLocation = 0;//当前位置（前）
    for (RichTextConfig *config in richTextDataConfigMutArr) {
        config.range = NSMakeRange(currentFrontLocation, config.targetString.length);
        currentFrontLocation  += config.targetString.length;;
    }
    
    for (RichTextConfig *config in richTextDataConfigMutArr){
        //添加字体 & 设置作用域
        if (config.font) {
            [attrString addAttribute:NSFontAttributeName
                               value:config.font
                               range:config.range];
        }
        //添加文字颜色 & 设置作用域
        if (config.cor) {
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:config.cor
                               range:config.range];
        }
        //添加下划线 & 设置作用域
        [attrString addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:config.underlineStyle]
                        range:config.range];
        //添加段落样式 & 设置作用域
        if (config.paragraphStyle) {
            [attrString addAttribute:NSParagraphStyleAttributeName
                               value:config.paragraphStyle
                               range:config.range];
        }
        //添加链接 & 设置作用域
//        [attrString addAttribute:NSParagraphStyleAttributeName
//                           value:[NSURL URLWithString:config.urlStr]
//                           range:config.range];
    }return attrString;
}

@end
