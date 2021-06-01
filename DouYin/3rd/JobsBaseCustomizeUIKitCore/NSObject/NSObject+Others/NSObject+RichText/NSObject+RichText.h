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

+(NSAttributedString *)richTextWithDataConfigMutArr:(NSArray <RichTextConfig *>*_Nonnull)richTextDataConfigMutArr;

@end

NS_ASSUME_NONNULL_END

/*
 
 示例代码:
 
 self.contentLab.attributedText = [DDSysMsgTBVCell GGGG:@[@"尊敬的抖动用户：您发布的视频",
                                                          @"哈哈哈",
                                                          @"，被用户"]];
 
 +(NSAttributedString *)GGGG:(NSArray <NSString *>*)arr{
     
     RichTextConfig *config_01 = RichTextConfig.new;
     config_01.font = [UIFont systemFontOfSize:KWidth(12) weight:UIFontWeightMedium];
     config_01.cor = AppMainCor_04;
     config_01.targetString = arr[0];
     
     RichTextConfig *config_02 = RichTextConfig.new;
     config_02.font = [UIFont systemFontOfSize:KWidth(10) weight:UIFontWeightRegular];
     config_02.cor = COLOR_RGB(203, 32, 64);;
     config_02.targetString = arr[1];
     
     RichTextConfig *config_03 = RichTextConfig.new;
     config_03.font = [UIFont systemFontOfSize:KWidth(12) weight:UIFontWeightMedium];
     config_03.cor = AppMainCor_04;
     config_03.targetString = arr[2];
     
     NSMutableArray *dataMutArr = NSMutableArray.array;
     [dataMutArr addObject:config_01];
     [dataMutArr addObject:config_02];
     [dataMutArr addObject:config_03];
     
     return [NSObject richTextWithDataConfigMutArr:dataMutArr];
 }
 
 ***/
