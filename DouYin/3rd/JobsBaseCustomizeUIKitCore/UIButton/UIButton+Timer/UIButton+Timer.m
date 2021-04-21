//
//  UIButton+Timer.m
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import "UIButton+Timer.h"

@implementation UIButton (Timer)

static char *UIButton_Timer_btnTimerConfig = "UIButton_Timer_btnTimerConfig";
static char *UIButton_CountDownBtn_countDownClickEventBlock = "UIButton_CountDownBtn_countDownClickEventBlock";
static char *UIButton_CountDownBtn_timerRunningBlock = "UIButton_CountDownBtn_timerRunningBlock";
static char *UIButton_CountDownBtn_timerFinishBlock = "UIButton_CountDownBtn_timerFinishBlock";

@dynamic btnTimerConfig;
@dynamic countDownClickEventBlock;
@dynamic timerRunningBlock;
@dynamic timerFinishBlock;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithConfig:(ButtonTimerConfigModel *_Nonnull)config{
    if (self = [super init]) {
        self.btnTimerConfig = config;
        [self setLayerConfigReadyPlay];
        [self setTitleReadyPlay];
        [self setTitleLabelConfigReadyPlay];
        // CountDownBtn 的点击事件回调
        @weakify(self)
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.countDownClickEventBlock) {
                self.countDownClickEventBlock(self);
            }
        }];
    }return self;
}
#pragma clang diagnostic pop
#pragma mark —— UI配置
/// 计时器未开始
-(void)setLayerConfigReadyPlay{
    self.layer.borderColor = self.btnTimerConfig.layerBorderReadyPlayCor.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.layerCornerReadyPlayRadius;
    self.layer.borderWidth = self.btnTimerConfig.layerBorderReadyPlayWidth;
    self.backgroundColor = self.btnTimerConfig.bgReadyPlayCor;
}

-(void)setTitleLabelConfigReadyPlay{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = self.btnTimerConfig.titleLabelReadyPlayFont;
    [self setTitleColor:self.btnTimerConfig.titleReadyPlayCor
               forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
/// 计时器进行中
-(void)setLayerConfigRunning{
    self.layer.borderColor = self.btnTimerConfig.layerBorderRunningCor.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.layerCornerRunningRadius;
    self.layer.borderWidth = self.btnTimerConfig.layerBorderRunningWidth;
}

-(void)setTitleLabelConfigRunning{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = !self.btnTimerConfig.countDownBtnNewLineType;
    // 换行模式仅仅作用于倒计时期间
    if (self.btnTimerConfig.countDownBtnNewLineType == CountDownBtnNewLineType_newLine){
//        self.titleLabel.numberOfLines = !self.btnTimerConfig.countDownBtnNewLineType;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.titleLabel sizeToFit];
//        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    self.titleLabel.font = self.btnTimerConfig.titleLabelRunningFont;
    [self setTitleColor:self.btnTimerConfig.titleRunningCor
               forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
/// 计时器结束
-(void)setLayerConfigEnd{
    self.layer.borderColor = self.btnTimerConfig.layerBorderEndCor.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.layerCornerEndRadius;
    self.layer.borderWidth = self.btnTimerConfig.layerBorderEndWidth;
}

-(void)setTitleLabelConfigEnd{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = self.btnTimerConfig.titleLabelEndFont;
    [self setTitleColor:self.btnTimerConfig.titleEndCor
               forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
#pragma mark —— 设置普通标题或者富文本标题
/// 计时器未开始
-(void)setTitleReadyPlay{
    if (self.btnTimerConfig.titleReadyPlayAttributedDataMutArr.count ||
        self.btnTimerConfig.titleReadyPlayAttributedStr) {
        //富文本
        [self setAttributedTitle:self.btnTimerConfig.titleReadyPlayAttributedStr
                        forState:UIControlStateNormal];
    }else{
        [self setTitle:self.btnTimerConfig.titleReadyPlayStr
              forState:UIControlStateNormal];
    }
}
/// 计时器进行中
-(void)setTitleRunning{
    if (self.btnTimerConfig.titleRunningDataMutArr.count ||
        self.btnTimerConfig.titleRunningAttributedStr) {
        //富文本
        [self setAttributedTitle:self.btnTimerConfig.titleRunningAttributedStr
                        forState:UIControlStateNormal];
    }else{
        [self setTitle:self.btnTimerConfig.titleRunningStr
              forState:UIControlStateNormal];
    }
    NSLog(@"WWWW = %@",self.btnTimerConfig.titleRunningStr);
}
/// 计时器结束
-(void)setTitleEnd{
    if (self.btnTimerConfig.titleEndDataMutArr.count ||
        self.btnTimerConfig.titleEndAttributedStr) {
        //富文本
        [self setAttributedTitle:self.btnTimerConfig.titleEndAttributedStr
                        forState:UIControlStateNormal];
    }else{
        [self setTitle:self.btnTimerConfig.titleEndStr
              forState:UIControlStateNormal];
    }
}
#pragma mark —— 时间方法
//开启计时【用初始化时间】
-(void)startTimer{
    [self startTimer:self.btnTimerConfig.count];
}
//开启计时【从某个时间】
-(void)startTimer:(NSInteger)timeCount{
    [self setTitleReadyPlay];
    [self setLayerConfigReadyPlay];
    [self setTitleLabelConfigReadyPlay];
    self.btnTimerConfig.count = timeCount;
    //启动方式——1
//    [NSTimerManager nsTimeStart:self.nsTimerManager
//                    withRunLoop:nil];
    //启动方式——2
    [self.btnTimerConfig.timerManager nsTimeStartSysAutoInRunLoop];
}
// 核心方法
-(void)timerRuning:(long)currentTime {
    //其他一些基础设置
    {
        self.enabled = self.btnTimerConfig.isCanBeClickWhenTimerCycle;//倒计时期间，默认不接受任何的点击事件
        self.backgroundColor = self.btnTimerConfig.bgRunningCor;
    }

    // 清除上一次拼装的数据
    if ([self.btnTimerConfig.titleRunningStr containsString:self.btnTimerConfig.formatTimeStr] &&
        self.btnTimerConfig.formatTimeStr) {
        self.btnTimerConfig.titleRunningStr = [self.btnTimerConfig.titleRunningStr stringByReplacingOccurrencesOfString:self.btnTimerConfig.formatTimeStr withString:@""];
    }
    //显示数据的二次封装
    {
        // 显示的时间格式
        switch (self.btnTimerConfig.showTimeType) {
            case ShowTimeType_SS:{
                self.btnTimerConfig.formatTimeStr = [NSString stringWithFormat:@"%ld秒",(long)currentTime];
            }break;
            case ShowTimeType_MMSS:{
                self.btnTimerConfig.formatTimeStr = [NSObject getMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
            }break;
            case ShowTimeType_HHMMSS:{
                self.btnTimerConfig.formatTimeStr = [NSObject getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
            }break;
            default:
                self.btnTimerConfig.formatTimeStr = @"异常值";
                break;
        }
        //字符串拼接
        switch (self.btnTimerConfig.cequenceForShowTitleRuningStrType) {
            case CequenceForShowTitleRuningStrType_front:{//首在前
                self.btnTimerConfig.titleRunningStr = [self.btnTimerConfig.titleRunningStr stringByAppendingString:self.btnTimerConfig.formatTimeStr];
            }break;
            case CequenceForShowTitleRuningStrType_tail:{//首在后
                self.btnTimerConfig.titleRunningStr = [self.btnTimerConfig.formatTimeStr stringByAppendingString:self.btnTimerConfig.titleRunningStr];
            }break;
            default:
                self.btnTimerConfig.titleRunningStr = @"异常值";
                break;
        }
    }
    // 富文本：锚定 titleRunningStr 和 formatTimeStr
    if(self.btnTimerConfig.titleRunningDataMutArr.count ||
       self.btnTimerConfig.titleRunningAttributedStr){
        //富文本 每一次时间触发方法都刷新数据并赋值
        NSMutableArray *tempDataMutArr = NSMutableArray.array;
        RichLabelDataStringsModel *formatTimeModel = RichLabelDataStringsModel.new;
        RichLabelDataStringsModel *titleRuningModel = RichLabelDataStringsModel.new;

//        for (int i = 0; i < self.btnTimerConfig.titleRunningDataMutArr.count; i ++) {
//            RichLabelDataStringsModel *richLabelDataStringsModel = self.btnTimerConfig.titleRunningDataMutArr[i];
//
//            if (i == 0) {
//                //修改range
//                if (self.btnTimerConfig.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_front) {
//                    richLabelDataStringsModel.richLabelFontModel.range = NSMakeRange(0, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelTextCorModel.range = NSMakeRange(0, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelUnderlineModel.range = NSMakeRange(0, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelParagraphStyleModel.range = NSMakeRange(0, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelURLModel.range = NSMakeRange(0, self.btnTimerConfig.titleRunningStr.length);
//                }else if (self.btnTimerConfig.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_tail){
//                    richLabelDataStringsModel.richLabelFontModel.range = NSMakeRange(0, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelTextCorModel.range = NSMakeRange(0, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelUnderlineModel.range = NSMakeRange(0, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelParagraphStyleModel.range = NSMakeRange(0, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelURLModel.range = NSMakeRange(0, self.btnTimerConfig.formatTimeStr.length);
//                }else{}
//                
//                formatTimeModel.dataString = self.btnTimerConfig.formatTimeStr;
//                formatTimeModel.richLabelFontModel = richLabelDataStringsModel.richLabelFontModel;
//                formatTimeModel.richLabelTextCorModel = richLabelDataStringsModel.richLabelTextCorModel;
//                formatTimeModel.richLabelUnderlineModel = richLabelDataStringsModel.richLabelUnderlineModel;
//                formatTimeModel.richLabelParagraphStyleModel = richLabelDataStringsModel.richLabelParagraphStyleModel;
//                formatTimeModel.richLabelURLModel = richLabelDataStringsModel.richLabelURLModel;
//            }
//            else if (i == 1){
//                
//                //修改range
//                if (self.btnTimerConfig.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_front) {
//                    richLabelDataStringsModel.richLabelFontModel.range = NSMakeRange(self.btnTimerConfig.titleRunningStr.length, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelTextCorModel.range = NSMakeRange(self.btnTimerConfig.titleRunningStr.length, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelUnderlineModel.range = NSMakeRange(self.btnTimerConfig.titleRunningStr.length, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelParagraphStyleModel.range = NSMakeRange(self.btnTimerConfig.titleRunningStr.length, self.btnTimerConfig.formatTimeStr.length);
//                    richLabelDataStringsModel.richLabelURLModel.range = NSMakeRange(self.btnTimerConfig.titleRunningStr.length, self.btnTimerConfig.formatTimeStr.length);
//                }else if (self.btnTimerConfig.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_tail){
//                    richLabelDataStringsModel.richLabelFontModel.range = NSMakeRange(self.btnTimerConfig.formatTimeStr.length, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelTextCorModel.range = NSMakeRange(self.btnTimerConfig.formatTimeStr.length, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelUnderlineModel.range = NSMakeRange(self.btnTimerConfig.formatTimeStr.length, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelParagraphStyleModel.range = NSMakeRange(self.btnTimerConfig.formatTimeStr.length, self.btnTimerConfig.titleRunningStr.length);
//                    richLabelDataStringsModel.richLabelURLModel.range = NSMakeRange(self.btnTimerConfig.formatTimeStr.length, self.btnTimerConfig.titleRunningStr.length);
//                }else{}
//                
//                titleRuningModel.dataString = self.btnTimerConfig.titleRunningStr;
//                titleRuningModel.richLabelFontModel = richLabelDataStringsModel.richLabelFontModel;
//                titleRuningModel.richLabelTextCorModel = richLabelDataStringsModel.richLabelTextCorModel;
//                titleRuningModel.richLabelUnderlineModel = richLabelDataStringsModel.richLabelUnderlineModel;
//                titleRuningModel.richLabelParagraphStyleModel = richLabelDataStringsModel.richLabelParagraphStyleModel;
//                titleRuningModel.richLabelURLModel = richLabelDataStringsModel.richLabelURLModel;
//            }else{}
//        }
        
        switch (self.btnTimerConfig.cequenceForShowTitleRuningStrType) {
            case CequenceForShowTitleRuningStrType_front:{
                [tempDataMutArr addObject:titleRuningModel];
                [tempDataMutArr addObject:formatTimeModel];
            }break;
            case CequenceForShowTitleRuningStrType_tail:{
                [tempDataMutArr addObject:formatTimeModel];
                [tempDataMutArr addObject:titleRuningModel];
            }break;
            default:
                break;
        }
        self.btnTimerConfig.titleRunningAttributedStr = [NSObject makeRichTextWithDataConfigMutArr:tempDataMutArr];
    }
    
    [self setTitleRunning];// 核心方法
    [self setLayerConfigRunning];
    [self setTitleLabelConfigRunning];
}

-(void)timerDestroy{
    self.enabled = YES;
    NSLog(@"self.btnTimerConfig.titleEndStr = %@",self.btnTimerConfig.titleEndStr);
    [self setTitleEnd];
    [self setTitleLabelConfigEnd];
    [self setLayerConfigEnd];
    self.backgroundColor = self.btnTimerConfig.bgEndCor;
    [self.btnTimerConfig.timerManager nsTimeDestroy];
}
// Size自适应【注意：外界不要把Size的宽高写死】
-(void)fontDecideSize{
    [self sizeToFit];
}
// 字体自适应
-(void)sizeDecideFont{
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
#pragma mark —— Block
//点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)actionCountDownClickEventBlock:(MKDataBlock _Nullable)countDownClickEventBlock{
    self.countDownClickEventBlock = countDownClickEventBlock;
}
// 定时器运行时的Block
-(void)actionBlockTimerRunning:(MKDataBlock _Nullable)timerRunningBlock{
    self.timerRunningBlock = timerRunningBlock;
}
// 定时器结束时候的Block
-(void)actionBlockTimerFinish:(MKDataBlock _Nullable)timerFinishBlock{
    self.timerFinishBlock = timerFinishBlock;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)ButtonTimerModel *btnTimerConfig;
-(ButtonTimerConfigModel *)btnTimerConfig{
    ButtonTimerConfigModel *BtnTimerConfig = objc_getAssociatedObject(self, UIButton_Timer_btnTimerConfig);
    if (!BtnTimerConfig) {
        BtnTimerConfig = ButtonTimerConfigModel.new;
        // 这里添加默认配置
//        BtnTimerConfig.
        objc_setAssociatedObject(self,
                                 UIButton_Timer_btnTimerConfig,
                                 BtnTimerConfig,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 定时器运行时的Block
    @weakify(self)
    [BtnTimerConfig actionBlockTimerRunning:^(id data) {
        @strongify(self)
        NSLog(@"data = %@",data);
        if ([data isKindOfClass:NSTimerManager.class]) {
            NSTimerManager *timeManager = (NSTimerManager *)data;
            timeManager.timerStyle = BtnTimerConfig.countDownBtnType;
            
            NSLog(@"DDD = %f",timeManager.anticlockwiseTime);
            [self timerRuning:(long)timeManager.anticlockwiseTime];//倒计时方法
        }
        
        if (self.timerRunningBlock) {
            self.timerRunningBlock(data);
        }
    }];
    // 定时器结束时候的Block
    [BtnTimerConfig actionBlockTimerFinish:^(id data) {
        @strongify(self)
        [self timerDestroy];
        NSLog(@"定时器结束 = %@",data);
        if (self.timerFinishBlock) {
            self.timerFinishBlock(data);
        }
    }];
    return BtnTimerConfig;
}

-(void)setBtnTimerConfig:(ButtonTimerConfigModel *)btnTimerConfig{
    objc_setAssociatedObject(self,
                             UIButton_Timer_btnTimerConfig,
                             btnTimerConfig,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
#pragma mark —— @property(nonatomic,copy)MKDataBlock timerRunningBlock;// 定时器运行时的Block
-(MKDataBlock)timerRunningBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_timerRunningBlock);
}

-(void)setTimerRunningBlock:(MKDataBlock)timerRunningBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_timerRunningBlock,
                             timerRunningBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock timerFinishBlock;// 定时器结束时候的Block
-(MKDataBlock)timerFinishBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_timerFinishBlock);
}

-(void)setTimerFinishBlock:(MKDataBlock)timerFinishBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_timerFinishBlock,
                             timerFinishBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
