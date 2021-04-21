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

@interface RichLabelDataStringsModel : NSObject

@property(nonatomic,strong)NSString *dataString;

@property(nonatomic,strong)RichLabelFontModel *richLabelFontModel;
@property(nonatomic,strong)RichLabelTextCorModel *richLabelTextCorModel;
@property(nonatomic,strong)RichLabelUnderlineModel *richLabelUnderlineModel;
@property(nonatomic,strong)RichLabelParagraphStyleModel *richLabelParagraphStyleModel;
@property(nonatomic,strong)RichLabelURLModel *richLabelURLModel;

@end

@interface NSObject (RichText)

+(NSAttributedString *)makeRichTextWithDataConfigMutArr:(NSArray <RichLabelDataStringsModel *>*_Nonnull)richTextDataConfigMutArr;

@end

NS_ASSUME_NONNULL_END

/*
 
 示例代码
 
 +(NSAttributedString *)makeContentLabAttributedTextWithModel:(MKRollDataModel *_Nullable)model{
     NSMutableArray *tempDataMutArr = NSMutableArray.array;
     RichLabelDataStringsModel *title_1_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_2_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_3_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_4_Model = RichLabelDataStringsModel.new;
     
     {
         title_1_Model.dataString = @"恭喜";
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(0, title_1_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = COLOR_RGB(46, 51, 77);
         richLabelTextCorModel.range = NSMakeRange(0, title_1_Model.dataString.length);
         
         title_1_Model.richLabelFontModel = richLabelFontModel;
         title_1_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {

         title_2_Model.dataString = [NSString stringWithFormat:@"'%@'",[NSString ensureNonnullString:model.friendName ReplaceStr:@"暂无用户名"]];
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = COLOR_RGB(203, 32, 64);
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
         
         
         title_2_Model.richLabelFontModel = richLabelFontModel;
         title_2_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {

         title_3_Model.dataString = [NSString stringWithFormat:@"在【%@】中中奖",[NSString ensureNonnullString:model.gameName ReplaceStr:@"暂无游戏名"]];
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length, title_3_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = COLOR_RGB(46, 51, 77);
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length, title_3_Model.dataString.length);
         
         
         title_3_Model.richLabelFontModel = richLabelFontModel;
         title_3_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {
         
         title_4_Model.dataString = [NSString stringWithFormat:@"%@元",[NSString ensureNonnullString:model.winMoney.stringValue ReplaceStr:@"0"]];
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length, title_4_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = COLOR_RGB(203, 32, 64);
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length, title_4_Model.dataString.length);
         
         
         title_4_Model.richLabelFontModel = richLabelFontModel;
         title_4_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     [tempDataMutArr addObject:title_1_Model];
     [tempDataMutArr addObject:title_2_Model];
     [tempDataMutArr addObject:title_3_Model];
     [tempDataMutArr addObject:title_4_Model];
     
     return [NSObject makeRichTextWithDataConfigMutArr:tempDataMutArr];
 }
 
 **/

