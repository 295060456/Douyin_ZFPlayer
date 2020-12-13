//
//  UILabel+RichText.m
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import "NSObject+RichText.h"

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


@implementation RichLabelDataStringsModel

#pragma mark —— default
-(NSString *)dataString{
    if (!_dataString) {
        _dataString = @"";
    }return _dataString;
}

@end

@implementation NSObject (RichText)

+(NSAttributedString *)makeRichTextWithDataConfigMutArr:(NSArray <RichLabelDataStringsModel *>*_Nonnull)richTextDataConfigMutArr{
    
    NSString *resultString = @"";
    
    //先拼接字符串
    for (RichLabelDataStringsModel *model in richTextDataConfigMutArr) {
        if (model.dataString) {
            resultString = [resultString stringByAppendingString:model.dataString];
            NSLog(@"resultString = %@",resultString);
        }
    }
    
    NSLog(@"resultString = %@",resultString);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:resultString];
    
    for (int i = 0; i < richTextDataConfigMutArr.count; i++) {
        RichLabelDataStringsModel *richLabelDataStringsModel = (RichLabelDataStringsModel *)richTextDataConfigMutArr[i];
        
        //添加字体 & 设置作用域
        if (richLabelDataStringsModel.richLabelFontModel.font) {
            [attrString addAttribute:NSFontAttributeName
                               value:richLabelDataStringsModel.richLabelFontModel.font
                               range:richLabelDataStringsModel.richLabelFontModel.range];//NSMakeRange(0, 0)
        }
        //添加文字颜色 & 设置作用域
        if (richLabelDataStringsModel.richLabelTextCorModel.cor) {
            [attrString addAttribute:NSForegroundColorAttributeName
                               value:richLabelDataStringsModel.richLabelTextCorModel.cor
                               range:richLabelDataStringsModel.richLabelTextCorModel.range];
        }
        //添加下划线 & 设置作用域
        [attrString addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:richLabelDataStringsModel.richLabelUnderlineModel.underlineStyle]
                        range:richLabelDataStringsModel.richLabelUnderlineModel.range];
        //添加段落样式 & 设置作用域
        if (richLabelDataStringsModel.richLabelParagraphStyleModel.paragraphStyle) {
            [attrString addAttribute:NSParagraphStyleAttributeName
                               value:richLabelDataStringsModel.richLabelParagraphStyleModel.paragraphStyle
                               range:richLabelDataStringsModel.richLabelParagraphStyleModel.range];
        }
        //添加链接 & 设置作用域
        [attrString addAttribute:NSParagraphStyleAttributeName
                           value:[NSURL URLWithString:richLabelDataStringsModel.richLabelURLModel.urlStr]
                           range:richLabelDataStringsModel.richLabelURLModel.range];
    }
    return attrString;
}

@end
