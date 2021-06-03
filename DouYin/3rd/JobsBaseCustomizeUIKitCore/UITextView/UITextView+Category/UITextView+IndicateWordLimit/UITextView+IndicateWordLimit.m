//
//  UITextView+IndicateWordLimit.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/25.
//

#import "UITextView+IndicateWordLimit.h"
#import <objc/runtime.h>

@implementation UITextView (IndicateWordLimit)

static char *UITextView_IndicateWordLimit_indicateWordLimitLab = "UITextView_IndicateWordLimit_indicateWordLimitLab";
@dynamic indicateWordLimitLab;

static char *UITextView_IndicateWordLimit_currentWordNum = "UITextView_IndicateWordLimit_currentWordNum";
@dynamic currentWordNum;

static char *UITextView_IndicateWordLimit_wordLimitNum = "UITextView_IndicateWordLimit_wordLimitNum";
@dynamic wordLimitNum;

static char *UITextView_IndicateWordLimit_offsetX = "UITextView_IndicateWordLimit_offsetX";
@dynamic offsetX;

static char *UITextView_IndicateWordLimit_offsetY = "UITextView_IndicateWordLimit_offsetY";
@dynamic offsetY;

#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UILabel *indicateWordLimitLab;
-(UILabel *)indicateWordLimitLab{
    UILabel *IndicateWordLimitLab = objc_getAssociatedObject(self, UITextView_IndicateWordLimit_indicateWordLimitLab);
    if (!IndicateWordLimitLab) {
        IndicateWordLimitLab = UILabel.new;
        IndicateWordLimitLab.textColor = RGB_COLOR(132, 134, 140);
        IndicateWordLimitLab.textAlignment = NSTextAlignmentCenter;
        IndicateWordLimitLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        IndicateWordLimitLab.text = [NSString stringWithFormat:@"   %ld / %ld   ",self.currentWordNum,self.wordLimitNum];
        [IndicateWordLimitLab sizeToFit];
        [self addSubview:IndicateWordLimitLab];
        IndicateWordLimitLab.right = self.width - self.offsetX;
        IndicateWordLimitLab.bottom = self.height - self.offsetY;
        objc_setAssociatedObject(self,
                                 UITextView_IndicateWordLimit_indicateWordLimitLab,
                                 IndicateWordLimitLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return IndicateWordLimitLab;
}

-(void)setIndicateWordLimitLab:(UILabel *)indicateWordLimitLab{
    objc_setAssociatedObject(self,
                             UITextView_IndicateWordLimit_indicateWordLimitLab,
                             indicateWordLimitLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger currentWordNum;//当前输入的字符数
-(NSInteger)currentWordNum{
    return [objc_getAssociatedObject(self, UITextView_IndicateWordLimit_currentWordNum) integerValue];
}

-(void)setCurrentWordNum:(NSInteger)currentWordNum{
    
    self.indicateWordLimitLab.text = [NSString stringWithFormat:@"   %ld / %ld   ",currentWordNum,self.wordLimitNum];
    [self.indicateWordLimitLab sizeToFit];
    
    objc_setAssociatedObject(self,
                             UITextView_IndicateWordLimit_currentWordNum,
                             [NSNumber numberWithInteger:currentWordNum],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger wordimitNum;//字符输入上限
-(NSInteger)wordLimitNum{
    NSInteger WordLimitNum = [objc_getAssociatedObject(self, UITextView_IndicateWordLimit_wordLimitNum) integerValue];
    if (!WordLimitNum) {
        WordLimitNum = 500;
        objc_setAssociatedObject(self,
                                 UITextView_IndicateWordLimit_wordLimitNum,
                                 [NSNumber numberWithInteger:WordLimitNum],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return WordLimitNum;
}

-(void)setWordLimitNum:(NSInteger)wordLimitNum{
    objc_setAssociatedObject(self,
                             UITextView_IndicateWordLimit_wordLimitNum,
                             [NSNumber numberWithInteger:wordLimitNum],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat offsetX;
-(CGFloat)offsetX{
    CGFloat OffsetX = [objc_getAssociatedObject(self, UITextView_IndicateWordLimit_offsetX) floatValue];
    if (!OffsetX) {
        OffsetX = KWidth(19.1);
        objc_setAssociatedObject(self,
                                 UITextView_IndicateWordLimit_offsetX,
                                 [NSNumber numberWithFloat:OffsetX],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return OffsetX;
}

-(void)setOffsetX:(CGFloat)offsetX{
    objc_setAssociatedObject(self,
                             UITextView_IndicateWordLimit_offsetX,
                             [NSNumber numberWithFloat:offsetX],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat offsetY;
-(CGFloat)offsetY{
    CGFloat OffsetY = [objc_getAssociatedObject(self, UITextView_IndicateWordLimit_offsetY) floatValue];
    if (!OffsetY) {
        OffsetY = KWidth(13.1);
        objc_setAssociatedObject(self,
                                 UITextView_IndicateWordLimit_offsetY,
                                 [NSNumber numberWithFloat:OffsetY],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return OffsetY;
}

-(void)setOffsetY:(CGFloat)offsetY{
    objc_setAssociatedObject(self,
                             UITextView_IndicateWordLimit_offsetY,
                             [NSNumber numberWithFloat:offsetY],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
