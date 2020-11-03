//
//  UIView+ZFPlayer.h
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import <UIKit/UIKit.h>

#pragma mark —— ZFPlayer 播放器相关
//Core
#import "ZFPlayer.h"
//AVPlayer
#import <ZFPlayer/ZFAVPlayerManager.h>
//ijkplayer
#import <ZFPlayer/ZFIJKPlayerManager.h>
//ControlView
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFLandScapeControlView.h>
#import <ZFPlayer/ZFLoadingView.h>
#import <ZFPlayer/ZFNetworkSpeedMonitor.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPortraitControlView.h>
#import <ZFPlayer/ZFSliderView.h>
#import <ZFPlayer/ZFSmallFloatControlView.h>
#import <ZFPlayer/ZFSpeedLoadingView.h>
#import <ZFPlayer/ZFUtilities.h>
#import <ZFPlayer/ZFVolumeBrightnessView.h>

#import "CustomZFPlayerControlView.h"//播放器控制层

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZFPlayer)

@property(nonatomic,strong,nullable)ZFPlayerController *player;
@property(nonatomic,strong,nullable)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;

@end

NS_ASSUME_NONNULL_END
