//
//  UIButton+CountDownBtn.m
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIButton+CountDownBtn.h"
#import <objc/runtime.h>

@implementation UIButton (CountDownBtn)

static char *UIButton_CountDownBtn_nsTimerManager = "UIButton_CountDownBtn_nsTimerManager";
static char *UIButton_CountDownBtn_titleBeginStr = "UIButton_CountDownBtn_titleBeginStr";
static char *UIButton_CountDownBtn_titleRuningStr = "UIButton_CountDownBtn_titleRuningStr";
static char *UIButton_CountDownBtn_titleEndStr = "UIButton_CountDownBtn_titleEndStr";
static char *UIButton_CountDownBtn_titleColor = "UIButton_CountDownBtn_titleColor";
static char *UIButton_CountDownBtn_bgCountDownColor = "UIButton_CountDownBtn_bgCountDownColor";
static char *UIButton_CountDownBtn_bgEndColor = "UIButton_CountDownBtn_bgEndColor";
static char *UIButton_CountDownBtn_layerBorderColor = "UIButton_CountDownBtn_layerBorderColor";
static char *UIButton_CountDownBtn_titleLabelFont = "UIButton_CountDownBtn_titleLabelFont";
static char *UIButton_CountDownBtn_layerCornerRadius = "UIButton_CountDownBtn_layerCornerRadius";
static char *UIButton_CountDownBtn_layerBorderWidth = "UIButton_CountDownBtn_layerBorderWidth";
static char *UIButton_CountDownBtn_showTimeType = "UIButton_CountDownBtn_showTimeType";
static char *UIButton_CountDownBtn_count = "UIButton_CountDownBtn_count";
static char *UIButton_CountDownBtn_countDownBlock = "UIButton_CountDownBtn_countDownBlock";
static char *UIButton_CountDownBtn_countDownBtnType = "UIButton_CountDownBtn_countDownBtnType";
static char *UIButton_CountDownBtn_isCountDownClockFinished = "UIButton_CountDownBtn_isCountDownClockFinished";
static char *UIButton_CountDownBtn_countDownClickEventBlock = "UIButton_CountDownBtn_countDownClickEventBlock";
static char *UIButton_CountDownBtn_isCountDownClockOpen = "UIButton_CountDownBtn_isCountDownClockOpen";
static char *UIButton_CountDownBtn_countDownBtnNewLineType = "UIButton_CountDownBtn_countDownBtnNewLineType";
static char *UIButton_CountDownBtn_cequenceForShowTitleRuningStrType = "UIButton_CountDownBtn_cequenceForShowTitleRuningStrType";
static char *UIButton_CountDownBtn_countStr = "UIButton_CountDownBtn_countStr";
static char *UIButton_CountDownBtn_str = "UIButton_CountDownBtn_str";
static char *UIButton_CountDownBtn_mps = "UIButton_CountDownBtn_mps";
static char *UIButton_CountDownBtn_mas = "UIButton_CountDownBtn_mas";
static char *UIButton_CountDownBtn_btnRunType = "UIButton_CountDownBtn_btnRunType";

@dynamic nsTimerManager;
@dynamic titleBeginStr;
@dynamic titleRuningStr;
@dynamic titleEndStr;
@dynamic titleColor;
@dynamic bgCountDownColor;
@dynamic bgEndColor;
@dynamic layerBorderColor;
@dynamic titleLabelFont;
@dynamic layerCornerRadius;
@dynamic layerBorderWidth;
@dynamic showTimeType;
@dynamic count;
@dynamic countDownBlock;
@dynamic countDownBtnType;
@dynamic isCountDownClockFinished;
@dynamic countDownClickEventBlock;
@dynamic isCountDownClockOpen;
@dynamic countDownBtnNewLineType;
@dynamic cequenceForShowTitleRuningStrType;
@dynamic countStr;
@dynamic str;
@dynamic mps;
@dynamic mas;
@dynamic btnRunType;

-(instancetype)initWithType:(CountDownBtnType)countDownBtnType
                    runType:(CountDownBtnRunType)runType
           layerBorderWidth:(CGFloat)layerBorderWidth
          layerCornerRadius:(CGFloat)layerCornerRadius
           layerBorderColor:(UIColor *_Nullable)layerBorderColor
                 titleColor:(UIColor *_Nullable)titleColor
              titleBeginStr:(NSString *_Nullable)titleBeginStr
             titleLabelFont:(UIFont *_Nullable)titleLabelFont{

    if (self = [super init]) {
        self.countDownBtnType = countDownBtnType;
        self.btnRunType = runType;
        
        if (self.countDownBtnType) {
            // CountDownBtn 的点击事件回调
            @weakify(self)
            [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                if ((self.isCountDownClockFinished && self.btnRunType == CountDownBtnRunType_auto) ||//自启动模式
                    self.btnRunType == CountDownBtnRunType_manual) {//手动启动模式
                    
                    self.isCountDownClockFinished = NO;
                    self.isCountDownClockOpen = NO;
                    
//                    [self timeFailBeginFrom:self.count];//根据需求来
                }
                
                if (self.countDownClickEventBlock) {
                    self.countDownClickEventBlock(self);
                }
            }];
            
            switch (self.btnRunType) {
                case CountDownBtnRunType_manual:{//手动触发计时器模式
                    [self setTitle:@"发送验证码"
                          forState:UIControlStateNormal];
                    
                    self.layer.borderColor = layerBorderColor.CGColor;
                    self.layer.cornerRadius = layerCornerRadius;
                    self.titleLabel.font = titleLabelFont;
                    self.layer.borderWidth = layerBorderWidth;
                    [self setTitleColor:titleColor
                               forState:UIControlStateNormal];
                }break;
                case CountDownBtnRunType_auto:{//自启动模式

                }break;
                default:
                    break;
            }
            
            [self.titleLabel sizeToFit];
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
        }
    }return self;
}

//先走timeFailBeginFrom 再走drawRect
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.countDownBtnNewLineType) {
        self.titleLabel.numberOfLines = 0;
    }
    
    if (self.countDownBtnType) {
        if (!self.isCountDownClockOpen) {
            switch (self.countDownBtnNewLineType) {
                case CountDownBtnNewLineType_normal:{
                    [self setTitle:self.titleBeginStr
                          forState:UIControlStateNormal];
                }break;
                case CountDownBtnNewLineType_newLine:{
                    NSLog(@"%@",self.titleBeginStr);
                    self.str = self.titleBeginStr;
                    [self setAttributedTitle:self.mas
                                    forState:UIControlStateNormal];
                }break;
                    
                default:
                    break;
            }
        }
    }
}
//倒计时方法:
- (void)timeFailBeginFrom:(NSInteger)timeCount {
    switch (self.countDownBtnNewLineType) {
        case CountDownBtnNewLineType_normal:{
            [self setTitle:self.titleBeginStr
                  forState:UIControlStateNormal];
        }break;
        case CountDownBtnNewLineType_newLine:{
            NSLog(@"%@",self.titleBeginStr);
            self.str = self.titleBeginStr;
            [self setAttributedTitle:self.mas
                            forState:UIControlStateNormal];
        }break;
        default:
            break;
    }
    
    self.countDownBtnType = CountDownBtnType_countDown;
    self.count = timeCount;
    self.enabled = NO;
    
    //启动方式——1
//    [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
//                    withRunLoop:nil];
    //启动方式——2
    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}
//
- (void)timerRuning:(long)currentTime {
    self.enabled = NO;//倒计时期间，不接受任何的点击事件
    switch (self.showTimeType) {
        case ShowTimeType_SS:{
            self.countStr = [NSString stringWithFormat:@"%ld秒",(long)currentTime];
        }break;
        case ShowTimeType_MMSS:{
            self.countStr = [self getMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
        }break;
        case ShowTimeType_HHMMSS:{
            self.countStr = [self getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
        }break;
        default:
            self.countStr = @"异常值";
            break;
    }

    switch (self.cequenceForShowTitleRuningStrType) {
        case CequenceForShowTitleRuningStrType_front:{
            self.str = [self.titleRuningStr stringByAppendingString:self.countStr];
        }break;
        case CequenceForShowTitleRuningStrType_tail:{
            self.str = [self.countStr stringByAppendingString:self.titleRuningStr];
        }break;
        default:
            self.str = @"异常值";
            break;
    }
        
    switch (self.countDownBtnNewLineType) {
        case CountDownBtnNewLineType_normal:{
            [self setTitle:self.str
                  forState:UIControlStateNormal];
        }break;
        case CountDownBtnNewLineType_newLine:{
            NSLog(@"%@",self.mas);
            NSLog(@"%@",self.countStr);
            [self setAttributedTitle:self.mas
                            forState:UIControlStateNormal];
        }break;
            
        default:
            break;
    }

    self.backgroundColor = self.bgCountDownColor;
}

-(void)timerDestroy{
    self.enabled = YES;
    self.isCountDownClockFinished = YES;
    switch (self.countDownBtnNewLineType) {
        case CountDownBtnNewLineType_normal:{
            [self setTitle:self.titleEndStr
                  forState:UIControlStateNormal];
        }break;
        case CountDownBtnNewLineType_newLine:{
            self.str = self.titleEndStr;
            [self setAttributedTitle:self.mas
                            forState:UIControlStateNormal];
        }break;
        default:
            break;
    }
    
    self.backgroundColor = self.bgEndColor;
    [self.nsTimerManager nsTimeDestroy];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getHHMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
//    NSLog(@"format_time : %@",format_time);
    return format_time;
}
//传入 秒  得到  xx分钟xx秒
-(NSString *)getMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}

-(void)actionCountDownClickEventBlock:(MKDataBlock)countDownClickEventBlock{
    self.countDownClickEventBlock = countDownClickEventBlock;
}

-(void)actionCountDownBlock:(MKDataBlock)countDownBlock{
    self.countDownBlock = countDownBlock;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)NSTimerManager *nsTimerManager;
-(NSTimerManager *)nsTimerManager{
    NSTimerManager *timerManager = objc_getAssociatedObject(self, UIButton_CountDownBtn_nsTimerManager);
    if (!timerManager) {
        timerManager = NSTimerManager.new;
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_nsTimerManager,
                                 timerManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    timerManager.timerStyle = TimerStyle_anticlockwise;//逆时针模式（倒计时模式）
    timerManager.anticlockwiseTime = self.count;//逆时针模式（倒计时）的顶点时间
    
    @weakify(self)
    //倒计时启动
    [timerManager actionNSTimerManagerRunningBlock:^(id data) {
        self.isCountDownClockOpen = YES;
        @strongify(self)
        if ([data isKindOfClass:NSTimerManager.class]) {
            NSTimerManager *timeManager = (NSTimerManager *)data;
            [self timerRuning:(long)timeManager.anticlockwiseTime];
        }
        
        if (self.countDownBlock) {
            self.countDownBlock(@1);//倒计时需要触发调用的方法:倒计时的时候外面同时干的事，随着定时器走，可以不实现
        }
    }];
    //倒计时结束
    [timerManager actionNSTimerManagerFinishBlock:^(id data) {
        @strongify(self)
        [self timerDestroy];
    }];
    
    return timerManager;
}

-(void)setNsTimerManager:(NSTimerManager *)nsTimerManager{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_nsTimerManager,
                             nsTimerManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)NSString *titleBeginStr;
-(NSString *)titleBeginStr{
    NSString *TitleBeginStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleBeginStr);
    if (!TitleBeginStr) {
        TitleBeginStr = @"开始";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleBeginStr,
                                 TitleBeginStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return TitleBeginStr;
}

-(void)setTitleBeginStr:(NSString *)titleBeginStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleBeginStr,
                             titleBeginStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
-(NSString *)titleRuningStr{
    NSString *TitleRuningStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleRuningStr);
    if (!TitleRuningStr) {
        TitleRuningStr = @"开始";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleRuningStr,
                                 TitleRuningStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleRuningStr;
}

-(void)setTitleRuningStr:(NSString *)titleRuningStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleRuningStr,
                             titleRuningStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *titleEndStr;
-(NSString *)titleEndStr{
    NSString *TitleEndStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleEndStr);
    if (!TitleEndStr) {
        TitleEndStr = @"结束";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleEndStr,
                                 TitleEndStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleEndStr;
}

-(void)setTitleEndStr:(NSString *)titleEndStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleEndStr,
                             titleEndStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *titleColor;
-(UIColor *)titleColor{
    UIColor *TitleColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleColor);
    if (!TitleColor) {
        TitleColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleColor,
                                 TitleColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleColor;
}

-(void)setTitleColor:(UIColor *)titleColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleColor,
                             titleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
-(UIColor *)bgCountDownColor{
    UIColor *BgCountDownColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_bgCountDownColor);
    if (!BgCountDownColor) {
        BgCountDownColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_bgCountDownColor,
                                 BgCountDownColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgCountDownColor;
}

-(void)setBgCountDownColor:(UIColor *)bgCountDownColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_bgCountDownColor,
                             bgCountDownColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
-(UIColor *)bgEndColor{
    UIColor *BgEndColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_bgEndColor);
    if (!BgEndColor) {
        BgEndColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_bgEndColor,
                                 BgEndColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgEndColor;
}

-(void)setBgEndColor:(UIColor *)bgEndColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_bgEndColor,
                             bgEndColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *layerBorderColor;
-(UIColor *)layerBorderColor{
    UIColor *LayerBorderColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_layerBorderColor);
    if (!LayerBorderColor) {
        LayerBorderColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_layerBorderColor,
                                 LayerBorderColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LayerBorderColor;
}

-(void)setLayerBorderColor:(UIColor *)layerBorderColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerBorderColor,
                             layerBorderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIFont *titleLabelFont;
-(UIFont *)titleLabelFont{
    UIFont *TitleLabelFont = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleLabelFont);
    if (!TitleLabelFont) {
        TitleLabelFont = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleLabelFont,
                                 TitleLabelFont,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleLabelFont;
}

-(void)setTitleLabelFont:(UIFont *)titleLabelFont{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleLabelFont,
                             titleLabelFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat layerCornerRadius;
-(CGFloat)layerCornerRadius{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_layerCornerRadius) floatValue];
}

-(void)setLayerCornerRadius:(CGFloat)layerCornerRadius{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerCornerRadius,
                             [NSNumber numberWithFloat:layerCornerRadius],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat layerBorderWidth;
-(CGFloat)layerBorderWidth{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_layerBorderWidth) floatValue];
}

-(void)setLayerBorderWidth:(CGFloat)layerBorderWidth{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerBorderWidth,
                             [NSNumber numberWithFloat:layerBorderWidth],
                             OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark —— @property(nonatomic,assign)long count;
-(long)count{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_count) longValue];
}

-(void)setCount:(long)count{
    if (count == 0) {
        count = 3;
    }
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_count,
                             [NSNumber numberWithLong:count],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock countDownBlock;
-(MKDataBlock)countDownBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownBlock);
}

-(void)setCountDownBlock:(MKDataBlock)countDownBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownBlock,
                             countDownBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock countDownClickEventBlock;
-(MKDataBlock)countDownClickEventBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownClickEventBlock);
}

-(void)setCountDownClickEventBlock:(MKDataBlock)countDownClickEventBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownClickEventBlock,
                             countDownClickEventBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)ShowTimeType showTimeType;
-(ShowTimeType)showTimeType{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_showTimeType) integerValue];
}

-(void)setShowTimeType:(ShowTimeType)showTimeType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_showTimeType,
                             [NSNumber numberWithInteger:showTimeType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CountDownBtnType countDownBtnType;
-(CountDownBtnType)countDownBtnType{
    CountDownBtnType countDownBtnType = [objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownBtnType) integerValue];
    return countDownBtnType;
}

-(void)setCountDownBtnType:(CountDownBtnType)countDownBtnType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownBtnType,
                             [NSNumber numberWithInteger:countDownBtnType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CountDownBtnNewLineType countDownBtnNewLineType;
-(CountDownBtnNewLineType)countDownBtnNewLineType{
     return [objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownBtnNewLineType) integerValue];
}

-(void)setCountDownBtnNewLineType:(CountDownBtnNewLineType)countDownBtnNewLineType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownBtnNewLineType,
                             [NSNumber numberWithInteger:countDownBtnNewLineType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CequenceForShowTitleRuningStrType cequenceForShowTitleRuningStrType;
-(CequenceForShowTitleRuningStrType)cequenceForShowTitleRuningStrType{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_cequenceForShowTitleRuningStrType) integerValue];
}

-(void)setCequenceForShowTitleRuningStrType:(CequenceForShowTitleRuningStrType)cequenceForShowTitleRuningStrType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_cequenceForShowTitleRuningStrType,
                             [NSNumber numberWithInteger:cequenceForShowTitleRuningStrType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CountDownBtnRunType btnRunType;
-(CountDownBtnRunType)btnRunType{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_btnRunType) integerValue];
}

-(void)setBtnRunType:(CountDownBtnRunType)btnRunType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_btnRunType,
                             [NSNumber numberWithInteger:btnRunType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)BOOL isCountDownClockFinished;
-(BOOL)isCountDownClockFinished{
    BOOL d = [objc_getAssociatedObject(self, UIButton_CountDownBtn_isCountDownClockFinished) boolValue];
    return d;
}

-(void)setIsCountDownClockFinished:(BOOL)isCountDownClockFinished{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_isCountDownClockFinished,
                             [NSNumber numberWithBool:isCountDownClockFinished],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark ——  @property(nonatomic,assign)BOOL isCountDownClockOpen;//倒计时是否开始
-(BOOL)isCountDownClockOpen{
    BOOL d = [objc_getAssociatedObject(self, UIButton_CountDownBtn_isCountDownClockOpen) boolValue];
    return d;
}

-(void)setIsCountDownClockOpen:(BOOL)isCountDownClockOpen{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_isCountDownClockOpen,
                             [NSNumber numberWithBool:isCountDownClockOpen],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,strong)NSString *countStr;
-(NSString *)countStr{
    NSString *CountStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_countStr);
    return CountStr;
}

-(void)setCountStr:(NSString *)countStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countStr,
                             countStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *str;
-(NSString *)str{
    NSString *Str = objc_getAssociatedObject(self, UIButton_CountDownBtn_str);
    return Str;
}

-(void)setStr:(NSString *)str{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_str,
                             str,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableParagraphStyle *mps;
-(NSMutableParagraphStyle *)mps{
    NSMutableParagraphStyle *MPS = objc_getAssociatedObject(self, UIButton_CountDownBtn_mps);
    if (!MPS) {
        MPS = NSMutableParagraphStyle.new;
        MPS.lineSpacing = 0;
        MPS.alignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_mps,
                                 MPS,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return MPS;
}

-(void)setMps:(NSMutableParagraphStyle *)mps{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_mps,
                             mps,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableAttributedString *mas;
-(NSMutableAttributedString *)mas{//重新发送 正常 发送验证码 不正常
    NSMutableAttributedString *MAS = objc_getAssociatedObject(self, UIButton_CountDownBtn_mas);
    if (![NSString isNullString:self.countStr]) {
        MAS = [[NSMutableAttributedString alloc] initWithString:self.str];
        NSLog(@"%@",self.mps);
        NSLog(@"%@",self.titleRuningStr);
        NSLog(@"%@",self.countStr);
        NSLog(@"%ld",self.countStr.length);//2
        NSLog(@"%ld",self.titleRuningStr.length);//5
        if (!self.isCountDownClockFinished) {//倒计时没结束的时候走这个，否则会崩，因为重新设定了值
            [MAS addAttribute:NSParagraphStyleAttributeName
                        value:self.mps
                        range:NSMakeRange(0, self.titleRuningStr.length)];
            
            if (self.isCountDownClockOpen) {
                [MAS addAttribute:NSParagraphStyleAttributeName
                            value:self.mps
                            range:NSMakeRange(self.titleRuningStr.length, self.countStr.length)];
                [MAS addAttribute:NSForegroundColorAttributeName
                            value:self.titleColor
                            range:NSMakeRange(0, self.titleRuningStr.length + self.countStr.length)];
                [MAS addAttribute:NSFontAttributeName
                            value:self.titleLabelFont
                            range:NSMakeRange(0, self.titleRuningStr.length + self.countStr.length)];
            }else{
                [MAS addAttribute:NSParagraphStyleAttributeName
                            value:self.mps
                            range:NSMakeRange(0, self.titleRuningStr.length)];
                [MAS addAttribute:NSForegroundColorAttributeName
                            value:self.titleColor
                            range:NSMakeRange(0, self.titleRuningStr.length)];
                [MAS addAttribute:NSFontAttributeName
                            value:self.titleLabelFont
                            range:NSMakeRange(0, self.titleRuningStr.length)];
            }
        }
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_mas,
                                 MAS,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return MAS;
}

-(void)setMas:(NSMutableAttributedString *)mas{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_mas,
                             mas,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
