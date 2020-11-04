//
//  UILabel+RichText.m
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import "UILabel+RichText.h"

@implementation RichLabelFontModel

@end

@implementation RichLabelTextCorModel

@end

@implementation RichLabelUnderlineModel

@end

@implementation RichLabelParagraphStyleModel

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

@end

@implementation RichLabelURLModel

#pragma mark —— default
-(NSString *)urlStr{
    if (!_urlStr) {
        _urlStr = @"www.google.com";
    }return _urlStr;
}

@end

@implementation UILabel (RichText)

-(void)makeRichTextWithDataStr:(NSString * _Nonnull)dataStr
                richLabelFonts:(NSArray <RichLabelFontModel *>* _Nullable)richLabelFonts
             richLabelTextCors:(NSArray <RichLabelTextCorModel *>* _Nullable)richLabelTextCors
           richLabelUnderlines:(NSArray <RichLabelUnderlineModel *>* _Nullable)richLabelUnderlines
      richLabelParagraphStyles:(NSArray <RichLabelParagraphStyleModel *>* _Nullable)richLabelParagraphStyles
                 richLabelURLs:(NSArray <RichLabelURLModel *>* _Nullable)richLabelURLs{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:dataStr];
    
    //添加字体 & 设置作用域
    for (RichLabelFontModel *richLabelFontModel in richLabelFonts) {
        [attrStr addAttribute:NSFontAttributeName
                        value:richLabelFontModel.font
                        range:richLabelFontModel.range];
    }
    //添加文字颜色 & 设置作用域
    for (RichLabelTextCorModel *richLabelTextCorModel in richLabelTextCors) {
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:richLabelTextCorModel.cor
                        range:richLabelTextCorModel.range];
    }
    //添加下划线 & 设置作用域
    for (RichLabelUnderlineModel *richLabelUnderlineModel in richLabelUnderlines) {
        [attrStr addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:richLabelUnderlineModel.underlineStyle]
                        range:richLabelUnderlineModel.range];
    }
    //添加段落样式 & 设置作用域
    for (RichLabelParagraphStyleModel *richLabelParagraphStyleModel in richLabelParagraphStyles) {
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:richLabelParagraphStyleModel.paragraphStyle
                        range:richLabelParagraphStyleModel.range];
    }
    //添加链接 & 设置作用域
    for (RichLabelURLModel *richLabelURLModel in richLabelURLs) {
        [attrStr addAttribute:NSParagraphStyleAttributeName
                        value:[NSURL URLWithString:richLabelURLModel.urlStr]
                        range:richLabelURLModel.range];
    }
    
    self.attributedText = attrStr;
}

@end
