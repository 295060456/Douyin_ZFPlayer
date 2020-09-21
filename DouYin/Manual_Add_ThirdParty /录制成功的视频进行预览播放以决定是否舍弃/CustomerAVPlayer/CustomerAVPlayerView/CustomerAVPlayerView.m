//
//  CustomerAVPlayer.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomerAVPlayerView.h"
#import "CustomerAVPlayerView+UIGestureRecognizerDelegate.h"

@interface CustomerAVPlayerView ()<UIGestureRecognizerDelegate>{
    
}

@property(nonatomic,copy)TwoDataBlock customerActionAVPlayerBlock;
@property(nonatomic,copy)NoResultBlock customerErrorAVPlayerBlock;

@property(nonatomic,strong)RepeatPlayer *repeatPlayer;
@property(nonatomic,strong)UITapGestureRecognizer *tapGR;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGR;
@property(nonatomic,strong)NSURL *movieURL;

@end

@implementation CustomerAVPlayerView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithURL:(NSURL *)movieURL
                 suspendVC:(UIViewController *)suspendVC{
    if (self = [super init]) {
        if ([NSString isNullString:movieURL.absoluteString]) {
            if (self.customerErrorAVPlayerBlock) {
                self.customerErrorAVPlayerBlock();
            }
        }else{
            self.movieURL = movieURL;
        }
        self.vc = suspendVC;
        self.isSuspend = NO;//默认不开启悬浮效果  在这里进行手动开启
        
        self.tapGR.enabled = YES;
        self.swipeGR.enabled = YES;
        self.isTap = NO;
        self.backgroundColor = kClearColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isSuspend) {
        //开启悬浮效果
        self.panRcognize.enabled = YES;//悬浮效果必须要的参数
    }
    [self.repeatPlayer play];
}

-(void)actionCustomerAVPlayerBlock:(TwoDataBlock)customerActionAVPlayerBlock{
    self.customerActionAVPlayerBlock = customerActionAVPlayerBlock;
}

-(void)errorCustomerAVPlayerBlock:(NoResultBlock)customerErrorAVPlayerBlock{
    self.customerErrorAVPlayerBlock = customerErrorAVPlayerBlock;
}

-(void)play{
    [self.repeatPlayer play];
}

-(void)pause{
    [self.repeatPlayer pause];
}
#pragma mark —— 点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{

}
///点击事件
-(void)tapGRClickEvent:(UITapGestureRecognizer *)sender{
    if (self.customerActionAVPlayerBlock) {
        self.customerActionAVPlayerBlock(self,sender);
    }
    self.isTap = !self.isTap;
}
///轻扫事件
-(void)swipeGREvent:(UISwipeGestureRecognizer *)sender{
    if (self.customerActionAVPlayerBlock) {
        self.customerActionAVPlayerBlock(self,sender);
    }
    self.isTap = !self.isTap;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    if (@available(iOS 11.0, *)) {
        [p seekToTime:kCMTimeZero
    completionHandler:^(BOOL finished) {
            
        }];
    }else{
        [p seekToTime:kCMTimeZero];
    }
}

-(void)setIsSuspend:(BOOL)isSuspend{
    _isSuspend = isSuspend;
    if (_isSuspend) {
        //开启悬浮效果
        self.panRcognize.enabled = YES;//悬浮效果必须要的参数
    }else{
        self.vc = nil;
    }
}
#pragma mark —— lazyLoad
-(RepeatPlayer *)repeatPlayer{
    if (!_repeatPlayer) {
        _repeatPlayer = [[RepeatPlayer alloc] initWithSrc:self.movieURL];

        //self.repeatPlayer.autoPlay = true;
        [_repeatPlayer showInView:self];
    }return _repeatPlayer;
}

-(UITapGestureRecognizer *)tapGR{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(tapGRClickEvent:)];
        _tapGR.numberOfTouchesRequired = 1;//手指数
        _tapGR.numberOfTapsRequired = 1;//tap次数
        _tapGR.delegate = self;
        [self addGestureRecognizer:_tapGR];
    }return _tapGR;
}

-(UISwipeGestureRecognizer *)swipeGR{
    if (!_swipeGR) {
        _swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(swipeGREvent:)];
        _swipeGR.numberOfTouchesRequired = 1;
        //设置轻扫方向(默认是从左往右)
        _swipeGR.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_swipeGR];
    }return _swipeGR;
}


@end
