//
//  RepeatPlayer.m
//  ReatPlayerDemo
//
//  Created by Shouqiang Wei on 15/12/16.
//  Copyright © 2015年 教练助理. All rights reserved.
//

#import "RepeatPlayer.h"

@interface RepeatPlayer()

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItem;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@property(nonatomic,strong)NSURL *src;

@end

@implementation RepeatPlayer

+(instancetype)showInView:(UIView *)containerView
                      src:(NSURL *)src{
    RepeatPlayer *repeatPlayer = [[RepeatPlayer alloc] initWithSrc:src];
    [repeatPlayer showInView:containerView];
    return repeatPlayer;
}

-(instancetype)initWithSrc:(NSURL *)src{
    if (self = [super init]) {
        self.src = src;
        self.playerLayer.hidden = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:self.player.currentItem];
    }
    return self;
}

-(void)showInView:(UIView *)containerView{
    self.playerLayer.frame = containerView.layer.bounds;
    [containerView.layer addSublayer:self.playerLayer];
    if(self.autoPlay){
        [self.player play];
    }
}

- (BOOL)autoPlay{
    return  YES;
}

-(void)play{
    [self.player play];
}

-(void)pause{
    [self.player pause];
}
///播放结束，自动循环播放。
- (void)moviePlayDidEnd:(NSNotification *)notification{
    AVPlayerItem *item = [notification object];
    [item seekToTime:kCMTimeZero];
    [self.player play];
}
#pragma mark —— observer of player
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
}
#pragma mark —— lazyLoad
-(AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }return _playerLayer;
}

-(AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
        _player.volume = self.playerVolume;
        [_player.currentItem addObserver:self
                              forKeyPath:AVPlayerItemDidPlayToEndTimeNotification
                                 options:NSKeyValueObservingOptionNew
                                 context:nil];
    }return _player;
}

-(AVPlayerItem *)playerItem{
    if (!_playerItem) {
        _playerItem = [AVPlayerItem playerItemWithURL:self.src];
        [_playerItem addObserver:self
                      forKeyPath:@"status"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    }return _playerItem;
}

@end
