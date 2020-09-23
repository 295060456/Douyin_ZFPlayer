//
//  PlayerCell.m
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "PlayerCell.h"
#import "CustomZFPlayerControlView.h"
#import "ToolMacro.h"

@interface PlayerCell (){
    
}

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;

@end

@implementation PlayerCell

+(instancetype)cellWith:(UITableView *)tableView{
    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[PlayerCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RandomColor;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCREEN_HEIGHT;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.label.text = [NSString stringWithFormat:@"%d",[dic[@"index"] intValue]];
    }
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

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;
        
//        _playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];

//        if ([[UIDevice platformString] containsString:@"iPhone 11"]) {
//            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X"
//                                                                                             ofType:@"mp4"]];
//        }else{
//            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"非iph_X"
//                                                                                             ofType:@"mp4"]];
//        }
        if (kStatusBarHeight > 20.0) {
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
//        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data) {
//            @strongify(self)
        }];
    }return _customPlayerControlView;
}


@end
