//
//  PlayerAttributeMgr.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "PlayerAttributeMgr.h"

@interface PlayerAttributeMgr ()

@property(nonatomic,copy)NSArray *playableSuffixArray;//记录可以播放的视频后缀

@end

@implementation PlayerAttributeMgr

@synthesize assetURL = _assetURL;

+ (void)initialize{
    [KTVHTTPCache logSetConsoleLogEnable:NO];
    NSError *error = nil;
    [KTVHTTPCache proxyStart:&error];
    if (error) {
        NSLog(@"Proxy Start Failure, %@", error);
    }
    [KTVHTTPCache encodeSetURLConverter:^NSURL *(NSURL *URL) {
//        NSLog(@"URL Filter reviced URL : %@", URL);
        return URL;
    }];
    [KTVHTTPCache downloadSetUnacceptableContentTypeDisposer:^BOOL(NSURL *URL,
                                                                   NSString *contentType) {
        return NO;
    }];
    // 设置缓存最大容量
    [KTVHTTPCache cacheSetMaxCacheLength:1024 * 1024 * 1024];
}

- (void)setAssetURL:(NSURL *)assetURL{
    // 如果有缓存，直接取本地缓存
    NSURL *url = [KTVHTTPCache cacheCompleteFileURLWithURL:assetURL];
    NSString *suffix = [url pathExtension];
    if (url && [self isPlayableSuffix:suffix]) {
        _assetURL = url;
    }else {
        // 设置代理
        _assetURL = [KTVHTTPCache proxyURLWithOriginalURL:assetURL];
    }
}

-(BOOL)isPlayableSuffix:(NSString *)suffix{
    if ([NSString isNullString:suffix]) {
        return NO;
    }return [self.playableSuffixArray containsObject:[suffix uppercaseString]];
}

-(NSArray *)playableSuffixArray{
    if (!_playableSuffixArray) {
        _playableSuffixArray = @[@"WMV",@"AVI",@"MKV",@"RMVB",@"RM",@"XVID",@"MP4",@"3GP",@"MPG"];
    }return _playableSuffixArray;
}

@end

//// ZFPlayerMediaPlayback 协议属性
//@synthesize view                           = _view;
//@synthesize volume                         = _volume;
//@synthesize muted                          = _muted;
//@synthesize rate                           = _rate;
//@synthesize currentTime                    = _currentTime;
//@synthesize totalTime                      = _totalTime;
//@synthesize bufferTime                     = _bufferTime;
//@synthesize seekTime                       = _seekTime;
//@synthesize isPlaying                      = _isPlaying;
//@synthesize scalingMode                    = _scalingMode;
//@synthesize isPreparedToPlay               = _isPreparedToPlay;
////@property (nonatomic) BOOL shouldAutoPlay;
//@synthesize assetURL                       = _assetURL;
//@synthesize presentationSize               = _presentationSize;
//@synthesize playState                      = _playState;
//@synthesize loadState                      = _loadState;
//@synthesize playerPrepareToPlay            = _playerPrepareToPlay;
//@synthesize playerReadyToPlay              = _playerReadyToPlay;
//@synthesize playerPlayTimeChanged          = _playerPlayTimeChanged;
//@synthesize playerBufferTimeChanged        = _playerBufferTimeChanged;
//@synthesize playerPlayStateChanged         = _playerPlayStateChanged;
//@synthesize playerLoadStateChanged         = _playerLoadStateChanged;
//@synthesize playerPlayFailed               = _playerPlayFailed;
//@synthesize playerDidToEnd                 = _playerDidToEnd;
//@synthesize presentationSizeChanged        = _presentationSizeChanged;
 

//#pragma mark —— 来自 ZFPlayerMediaPlayback 协议 @required 属性
//- (UIView *)view {
//    if (!_view) {
//        _view = ZFPlayerPresentView.new;
//    }return _view;
//}
//
//- (void)setVolume:(float)volume {
//    _volume = MIN(MAX(0, volume), 1);
//    self.player.volume = volume;
//}
//
//- (void)setMuted:(BOOL)muted {
//    _muted = muted;
//    self.player.muted = muted;
//}
//
//- (float)rate {
//    return _rate == 0 ?1:_rate;
//}
//
//- (NSTimeInterval)currentTime {
//    NSTimeInterval sec = CMTimeGetSeconds(self.playerItem.currentTime);
//    if (isnan(sec) || sec < 0) {
//        return 0;
//    }return sec;
//}
//
//- (NSTimeInterval)totalTime {
//    NSTimeInterval sec = CMTimeGetSeconds(self.player.currentItem.duration);
//    if (isnan(sec)) {
//        return 0;
//    }return sec;
//}
//
////bufferTime
////seekTime
////isPlaying
////scalingMode
////isPreparedToPlay
////shouldAutoPlay 、
//
///// Replace the current playback address
//- (void)replaceCurrentAssetURL:(NSURL *)assetURL {
//    self.assetURL = assetURL;
//}
//
////presentationSize
////playState
////loadState
////playerPrepareToPlay
////playerReadyToPlay
////playerPlayTimeChanged
////playerBufferTimeChanged
////playerPlayStateChanged
////playerLoadStateChanged
////playerPlayFailed
////playerDidToEnd
////presentationSizeChanged

