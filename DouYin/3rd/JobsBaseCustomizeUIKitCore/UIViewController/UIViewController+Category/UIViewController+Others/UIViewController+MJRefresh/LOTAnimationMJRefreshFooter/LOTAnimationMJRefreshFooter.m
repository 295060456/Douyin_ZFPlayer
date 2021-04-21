//
//  LOTAnimationMJRefreshFooter.m
//  DouYin
//
//  Created by Jobs on 2021/1/8.
//

#import "LOTAnimationMJRefreshFooter.h"

static const CGFloat OffsetBetweenStateLabelAndAnimationView = 5;//StateLabel 和 AnimationView 之间的间距

@interface LOTAnimationMJRefreshFooter ()

@property(nonatomic,strong)LOTAnimationView *animationView;
@property(nonatomic,copy)MKDataBlock refreshFooterBlock;

@end

@implementation LOTAnimationMJRefreshFooter

- (void)prepare{
    [super prepare];
    self.animationView.alpha = 1;
    self.gifView.alpha = 0;//屏蔽掉父类的gifView控件，否则将会有Gif图和Lottie动画一起出现
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
    self.stateLabel.mj_w = self.stateLabel.mj_textWidth;
    self.stateLabel.center = CGPointMake(self.mj_w / 2.0 + 15, self.mj_h / 2.0 + 0.0);
    self.animationView.mj_x = self.stateLabel.mj_x - OffsetBetweenStateLabelAndAnimationView - self.animationView.mj_w;
    self.animationView.centerY = self.stateLabel.centerY;
}
// 更新状态文案
- (void)updateStateLabelText{
    [self setTitle:self.refreshConfigModel.stateIdleTitle
          forState:MJRefreshStateIdle];//普通闲置状态
    [self setTitle:self.refreshConfigModel.pullingTitle
          forState:MJRefreshStatePulling];//松开就可以进行刷新的状态
    [self setTitle:self.refreshConfigModel.refreshingTitle
          forState:MJRefreshStateRefreshing];//正在刷新中的状态
    [self setTitle:self.refreshConfigModel.willRefreshTitle
          forState:MJRefreshStateWillRefresh];//即将刷新的状态
    [self setTitle:self.refreshConfigModel.noMoreDataTitle
          forState:MJRefreshStateNoMoreData];//所有数据加载完毕，没有更多的数据了
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
        case MJRefreshStateNoMoreData:
            break;
        default:
            break;
    }
}

- (void)beginRefreshing{
    [super beginRefreshing];
    if (self.refreshFooterBlock) {
        self.refreshFooterBlock(@(RefreshingType_beginRefreshing));
    }
}

- (void)endRefreshing{
    [super endRefreshing];
    if (self.refreshFooterBlock) {
        self.refreshFooterBlock(@(RefreshingType_endRefreshing));
    }
}

-(void)actionBlockRefreshFooter:(MKDataBlock)refreshFooterBlock{
    self.refreshFooterBlock = refreshFooterBlock;
}
#pragma mark —— lazyLoad
- (LOTAnimationView *)animationView{
    if (!_animationView) {
        NSString *filePaths = pathForBuddleIMG(nil,
                                               @"JsonRes",
                                               nil,
                                               @"下拉刷新.json");
        _animationView = [LOTAnimationView animationWithFilePath:filePaths];
        _animationView.loopAnimation = YES;
        _animationView.size = self.lOTAnimationViewSize;
        [self addSubview:_animationView];
    }return _animationView;
}

-(CGSize)lOTAnimationViewSize{
    if (CGSizeEqualToSize(_lOTAnimationViewSize, CGSizeZero)) {
        _lOTAnimationViewSize = CGSizeMake(30, 30);
    }return _lOTAnimationViewSize;
}

-(MJRefreshConfigModel *)refreshConfigModel{
    if (!_refreshConfigModel) {
        _refreshConfigModel = MJRefreshConfigModel.new;
    }return _refreshConfigModel;
}


@end
