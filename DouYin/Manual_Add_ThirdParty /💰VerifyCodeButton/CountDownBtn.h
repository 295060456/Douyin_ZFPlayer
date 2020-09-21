//
//  VerifyCodeButton.h
//  ShengAi
//
//  Created by 刘赓 on 2018/12/12.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShowTimeType_SS = 0,//秒
    ShowTimeType_MMSS,//分秒
    ShowTimeType_HHMMSS,//时分秒
} ShowTimeType;

typedef enum : NSUInteger {
    CountDownBtnType_Normal = 0,//普通模式
    CountDownBtnType_CountDown,//倒计时模式
} CountDownBtnType;

NS_ASSUME_NONNULL_BEGIN

@interface CountDownBtn : UIButton

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,copy)NSString *titleBeginStr;
@property(nonatomic,copy)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
@property(nonatomic,copy)NSString *titleEndStr;
@property(nonatomic,strong)UIColor *titleColor;
//倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
@property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
@property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
@property(nonatomic,strong)UIColor *layerBorderColor;
@property(nonatomic,strong)UIFont *titleLabelFont;
@property(nonatomic,assign)CGFloat layerCornerRadius;
@property(nonatomic,assign)CGFloat layerBorderWidth;
@property(nonatomic,assign)ShowTimeType showTimeType;

- (void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数

-(instancetype)initWithStyle:(CountDownBtnType)style;


@end

NS_ASSUME_NONNULL_END
