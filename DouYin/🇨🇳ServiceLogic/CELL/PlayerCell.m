//
//  PlayerCell.m
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "PlayerCell.h"

#import "CustomZFPlayerControlView.h"
#import "PlayerAttributeMgr.h"

#import "ToolMacro.h"

@interface PlayerCell (){
    
}

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong,nullable)PlayerAttributeMgr *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,copy)TwoDataBlock playerCellBlock;
@property(nonatomic,strong)VideoModel_Core *videoModel_Core;

@end

@implementation PlayerCell

+(instancetype)cellWith:(UITableView *)tableView{
    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[PlayerCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RandomColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noti1)
                                                     name:@"noti1"
                                                   object:nil];
        
    }return cell;
}

-(void)noti1{
    NSLog(@"接收 不带参数的消息");
    [self.player.currentPlayerManager stop];
    
    self.player = nil;
    self.playerManager = nil;
    [self.customPlayerControlView removeFromSuperview];
    self.customPlayerControlView = nil;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCREEN_HEIGHT;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.label.text = [NSString stringWithFormat:@"%d",[dic[@"index"] intValue]];
        self.videoModel_Core = (VideoModel_Core *)dic[@"res"];
    }
}

-(void)actionBlockPlayerCell:(TwoDataBlock)playerCellBlock{
    _playerCellBlock = playerCellBlock;
}
#pragma mark —— lazyLoad
-(UILabel *)label{
    if (!_label) {
        _label = UILabel.new;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:100
                                        weight:UIFontWeightRegular];
        _label.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _label;
}

-(PlayerAttributeMgr *)playerManager{
    if (!_playerManager) {
        _playerManager = PlayerAttributeMgr.new;
        _playerManager.shouldAutoPlay = YES;
        
//        NSString *str = @"http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/0013.MP4";
//
//        _playerManager.assetURL = [NSURL URLWithString:self.videoModel_Core.videoIdcUrl];

        if (kStatusBarHeight > 20.0) {//[[UIDevice platformString] containsString:@"iPhone 11"]
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"非iph_X"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @weakify(self)
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.contentView];
        _player.controlView = self.customPlayerControlView;
//        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(NSString *data, NSNumber *data2) {
            @strongify(self)
            if ([data isEqualToString:@"gestureEndedPan:panDirection:panLocation:"]) {
                if (data2.intValue == ZFPanMovingDirectionTop) {
                    if (self.playerCellBlock) {
                        self.playerCellBlock(@0,@(self.index));
                    }
                }else if (data2.intValue == ZFPanMovingDirectionBottom){
                    if (self.playerCellBlock) {
                        self.playerCellBlock(@1,@(self.index));
                    }
                }else{}
            }
        }];

    }return _customPlayerControlView;
}

@end
