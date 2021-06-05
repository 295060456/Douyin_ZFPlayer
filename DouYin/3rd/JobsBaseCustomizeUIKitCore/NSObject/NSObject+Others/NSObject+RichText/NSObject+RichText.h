//
//  UILabel+RichText.h
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextConfig : NSObject

@property(nonatomic,strong)NSString *targetString;//作用文字
@property(nonatomic,strong)UIFont *font;//添加字体
@property(nonatomic,strong)UIColor *cor;//添加文字颜色
@property(nonatomic,assign)NSUnderlineStyle underlineStyle;//添加下划线
@property(nonatomic,strong)NSMutableParagraphStyle *paragraphStyle;//添加段落样式
@property(nonatomic,strong)NSString *urlStr;//添加链接
@property(nonatomic,assign)NSRange range;//设置作用域

@end

@interface NSObject (RichText)

+(NSMutableAttributedString *)richTextWithDataConfigMutArr:(NSArray <RichTextConfig *>*_Nonnull)richTextDataConfigMutArr;

@end

NS_ASSUME_NONNULL_END

/*
 
 示例代码:
 特别说明：普通文本和富文本的 左/中/右 段落对齐不是一样的写法
 
 self.contentLab.attributedText = [DDSysMsgTBVCell GGGG:@[@"尊敬的抖动用户：您发布的视频",
                                                          @"哈哈哈",
                                                          @"，被用户"]];
 
 +(NSMutableAttributedString *)richText:(NSArray <NSString *>*)arr{
     
     UIColor *color = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[RGB_COLOR(247, 131, 97),RGB_COLOR(245, 75, 100)]]
                                          startPoint:CGPointZero
                                            endPoint:CGPointZero
                                              opaque:NO
                                      targetViewRect:CGRectMake(0,
                                                                0,
                                                                KWidth(400),
                                                                KWidth(1))];
     
     RichTextConfig *config_01 = RichTextConfig.new;
     config_01.font = [UIFont systemFontOfSize:KWidth(10.6) weight:UIFontWeightRegular];
     config_01.cor = RGB_SAMECOLOR(115);
     config_01.targetString = arr[0];

     RichTextConfig *config_02 = RichTextConfig.new;
     config_02.font = [UIFont systemFontOfSize:KWidth(10.6) weight:UIFontWeightMedium];
     config_02.cor = color;
     config_02.targetString = arr[1];

     NSMutableArray *dataMutArr = NSMutableArray.array;
     [dataMutArr addObject:config_01];
     [dataMutArr addObject:config_02];

     // 设置整体的段落样式
     NSMutableAttributedString *attributedString = [NSObject richTextWithDataConfigMutArr:dataMutArr];
     NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
     paragraphStyle.alignment = NSTextAlignmentLeft;//文本对齐方式 左右对齐（两边对齐）
     [attributedString addAttribute:NSParagraphStyleAttributeName
                              value:paragraphStyle
                              range:NSMakeRange(0, attributedString.string.length)];//设置段落样式
     
     
     return attributedString;
 }
 
 ***/

/**
    富文本的属性介绍
 
    NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
    NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
    NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
    NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
    NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
    NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
    NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
    NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
    NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
    NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
    NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
    NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
    NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
    NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
    NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
    NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
    NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
    NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
    NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
    NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
    NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
 **/

/**
    富文本段落排版格式属性介绍
 
    lineSpacing 字体的行间距
    firstLineHeadIndent  首行缩进
    alignment （两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    lineBreakMode 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    headIndent 整体缩进(首行除外)
    tailIndent
    minimumLineHeight 最低行高
    maximumLineHeight 最大行高
    paragraphSpacing 段与段之间的间距
    paragraphSpacingBefore 段首行空白空间
    baseWritingDirection 书写方向（一共三种）
    lineHeightMultiple
    hyphenationFactor 连字属性 在iOS，唯一支持的值分别为0和1
 **/
