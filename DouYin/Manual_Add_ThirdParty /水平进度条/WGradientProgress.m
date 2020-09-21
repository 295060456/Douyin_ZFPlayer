//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"

@interface WGradientProgress ()

@property(nonatomic,strong)CALayer *roadLayer;//跑道 即将运行的轨迹
@property(nonatomic,strong)CALayer *fenceLayer;//栅栏
@property(nonatomic,strong)CAGradientLayer *__block gradLayer;//通过改变layer的宽度来实现进度 运动员

@property(nonatomic,strong)NSTimerManager *nsTimerManager_color;//主管线条颜色的翻滚
@property(nonatomic,strong)NSTimerManager *nsTimerManager_length;//主管线条长度的递增
@property(nonatomic,strong)NSMutableArray *colors;
@property(nonatomic,copy)TwoDataBlock WGradientProgressBlock;

@end

@implementation WGradientProgress

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = KBrownColor;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;//自动调整view的宽度，保证左边距和右边距不变
    }return self;
}

-(void)makeTimer_color{
    //启动方式——1
    [NSTimerManager nsTimeStart:self.nsTimerManager_color.nsTimer
                    withRunLoop:nil];
    //启动方式——2
//    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)makeTimer_length{
    //启动方式——1
    [NSTimerManager nsTimeStart:self.nsTimerManager_length.nsTimer
                    withRunLoop:nil];
    //启动方式——2
//    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)showOnParent{
    if (self.isShowRoad) {
        self.roadLayer.hidden = NO;
    }
    
    self.gradLayer.hidden = NO;
    
    if (self.isShowFence) {
        self.fenceLayer.hidden = NO;
    }
}
//开始
-(void)start{
    if (self.progressType == WGradientProgressType_colorRoll) {
        [self makeTimer_color];
    }
    [self makeTimer_length];
}
//暂停
-(void)pause{
    [NSTimerManager nsTimePause:self.nsTimerManager_length.nsTimer];
}
//重新开始
-(void)resume{
    [NSTimerManager nsTimecontinue:self.nsTimerManager_length.nsTimer];
}
//归位
-(void)reset{
    //定时器归位
    [self.nsTimerManager_color nsTimeDestroy];
    [self.nsTimerManager_length nsTimeDestroy];
    //UI归位
    self.gradLayer.frame = CGRectZero;
}
///旋转 以适应不同方向的直线型进度条
-(void)setTransformRadians:(CGFloat)transformRadians{
    [UIView setTransform:transformRadians
                 forView:self];
}

-(void)hide{
    [NSTimerManager nsTimePause:self.nsTimerManager_color.nsTimer];
    if ([self superview]) {
        [self removeFromSuperview];
    }
}

-(void)setProgress:(CGFloat)progress{
    if (progress < 0) {
        progress = 0;
    }
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    self.gradLayer.frame = CGRectMake(0,
                                      0,
                                      progress * self.width,
                                      self.mj_h);
}

-(void)timerFunc{
    CAGradientLayer *gradLayer = self.gradLayer;
    NSMutableArray *copyArray = [NSMutableArray arrayWithArray:[gradLayer colors]];
    UIColor *lastColor = [copyArray lastObject];
    [copyArray removeLastObject];
    if (lastColor) {
        [copyArray insertObject:lastColor
                        atIndex:0];
    }
    self.gradLayer.colors = copyArray;
}

-(void)actionWGradientProgressBlock:(TwoDataBlock)WGradientProgressBlock{
    _WGradientProgressBlock = WGradientProgressBlock;
}
#pragma mark —— lazyLoad
-(CGFloat)increment{
    if (_increment == 0) {
        _increment = 0.1;
    }return _increment;
}

-(NSTimeInterval)color_timeInterval{
    if (_color_timeInterval == 0) {
        _color_timeInterval = 0.03;
    }return _color_timeInterval;
}

-(NSTimeInterval)length_timeInterval{
    if (_length_timeInterval == 0) {
        _length_timeInterval = 1;
    }return _length_timeInterval;
}

-(NSTimeInterval)length_timeSecIntervalSinceDate{
    if (_length_timeSecIntervalSinceDate == 0) {
        _length_timeSecIntervalSinceDate = 2;
    }return _length_timeSecIntervalSinceDate;
}

-(NSTimerManager *)nsTimerManager_color{
    if (!_nsTimerManager_color) {
        _nsTimerManager_color = NSTimerManager.new;
        _nsTimerManager_color.timeInterval = self.color_timeInterval;
        _nsTimerManager_color.timerStyle = TimerStyle_clockwise;
        @weakify(self)
        [_nsTimerManager_color actionNSTimerManagerRunningBlock:^(id data) {
            NSLog(@"你好");
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
//                NSTimerManager *timerManager = (NSTimerManager *)data;
//                timerManager.anticlockwiseTime;
                [self timerFunc];
            }
        }];
        [_nsTimerManager_color actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager_color;
}

-(NSTimerManager *)nsTimerManager_length{
    if (!_nsTimerManager_length) {
        _nsTimerManager_length = NSTimerManager.new;
        _nsTimerManager_length.timeInterval = self.length_timeInterval;
        _nsTimerManager_length.timeSecIntervalSinceDate = self.length_timeSecIntervalSinceDate;
        _nsTimerManager_length.timerStyle = TimerStyle_clockwise;
        @weakify(self)
        [_nsTimerManager_length actionNSTimerManagerRunningBlock:^(id data) {
            NSLog(@"你好");
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
//                NSTimerManager *timerManager = (NSTimerManager *)data;
//                timerManager.anticlockwiseTime;
                
                if (self.progress < 1) {
                    [self start];
                    
                    if (self.WGradientProgressBlock) {
                        self.WGradientProgressBlock(@(self.progress),self.gradLayer);
                    }
                    
                    self.progress += self.increment;
                }else{
                    //销毁
                    [self.nsTimerManager_length nsTimeDestroy];
                }
            }
        }];
        [_nsTimerManager_length actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager_length;
}

-(NSMutableArray *)colors{
    if (!_colors) {
        _colors = NSMutableArray.array;
        for (NSInteger deg = 0; deg <= 360; deg += 5) {
            if (self.progressType == WGradientProgressType_colorNormal) {
                [_colors addObject:(id)self.progressColor.CGColor];
            }else{
                UIColor *color = [UIColor colorWithHue:1.0 * deg / 360.0
                                            saturation:1.0
                                            brightness:1.0
                                                 alpha:1.0];
                [_colors addObject:(id)color.CGColor];
            }
        }
    }return _colors;;
}

-(CAGradientLayer *)gradLayer{
    if (!_gradLayer) {
        _gradLayer = CAGradientLayer.layer;
        _gradLayer.frame = CGRectZero;
        _gradLayer.borderWidth = 1;
        _gradLayer.startPoint = CGPointMake(0, 0);
        _gradLayer.endPoint = CGPointMake(1, 1);
        _gradLayer.colors = [NSArray arrayWithArray:self.colors];
        [self.layer addSublayer:_gradLayer];
    }return _gradLayer;
}

-(CALayer *)roadLayer{
    if (!_roadLayer) {
        _roadLayer = CALayer.layer;
        _roadLayer.frame = self.bounds;
        _roadLayer.backgroundColor = KLightGrayColor.CGColor;
        [self.layer addSublayer:_roadLayer];
    }return _roadLayer;
}

-(CALayer *)fenceLayer{
    if (!_fenceLayer) {
        _fenceLayer = CALayer.layer;
        _fenceLayer.frame = CGRectMake(self.fenceLayer_x,
                                       0,
                                       self.fenceLayer_width,
                                       self.mj_h);
        _fenceLayer.backgroundColor = self.fenceLayerColor.CGColor;
        [self.gradLayer addSublayer:_fenceLayer];
    }return _fenceLayer;;
}

-(CGFloat)fenceLayer_x{
    if (_fenceLayer_x == 0) {
        _fenceLayer_x = self.mj_w * 0.3;
    }return _fenceLayer_x;
}

-(CGFloat)fenceLayer_width{
    if (_fenceLayer_width == 0) {
        _fenceLayer_width = 5;
    }return _fenceLayer_width;
}

-(UIColor *)fenceLayerColor{
    if (!_fenceLayerColor) {
        _fenceLayerColor = RandomColor;
    }return _fenceLayerColor;
}

-(UIColor *)progressColor{
    if (!_progressColor) {
        _progressColor = kRedColor;
    }return _progressColor;
}

@end
