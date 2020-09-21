//
//  UIButton+CountDownBtn.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerManager.h"

typedef enum : NSUInteger {
    ShowTimeType_SS = 0,//秒
    ShowTimeType_MMSS,//分秒
    ShowTimeType_HHMMSS,//时分秒
} ShowTimeType;

typedef enum : NSUInteger {
    CountDownBtnType_normal = 0,//普通模式
    CountDownBtnType_countDown//倒计时模式
} CountDownBtnType;

typedef enum : NSUInteger {
    CountDownBtnNewLineType_normal = 0,//普通模式
    CountDownBtnNewLineType_newLine//换行模式
} CountDownBtnNewLineType;

typedef enum : NSUInteger {
    CequenceForShowTitleRuningStrType_front = 0,//TitleRuningStr（固定值） 相对于 currentTime（浮动值）在前面
    CequenceForShowTitleRuningStrType_tail//TitleRuningStr（固定值） 相对于 currentTime（浮动值）在后面
} CequenceForShowTitleRuningStrType;

typedef enum : NSUInteger {
    CountDownBtnRunType_manual = 0,//手动触发计时器模式
    CountDownBtnRunType_auto//自启动模式
} CountDownBtnRunType;

NS_ASSUME_NONNULL_BEGIN

/*  使用方法，特别说明
 *  倒计时期间，不接受任何的点击事件
 *  countDownBtnNewLineType设置了这个属性仅仅对titleRuningStr有效，且在外层进行设置的时候需要用户手动加就换行符 \n
 *  自启动的优先级 > 手动触发的优先级。如果设置了自启动，那么手动触发无效
 */

@interface UIButton (CountDownBtn)
/* 在初始化方法里面赋值 */
@property(nonatomic,strong)NSString *titleBeginStr;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *layerBorderColor;
@property(nonatomic,strong)UIFont *titleLabelFont;
@property(nonatomic,assign)CGFloat layerCornerRadius;
@property(nonatomic,assign)CGFloat layerBorderWidth;

@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,strong)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
@property(nonatomic,strong)NSString *titleEndStr;
//倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
@property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
@property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
@property(nonatomic,assign)long count;// 倒计时
@property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
@property(nonatomic,assign)CountDownBtnRunType btnRunType;
@property(nonatomic,assign)CountDownBtnType countDownBtnType;
@property(nonatomic,assign)CountDownBtnNewLineType countDownBtnNewLineType;//设置了这个属性仅仅对titleRuningStr有效，且在外层进行设置的时候需要用户手动加就换行符 \n
@property(nonatomic,assign)CequenceForShowTitleRuningStrType cequenceForShowTitleRuningStrType;
@property(nonatomic,copy)MKDataBlock countDownBlock;
@property(nonatomic,copy)MKDataBlock countDownClickEventBlock;
@property(nonatomic,assign)BOOL isCountDownClockFinished;//倒计时是否结束
@property(nonatomic,assign)BOOL isCountDownClockOpen;//倒计时是否开始

@property(nonatomic,strong)NSString *countStr;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSMutableParagraphStyle *mps;
@property(nonatomic,strong)NSMutableAttributedString *mas;

-(void)actionCountDownBlock:(MKDataBlock)countDownBlock;//倒计时需要触发调用的方法：倒计时的时候外面同时干的事，随着定时器走，可以不实现
-(void)actionCountDownClickEventBlock:(MKDataBlock)countDownClickEventBlock;//点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数 自启动直接调用
-(void)timerDestroy;//可以不结束直接掐死

///用这个初始化方法
- (instancetype)initWithType:(CountDownBtnType)countDownBtnType
                     runType:(CountDownBtnRunType)runType
            layerBorderWidth:(CGFloat)layerBorderWidth
           layerCornerRadius:(CGFloat)layerCornerRadius
            layerBorderColor:(UIColor *_Nullable)layerBorderColor
                  titleColor:(UIColor *_Nullable)titleColor
               titleBeginStr:(NSString *_Nullable)titleBeginStr
              titleLabelFont:(UIFont *_Nullable)titleLabelFont;

@end

NS_ASSUME_NONNULL_END
