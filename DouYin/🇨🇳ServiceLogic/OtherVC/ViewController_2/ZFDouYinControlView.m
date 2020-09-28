//
//  ZFDouYinControlView.m
//  ZFPlayer_Example
//
//  Created by 任子丰 on 2018/6/4.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFDouYinControlView.h"
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFUtilities.h>
#import "ZFLoadingView.h"
#import <ZFPlayer/ZFSliderView.h>
#import <ZFPlayer/ZFPlayerController.h>

@interface ZFDouYinControlView ()

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) ZFSliderView *sliderView;

@end

@implementation ZFDouYinControlView
@synthesize player = _player;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.playBtn];
        [self addSubview:self.sliderView];
        [self resetControlView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;
    
    min_w = 100;
    min_h = 100;
    self.playBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.playBtn.center = self.center;
    
    min_x = 0;
    min_y = min_view_h - 80;
    min_w = min_view_w;
    min_h = 1;
    self.sliderView.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

- (void)resetControlView {
    self.playBtn.hidden = YES;
    self.sliderView.value = 0;
    self.sliderView.bufferValue = 0;
}

/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if ((state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) && videoPlayer.currentPlayerManager.isPlaying) {
        [self.sliderView startAnimating];
    } else {
        [self.sliderView stopAnimating];
    }
}

/// 播放进度改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    self.sliderView.value = videoPlayer.progress;
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (self.player.currentPlayerManager.isPlaying) {
        [self.player.currentPlayerManager pause];
        self.playBtn.hidden = NO;
        self.playBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        [UIView animateWithDuration:0.2f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.playBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
    } else {
        [self.player.currentPlayerManager play];
        self.playBtn.hidden = YES;
    }
}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
}

- (void)showCoverViewWithUrl:(NSString *)coverUrl {
    [self.player.currentPlayerManager.view.coverImageView setImageWithURLString:coverUrl placeholder:[UIImage imageNamed:@"img_video_loading"]];
}

#pragma mark - getter

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.userInteractionEnabled = NO;
        [_playBtn setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateNormal];
    }
    return _playBtn;
}

- (ZFSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[ZFSliderView alloc] init];
        _sliderView.maximumTrackTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        _sliderView.minimumTrackTintColor = [UIColor whiteColor];
        _sliderView.bufferTrackTintColor  = [UIColor clearColor];
        _sliderView.sliderHeight = 1;
        _sliderView.isHideSliderBlock = NO;
    }
    return _sliderView;
}

@end
