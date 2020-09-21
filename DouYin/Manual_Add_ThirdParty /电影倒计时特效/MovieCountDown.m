//
//  movieCountDown.m
//  Timer
//
//  Created by Jobs on 2020/9/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MovieCountDown.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MovieCountDown ()

@property(nonatomic,strong)UILabel *countDown;
@property(nonatomic,strong)UIView *aphView;
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,copy)MKDataBlock movieCountDownFinishBlock;

@end

@implementation MovieCountDown

-(instancetype)init{
    if (self = [super init]) {
    }return self;
}

-(void)倒计时放大特效{
    [self makeTimer];
    [self secountDown];
}

-(void)makeTimer{
    //启动方式——1
    //    [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
    //                    withRunLoop:nil];
    //启动方式——2
    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)secountDown{
    if (!self.effectView) {
        NSAssert(0,@"检查属性 effectView 不能为空");
    }
}

-(void)getCuntDown:(NSInteger)second{
    self.countDown.text = [NSString stringWithFormat:@"%ld",(long)second];
    self.countDown.alpha = 1;
    self.aphView.alpha = 0;
    @weakify(self)
    [UIView animateWithDuration:0.8
                     animations:^{
        @strongify(self)
        self.countDown.alpha = 0.8;//透明度
        self.aphView.alpha = 0.1;
        self.countDown.transform = CGAffineTransformMakeScale(1.5, 1.5);//放大值
        self.aphView.transform = CGAffineTransformMakeScale(10, 10);//放大值
    } completion:^(BOOL finished) {
        @strongify(self)
        self.aphView.alpha = self.countDown.alpha =  0;
        self.countDown.transform = self.aphView.transform = CGAffineTransformIdentity;//回复原大小
    }];
}

-(void)actionMovieCountDownFinishBlock:(MKDataBlock)movieCountDownFinishBlock{
    _movieCountDownFinishBlock = movieCountDownFinishBlock;
}

#pragma mark —— lazyLoad
-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        _nsTimerManager.timerStyle = TimerStyle_anticlockwise;
        _nsTimerManager.anticlockwiseTime = 5;
        @weakify(self)
        [_nsTimerManager actionNSTimerManagerRunningBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
                NSTimerManager *timerManager = (NSTimerManager *)data;
                [self getCuntDown:(NSInteger)timerManager.anticlockwiseTime];
            }
        }];
        [_nsTimerManager actionNSTimerManagerFinishBlock:^(id data) {
            @strongify(self)
            NSLog(@"结束回调");
            if (self.movieCountDownFinishBlock) {
                self.movieCountDownFinishBlock(data);
            }
        }];
    }return _nsTimerManager;
}

-(UILabel *)countDown{
    if (!_countDown) {
        _countDown = UILabel.new;
        _countDown.textColor = self.countDownTextColor;;
        _countDown.font = [UIFont boldSystemFontOfSize:100];
        _countDown.textAlignment = 1;
        _countDown.x = (SCREEN_WIDTH - 100) / 2;
        _countDown.y = (SCREEN_HEIGHT - 100) / 2;
        _countDown.width = _countDown.height = 100;
        [self.effectView addSubview:_countDown];
    }return _countDown;
}

-(UIView *)aphView{
    if (!_aphView) {
        _aphView = UIView.new;
        _aphView.backgroundColor = self.aphViewBackgroundColor;
        _aphView.frame = CGRectMake(0,
                                    0,
                                    100,
                                    100);
        _aphView.centerX = _countDown.centerX;
        _aphView.centerY = _countDown.centerY;
        _aphView.alpha = 0;
        _aphView.layer.cornerRadius = 50.f;
        [self.effectView addSubview:_aphView];
    }return _aphView;
}

-(UIColor *)countDownTextColor{
    if (!_countDownTextColor) {
        _countDownTextColor = kRedColor;
    }return _countDownTextColor;
}

-(UIColor *)aphViewBackgroundColor{
    if (!_aphViewBackgroundColor) {
        _aphViewBackgroundColor = kClearColor;
    }return _aphViewBackgroundColor;
}


@end
