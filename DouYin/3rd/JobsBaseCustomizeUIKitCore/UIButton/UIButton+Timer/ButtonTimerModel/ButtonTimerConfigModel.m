//
//  ButtonTimerModel.m
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import "ButtonTimerConfigModel.h"

@interface ButtonTimerConfigModel ()

@property(nonatomic,copy)MKDataBlock timerRunningBlock;// 定时器运行时的Block
@property(nonatomic,copy)MKDataBlock timerFinishBlock;// 定时器结束时候的Block

@end

@implementation ButtonTimerConfigModel

@synthesize countDownBtnType = _countDownBtnType;
@synthesize count = _count;

// 定时器运行时的Block
-(void)actionBlockTimerRunning:(MKDataBlock)timerRunningBlock{
    self.timerRunningBlock = timerRunningBlock;
}
// 定时器结束时候的Block
-(void)actionBlockTimerFinish:(MKDataBlock)timerFinishBlock{
    self.timerFinishBlock = timerFinishBlock;
}
#pragma mark —— 重写set方法
-(void)setCountDownBtnType:(TimerStyle)countDownBtnType{
    _countDownBtnType = countDownBtnType;
    _timerManager.timerStyle = _countDownBtnType;
}

-(void)setCount:(long)count{
    _count = count;
    _timerManager.anticlockwiseTime = _count;//逆时针模式（倒计时）的顶点时间
}
#pragma mark —— lazyLoad【配置默认值】
-(NSTimerManager *)timerManager{
    if (!_timerManager) {
        _timerManager = NSTimerManager.new;
        _timerManager.timerStyle = self.countDownBtnType;
        _timerManager.anticlockwiseTime = self.count;//【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】
        @weakify(self)
        //倒计时启动
        [_timerManager actionNSTimerManagerRunningBlock:^(id data) {
            @strongify(self)
            NSLog(@"正在倒计时...");
            if (self.timerRunningBlock) {
                self.timerRunningBlock(data);
            }
        }];
        //倒计时结束
        [_timerManager actionNSTimerManagerFinishBlock:^(id data) {
            @strongify(self)
            if (self.timerFinishBlock) {
                self.timerFinishBlock(data);
            }
        }];
    }return _timerManager;
}

-(long)count{
    if (!_count) {
        _count = 60;
    }return _count;
}

-(NSString *)titleRunningDefaultStr{
    if (!_titleRunningDefaultStr) {
        _titleRunningDefaultStr = @"    重新开始    ";
    }return _titleRunningDefaultStr;
}
// 未用
-(NSAttributedString *)titleRunningDefaultAttributedStr{
    if (!_titleRunningDefaultAttributedStr) {
        _titleRunningDefaultAttributedStr = self.titleDefaultAttributedDataMutArr.count ? [NSObject makeRichTextWithDataConfigMutArr:self.titleDefaultAttributedDataMutArr] : nil;
    }return _titleRunningDefaultAttributedStr;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)titleDefaultAttributedDataMutArr{
    if (!_titleDefaultAttributedDataMutArr) {
        _titleDefaultAttributedDataMutArr = NSMutableArray.array;
        // 需要配置默认值
    }return _titleDefaultAttributedDataMutArr;
}
#pragma mark —— 最为关心的显示值
/// 其他
-(NSString *)formatTimeStr{
    if (self.countDownBtnNewLineType == CountDownBtnNewLineType_newLine) {//提行模式
        if (![_formatTimeStr containsString:@"\n"] && _formatTimeStr) {
            if (self.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_front) {
                _formatTimeStr = [@"\n" stringByAppendingString:_formatTimeStr];
            }else if (self.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_tail){
                _formatTimeStr = [_formatTimeStr stringByAppendingString:@"\n"];
            }else{}
        }
    }return _formatTimeStr;
}
/// 计时器未开始
-(NSString *)titleReadyPlayStr{
    if (self.countDownBtnNewLineType == CountDownBtnNewLineType_newLine) {//提行模式
        if (![_titleReadyPlayStr containsString:@"\n"] && _titleReadyPlayStr) {
            _titleReadyPlayStr = [_titleReadyPlayStr stringByAppendingString:@"\n"];
        }
    }return _titleReadyPlayStr;
}

-(NSAttributedString *)titleReadyPlayAttributedStr{
    if (!_titleReadyPlayAttributedStr) {
        _titleReadyPlayAttributedStr = self.titleReadyPlayAttributedDataMutArr.count ? [NSObject makeRichTextWithDataConfigMutArr:self.titleReadyPlayAttributedDataMutArr] : nil;
    }return _titleReadyPlayAttributedStr;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)titleReadyPlayAttributedDataMutArr{
    if (!_titleReadyPlayAttributedDataMutArr) {
        _titleReadyPlayAttributedDataMutArr = NSMutableArray.array;
    }return _titleReadyPlayAttributedDataMutArr;
}
/// 计时器进行中
-(NSString *)titleRunningStr{
    if (!_titleRunningStr) {
        _titleRunningStr = self.titleRunningDefaultStr;
    }
    if (self.countDownBtnNewLineType == CountDownBtnNewLineType_newLine) {//提行模式
        if (![_titleRunningStr containsString:@"\n"]) {
            _titleRunningStr = [_titleRunningStr stringByAppendingString:@"\n"];
        }
    }return _titleRunningStr;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)titleRunningDataMutArr{
    if (!_titleRunningDataMutArr) {
        _titleRunningDataMutArr = self.titleReadyPlayAttributedDataMutArr;
    }return _titleRunningDataMutArr;
}

-(NSAttributedString *)titleRunningAttributedStr{
    if (!_titleRunningAttributedStr) {
        _titleRunningAttributedStr = self.titleRunningDataMutArr.count ? [NSObject makeRichTextWithDataConfigMutArr:self.titleRunningDataMutArr] : self.titleReadyPlayAttributedStr;
    }return _titleRunningAttributedStr;
}
/// 计时器结束
-(NSString *)titleEndStr{
    if (!_titleEndStr) {
        _titleEndStr = self.titleReadyPlayStr;
    }
    if (self.countDownBtnNewLineType == CountDownBtnNewLineType_newLine) {//提行模式
        if (![_titleEndStr containsString:@"\n"]) {
            _titleEndStr = [_titleEndStr stringByAppendingString:@"\n"];
        }
    }return _titleEndStr;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)titleEndDataMutArr{
    if (!_titleEndDataMutArr) {
        _titleEndDataMutArr = self.titleReadyPlayAttributedDataMutArr;
    }return _titleEndDataMutArr;
}

-(NSAttributedString *)titleEndAttributedStr{
    if (!_titleEndAttributedStr) {
        _titleEndAttributedStr = self.titleEndDataMutArr.count ? [NSObject makeRichTextWithDataConfigMutArr:self.titleEndDataMutArr] : self.titleReadyPlayAttributedStr;
    }return _titleEndAttributedStr;
}
#pragma mark —— 次要关心的UI界面值
/// 计时器未开始
-(UIColor *)layerBorderReadyPlayCor{
    if (!_layerBorderReadyPlayCor) {
        _layerBorderReadyPlayCor = UIColor.blueColor;
    }return _layerBorderReadyPlayCor;
}

-(UIColor *)titleReadyPlayCor{
    if (!_titleReadyPlayCor) {
        _titleReadyPlayCor = UIColor.greenColor;
    }return _titleReadyPlayCor;
}

-(UIFont *)titleLabelReadyPlayFont{
    if (!_titleLabelReadyPlayFont) {
        _titleLabelReadyPlayFont = [UIFont systemFontOfSize:5 weight:UIFontWeightRegular];
    }return _titleLabelReadyPlayFont;
}

-(UIColor *)bgReadyPlayCor{
    if (!_bgReadyPlayCor) {
        _bgReadyPlayCor = UIColor.redColor;
    }return _bgReadyPlayCor;
}

-(CGFloat)layerCornerReadyPlayRadius{
    if (!_layerCornerReadyPlayRadius) {
        _layerCornerReadyPlayRadius = 6.f;
    }return _layerCornerReadyPlayRadius;
}

-(CGFloat)layerBorderReadyPlayWidth{
    if (!_layerBorderReadyPlayWidth) {
        _layerBorderReadyPlayWidth = 0.5f;
    }return _layerBorderReadyPlayWidth;
}
/// 计时器进行中
-(UIColor *)layerBorderRunningCor{
    if (!_layerBorderRunningCor) {
        _layerBorderRunningCor = self.layerBorderReadyPlayCor;
    }return _layerBorderRunningCor;
}

-(UIColor *)titleRunningCor{
    if (!_titleRunningCor) {
        _titleRunningCor = self.titleReadyPlayCor;
    }return _titleRunningCor;
}

-(UIFont *)titleLabelRunningFont{
    if (!_titleLabelRunningFont) {
        _titleLabelRunningFont = self.titleLabelReadyPlayFont;
    }return _titleLabelRunningFont;
}

-(UIColor *)bgRunningCor{
    if (!_bgRunningCor) {
        _bgRunningCor = self.bgReadyPlayCor;
    }return _bgRunningCor;
}

-(CGFloat)layerBorderRunningWidth{
    if (!_layerBorderRunningWidth) {
        _layerBorderRunningWidth = self.layerBorderReadyPlayWidth;
    }return _layerBorderRunningWidth;
}

-(CGFloat)layerCornerRunningRadius{
    if (!_layerCornerRunningRadius) {
        _layerCornerRunningRadius = self.layerCornerReadyPlayRadius;
    }return _layerCornerRunningRadius;
}
/// 计时器结束
-(UIColor *)layerBorderEndCor{
    if (!_layerBorderEndCor) {
        _layerBorderEndCor = self.layerBorderReadyPlayCor;
    }return _layerBorderEndCor;
}

-(UIColor *)titleEndCor{
    if (!_titleEndCor) {
        _titleEndCor = self.titleReadyPlayCor;
    }return _titleEndCor;
}

-(UIFont *)titleLabelEndFont{
    if (!_titleLabelEndFont) {
        _titleLabelEndFont = self.titleLabelReadyPlayFont;
    }return _titleLabelEndFont;
}

-(UIColor *)bgEndCor{
    if (!_bgEndCor) {
        _bgEndCor = self.bgReadyPlayCor;
    }return _bgEndCor;
}

-(CGFloat)layerCornerEndRadius{
    if (!_layerCornerEndRadius) {
        _layerCornerEndRadius = self.layerCornerReadyPlayRadius;
    }return _layerCornerEndRadius;
}

-(CGFloat)layerBorderEndWidth{
    if (!_layerBorderEndWidth) {
        _layerBorderEndWidth = self.layerBorderReadyPlayWidth;
    }return _layerBorderEndWidth;
}

@end
