//
//  UBLCustomGifHeader.m
//  DouYin
//
//  Created by John on 2020/11/14.
//

#import "UBLCustomGifHeader.h"
#import <Lottie/Lottie.h>

@interface UBLCustomGifHeader ()

/// 加载json 动画
@property (strong, nonatomic) LOTAnimationView *animationView;
/// 加载过程中中间显示的随机文案
@property (nonatomic, strong) NSString *randomTitle;

@end
@implementation UBLCustomGifHeader

#pragma mark - 初始化的时候执行
#pragma mark -- prepare
- (void)prepare{
    [super prepare];
    [self addSubview:self.animationView];
    WeakSelf;
    self.endRefreshingCompletionBlock = ^{
        [weakSelf updateStateLabelText];
    };
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    [self updateStateLabelText];
}

#pragma mark - layoutSubviews 执行重新给子视图布局的时候
#pragma mark -- placeSubviews
- (void)placeSubviews{
    [super placeSubviews];
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
    self.animationView.bounds = CGRectMake(50, 0, 60, 60);
    self.animationView.center = CGPointMake(120, self.mj_h/2.0);
    
    self.stateLabel.mj_w = self.stateLabel.mj_textWidth;
    
    self.stateLabel.center = CGPointMake(self.mj_w/2.0+15, self.mj_h/2.0 + 0.0);
    self.animationView.center = CGPointMake(self.stateLabel.mj_x-15-5, self.mj_h/2.0);

}
#pragma mark - 重写开始刷新方法
#pragma mark -- beginRefreshing
- (void)beginRefreshing{
    [super beginRefreshing];
}
#pragma mark - 重写结束刷新方法
#pragma mark -- endRefreshing
- (void)endRefreshing{
    [super endRefreshing];
}
#pragma mark - 更新状态文案
#pragma mark -- updateStateLabelText
- (void)updateStateLabelText{
    [self getRandomTitle];
    [self setTitle:self.randomTitle forState:MJRefreshStateIdle];
    [self setTitle:self.randomTitle forState:MJRefreshStatePulling];
    [self setTitle:self.randomTitle forState:MJRefreshStateRefreshing];
}
#pragma mark - 重新setter方法
#pragma mark -- setState
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

#pragma mark - 获取随机加载文案
#pragma mark -- getRandomTitle
- (void)getRandomTitle{
    NSArray *textArr = @[@"快速加载中，不要急",@"正在快速加载中，不要慌",@"快马加鞭加载中",@"1233快马加鞭加载中",@"哈哈哈快马加鞭加载中",@"哈哈哈快马加鞭加载中",@"哈1快马加鞭加载中",@"哈2快马加鞭加载中",@"哈3快马加鞭加载中",@"4快马加鞭加载中",@"哈哈5哈快马加鞭加载中",@"哈哈6哈快马加鞭加载中",@"哈哈7哈快马加鞭加载中",@"哈哈8哈快马加鞭加载中",@"哈哈哈9快马加鞭加载中",@"哈哈11哈快马加鞭加载中",@"哈哈12哈快马加鞭加载中",@"哈哈13哈快马加鞭加载中"];
    NSInteger index = arc4random() % textArr.count;
    self.randomTitle = textArr[index];

}

#pragma mark - 懒加载
#pragma mark -- lazy load
- (LOTAnimationView *)animationView{
    if (!_animationView) {
        NSString *filePath = nil;
         filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json" inDirectory:@"testjson"];
        _animationView = [LOTAnimationView animationWithFilePath:filePath];
        _animationView.loopAnimation = YES;
        _animationView.frame = CGRectMake(0, 0, 60, 60);
    }
    return _animationView;
}

@end
