//
//  UILabel+RichText.h
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//添加字体 & 设置作用域
@interface RichLabelFontModel : NSObject

@property(nonatomic,strong)UIFont *font;
@property(nonatomic,assign)NSRange range;

@end
//添加文字颜色 & 设置作用域
@interface RichLabelTextCorModel : NSObject

@property(nonatomic,strong)UIColor *cor;
@property(nonatomic,assign)NSRange range;

@end
//添加下划线 & 设置作用域
@interface RichLabelUnderlineModel : NSObject

@property(nonatomic,assign)NSUnderlineStyle underlineStyle;
@property(nonatomic,assign)NSRange range;

@end
//添加段落样式 & 设置作用域
@interface RichLabelParagraphStyleModel : NSObject

@property(nonatomic,strong)NSMutableParagraphStyle *paragraphStyle;
@property(nonatomic,assign)NSRange range;

@end
//添加链接 & 设置作用域
@interface RichLabelURLModel : NSObject

@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,assign)NSRange range;

@end

@interface UILabel (RichText)

-(void)makeRichTextWithDataStr:(NSString *_Nonnull)dataStr
                richLabelFonts:(NSArray <RichLabelFontModel *>*_Nullable)richLabelFonts
             richLabelTextCors:(NSArray <RichLabelTextCorModel *>*_Nullable)richLabelTextCors
           richLabelUnderlines:(NSArray <RichLabelUnderlineModel *>*_Nullable)richLabelUnderlines
      richLabelParagraphStyles:(NSArray <RichLabelParagraphStyleModel *>*_Nullable)richLabelParagraphStyles
                 richLabelURLs:(NSArray <RichLabelURLModel *>*_Nullable)richLabelURLs;

@end

NS_ASSUME_NONNULL_END
