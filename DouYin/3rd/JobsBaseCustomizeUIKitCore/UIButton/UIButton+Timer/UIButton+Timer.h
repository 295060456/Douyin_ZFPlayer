//
//  UIButton+Timer.h
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"
#import "NSObject+Time.h"
#import "NSObject+RichText.h"//富文本
#import "TimerManager.h"//时间管理
#import "ButtonTimerDefStructure.h"
#import "ButtonTimerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Timer)

@property(nonatomic,copy)MKDataBlock countDownClickEventBlock;//点击事件回调，就不要用系统的addTarget/action/forControlEvents
@property(nonatomic,copy)MKDataBlock timerRunningBlock;// 定时器运行时的Block
@property(nonatomic,copy)MKDataBlock timerFinishBlock;// 定时器结束时候的Block
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfig;

// 定时器运行时的Block
-(void)actionBlockTimerRunning:(MKDataBlock _Nullable)timerRunningBlock;
// 定时器结束时候的Block
-(void)actionBlockTimerFinish:(MKDataBlock _Nullable)timerFinishBlock;
// 点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)actionCountDownClickEventBlock:(MKDataBlock _Nullable)countDownClickEventBlock;

-(void)startTimer:(NSInteger)timeCount;//开启计时【从某个时间】
-(void)startTimer;//开启计时【用初始化时间】
-(void)timerDestroy;//可以不结束直接掐死

-(void)fontDecideSize;// Size自适应【注意：外界不要把Size的宽高写死】
-(void)sizeDecideFont;// 字体自适应

-(instancetype)initWithConfig:(ButtonTimerConfigModel *_Nonnull)config;

@end

NS_ASSUME_NONNULL_END
