//
//  ButtonTimerModel.h
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"
#import "TimerManager.h"//时间管理
#import "NSObject+RichText.h"//富文本
#import "ButtonTimerDefStructure.h"

NS_ASSUME_NONNULL_BEGIN

@interface ButtonTimerConfigModel : NSObject

/**
    ❤️如果配置了富文本，则优先显示富文本属性
 **/
#pragma mark —— 一些通用的设置
//倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
@property(nonatomic,strong)NSTimerManager *timerManager;
@property(nonatomic,assign)long count;// 【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】❤️默认60秒
@property(nonatomic,strong)NSString *titleRunningDefaultStr;//计时过程中显示的非时间文字,中间过程动态值,与titleRunningDefaultAttributedStr互斥 【缺省值：重新开始】
@property(nonatomic,strong)NSAttributedString *titleRunningDefaultAttributedStr;//富文本,中间过程动态值,与titleRunningDefaultStr互斥
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleDefaultAttributedDataMutArr;
@property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
@property(nonatomic,assign)TimerStyle countDownBtnType;// 时间方向
@property(nonatomic,assign)CountDownBtnNewLineType countDownBtnNewLineType;// 【换行模式】仅仅作用于倒计时期间 【❤️注意：外部Button实例化的时候需要配置字体和Size的适应标准】
@property(nonatomic,assign)CequenceForShowTitleRuningStrType cequenceForShowTitleRuningStrType;// 文本显示类型
@property(nonatomic,assign)BOOL isCanBeClickWhenTimerCycle;// 倒计时期间，默认不接受任何的点击事件
#pragma mark —— 计时器未开始【静态值】
// UI
@property(nonatomic,strong)UIColor *layerBorderReadyPlayCor;
@property(nonatomic,strong)UIColor *titleReadyPlayCor;
@property(nonatomic,strong)UIFont *titleLabelReadyPlayFont;
@property(nonatomic,strong)UIColor *bgReadyPlayCor;
@property(nonatomic,assign)CGFloat layerCornerReadyPlayRadius;
@property(nonatomic,assign)CGFloat layerBorderReadyPlayWidth;
// Data
@property(nonatomic,strong)NSString *titleReadyPlayStr;//与titleReadyPlayAttributedStr互斥
@property(nonatomic,strong)NSAttributedString *titleReadyPlayAttributedStr;//富文本，与titleReadyPlayStr互斥
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleReadyPlayAttributedDataMutArr;
#pragma mark —— 计时器进行中【动态值】
// UI
@property(nonatomic,strong)UIColor *layerBorderRunningCor;//【缺省值：layerBorderReadyPlayCor】
@property(nonatomic,strong)UIColor *titleRunningCor;//【缺省值：titleReadyPlayCor】
@property(nonatomic,strong)UIFont *titleLabelRunningFont;//【缺省值：titleLabelReadyPlayFont】
@property(nonatomic,strong)UIColor *bgRunningCor;//计时过程中此btn的背景色【缺省值：bgReadyPlayCor】
@property(nonatomic,assign)CGFloat layerBorderRunningWidth;//【缺省值：layerCornerReadyPlayRadius】
@property(nonatomic,assign)CGFloat layerCornerRunningRadius;//【缺省值：layerBorderReadyPlayWidth】
// Data
@property(nonatomic,strong)NSString *titleRunningStr;//计时过程中显示的非时间文字,中间过程动态值,与titleRunningAttributedStr互斥【缺省值：titleRunningDefaultStr】
@property(nonatomic,strong)NSAttributedString *titleRunningAttributedStr;//富文本,中间过程动态值,与titleRunningStr互斥【缺省值：titleRunningDefaultAttributedStr】
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleRunningDataMutArr;//【缺省值：titleDefaultAttributedDataMutArr】
#pragma mark —— 计时器结束【静态值】
// UI
@property(nonatomic,strong)UIColor *layerBorderEndCor;//【缺省值：layerBorderReadyPlayCor】
@property(nonatomic,strong)UIColor *titleEndCor;//【缺省值：titleReadyPlayCor】
@property(nonatomic,strong)UIFont *titleLabelEndFont;//【缺省值：titleLabelReadyPlayFont】
@property(nonatomic,strong)UIColor *bgEndCor;//倒计时完全结束后的背景色【缺省值：bgReadyPlayCor】
@property(nonatomic,assign)CGFloat layerCornerEndRadius;//【缺省值：layerCornerReadyPlayRadius】
@property(nonatomic,assign)CGFloat layerBorderEndWidth;//【缺省值：layerBorderReadyPlayWidth】
// Data
@property(nonatomic,strong)NSString *titleEndStr;//与titleEndAttributedStr互斥
@property(nonatomic,strong)NSAttributedString *titleEndAttributedStr;//富文本，与titleEndStr互斥 【缺省值：titleReadyPlayAttributedStr】
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleEndDataMutArr;//【缺省值：titleReadyPlayAttributedDataMutArr】
#pragma mark —— 其他
@property(nonatomic,strong)NSString *formatTimeStr;//根据ShowTimeType格式化以后的时间【内部使用】
@property(nonatomic,strong)NSString *appendingStrByFormatTimeStr;//formatTimeStr后缀拼接的字符串。因为formatTimeStr是内部使用
/// 【Button内部使用】不要直接调用
-(void)actionBlockTimerRunning:(MKDataBlock)timerRunningBlock;// 定时器运行时的Block
-(void)actionBlockTimerFinish:(MKDataBlock)timerFinishBlock;// 定时器结束时候的Block

@end

NS_ASSUME_NONNULL_END
