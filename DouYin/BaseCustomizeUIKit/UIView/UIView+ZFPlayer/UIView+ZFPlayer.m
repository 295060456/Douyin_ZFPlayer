//
//  UIView+ZFPlayer.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "UIView+ZFPlayer.h"
#import <objc/runtime.h>

@implementation UIView (ZFPlayer)

static char *UIView_ZFPlayer_player = "UIView_ZFPlayer_player";
static char *UIView_ZFPlayer_playerManager = "UIView_ZFPlayer_playerManager";
static char *UIView_ZFPlayer_customPlayerControlView = "UIView_ZFPlayer_customPlayerControlView";

@dynamic player;
@dynamic playerManager;
@dynamic customPlayerControlView;

-(void)enterBackgroundStopPlayer{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification:)
                                                 name:UBLEnterBackgroundStopPlayer
                                               object:nil];
}

-(void)notification:(NSNotification *)notification{
    [self.playerManager stop];
}
#pragma mark —— @property(nonatomic,strong,nullable)ZFPlayerController *player;
-(ZFPlayerController *)player{
    ZFPlayerController *Player = objc_getAssociatedObject(self, UIView_ZFPlayer_player);
    if (!Player) {
        
        @weakify(self)
        Player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                     containerView:self];
        Player.controlView = self.customPlayerControlView;
        NSLog(@"%@",Player.controlView);
        Player.muted = YES;//静音播放
        [Player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
        
        objc_setAssociatedObject(self,
                                 UIView_ZFPlayer_player,
                                 Player,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Player;
}

-(void)setPlayer:(ZFPlayerController *)player{
    objc_setAssociatedObject(self,
                             UIView_ZFPlayer_player,
                             player,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong,nullable)ZFAVPlayerManager *playerManager;
-(ZFAVPlayerManager *)playerManager{
    ZFAVPlayerManager *PlayerManager = objc_getAssociatedObject(self, UIView_ZFPlayer_playerManager);
    if (!PlayerManager) {
        PlayerManager = ZFAVPlayerManager.new;
        PlayerManager.shouldAutoPlay = YES;
        
//        {//可用
//            NSString *str = @"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4";//苹果官方给出的测试地址；都可用
//            PlayerManager.assetURL = [NSURL URLWithString:str];
//        }

        {//可用
//            PlayerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X" ofType:@"mp4"]];
        }

//        {//eddy 给我的
//            PlayerManager.assetURL = [NSURL URLWithString:self.tempStr];
//        }
        
        objc_setAssociatedObject(self,
                                 UIView_ZFPlayer_playerManager,
                                 PlayerManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PlayerManager;
}

-(void)setPlayerManager:(ZFAVPlayerManager *)playerManager{
    objc_setAssociatedObject(self,
                             UIView_ZFPlayer_playerManager,
                             playerManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
-(CustomZFPlayerControlView *)customPlayerControlView{
    CustomZFPlayerControlView *playerControlView = objc_getAssociatedObject(self, UIView_ZFPlayer_customPlayerControlView);
    if (!playerControlView) {
        playerControlView = CustomZFPlayerControlView.new;
//        playerControlView.frame = self.bounds;
        objc_setAssociatedObject(self,
                                 UIView_ZFPlayer_customPlayerControlView,
                                 playerControlView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return playerControlView;
}

-(void)setCustomPlayerControlView:(CustomZFPlayerControlView *)customPlayerControlView{
    objc_setAssociatedObject(self,
                             UIView_ZFPlayer_customPlayerControlView,
                             customPlayerControlView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end



