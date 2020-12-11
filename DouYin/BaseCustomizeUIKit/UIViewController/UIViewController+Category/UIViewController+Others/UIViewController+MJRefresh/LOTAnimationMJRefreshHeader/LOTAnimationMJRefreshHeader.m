//
//  UBLCustomGifHeader.m
//  DouYin
//
//  Created by John on 2020/11/14.
//

#import "LOTAnimationMJRefreshHeader.h"

static const CGFloat OffsetBetweenStateLabelAndAnimationView = 5;//StateLabel 和 AnimationView 之间的间距

/// 下拉刷新动画
@interface LOTAnimationMJRefreshHeader ()
/// 加载 Json 动画
@property(nonatomic,strong)LOTAnimationView *animationView;
/// 加载过程中中间显示的随机文案
@property(nonatomic,strong)NSString *randomTitle;

@end

@implementation LOTAnimationMJRefreshHeader

- (void)prepare{
    [super prepare];
    self.animationView.alpha = 1;
    @weakify(self)
    self.endRefreshingCompletionBlock = ^{
        @strongify(self)
        [self updateStateLabelText];
    };
    self.stateLabel.font = [UIFont systemFontOfSize:14
                                             weight:UIFontWeightRegular];
    [self updateStateLabelText];
}
// 执行重新给子视图布局的时候
- (void)placeSubviews{
    [super placeSubviews];
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.mj_w = self.stateLabel.mj_textWidth;
    self.stateLabel.center = CGPointMake(self.mj_w / 2.0 + 15, self.mj_h / 2.0 + 0.0);
    self.animationView.mj_x = self.stateLabel.mj_x - OffsetBetweenStateLabelAndAnimationView - self.animationView.mj_w;
    self.animationView.centerY = self.stateLabel.centerY;
}

- (void)beginRefreshing{
    [super beginRefreshing];
}

- (void)endRefreshing{
    [super endRefreshing];
}
// 更新状态文案
- (void)updateStateLabelText{
    [self getRandomTitle];
    [self setTitle:self.randomTitle forState:MJRefreshStateIdle];
    [self setTitle:self.randomTitle forState:MJRefreshStatePulling];
    [self setTitle:self.randomTitle forState:MJRefreshStateRefreshing];
}
/**
 MJRefreshStateIdle,   //   普通闲置状态
 MJRefreshStatePulling,   //   松开就可以进行刷新的状态
 MJRefreshStateRefreshing,   //   正在刷新中的状态
 MJRefreshStateWillRefresh,   //   即将刷新的状态
 MJRefreshStateNoMoreData   //   所有数据加载完毕，没有更多的数据了
 */
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle: // 刷新完毕
            [self.animationView stop];
            break;
        case MJRefreshStatePulling: // 下拉达到可触发刷新
            [self.animationView play];
            break;
        case MJRefreshStateRefreshing: // 松手可以刷新
            [self.animationView play];
            break;
        case MJRefreshStateWillRefresh:
            break;
        default:
            break;
    }
}
// 获取随机加载文案
- (void)getRandomTitle{
    
    NSMutableArray *textMutArr = NSMutableArray.array;
    [textMutArr addObject:@"快速加载中，不要急"];
    [textMutArr addObject:@"正在快速加载中，不要慌"];
    [textMutArr addObject:@"快马加鞭加载中"];
    
    NSInteger index = arc4random() % textMutArr.count;
    self.randomTitle = textMutArr[index];
}
#pragma mark —— lazyLoad
- (LOTAnimationView *)animationView{
    if (!_animationView) {
        NSString *filePaths = pathForBuddleIMG(nil, @"JsonRes", nil, @"下拉刷新.json");
        _animationView = [LOTAnimationView animationWithFilePath:filePaths];
        _animationView.loopAnimation = YES;
        _animationView.size = CGSizeMake(30, 30);
        [self addSubview:_animationView];
    }return _animationView;
}

@end
