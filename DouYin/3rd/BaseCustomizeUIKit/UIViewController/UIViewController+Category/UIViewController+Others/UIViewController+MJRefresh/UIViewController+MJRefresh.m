//
//  UIViewController+MJRefresh.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+MJRefresh.h"

@implementation UIViewController (MJRefresh)

static char *UIViewController_MJRefresh_refreshConfigHeader = "UIViewController_MJRefresh_refreshConfigHeader";
@dynamic refreshConfigHeader;

static char *UIViewController_MJRefresh_refreshConfigFooter = "UIViewController_MJRefresh_refreshConfigFooter";
@dynamic refreshConfigFooter;
/*
 * 相关继承关系图谱 4个header + 9个Footer ;已经实现的👌
    MJRefreshGifHeader  👌 ->MJRefreshStateHeader->MJRefreshHeader->MJRefreshComponent->UIView
    MJRefreshNormalHeader 👌->MJRefreshStateHeader->MJRefreshHeader->MJRefreshComponent->UIView
    MJRefreshStateHeader 👌->MJRefreshHeader->MJRefreshComponent->UIView
    MJRefreshHeader 👌->MJRefreshComponent->UIView
 
    MJRefreshAutoGifFooter  👌 ->MJRefreshAutoStateFooter->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoNormalFooter  👌 ->MJRefreshAutoStateFooter->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoStateFooter ->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoFooter ->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackGifFooter ->MJRefreshBackStateFooter->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackNormalFooter  👌 ->MJRefreshBackStateFooter->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackStateFooter ->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackFooter ->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshFooter->MJRefreshComponent->UIView
 *
 */
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 结束刷新
//        [self.tableView.mj_header endRefreshing];
//    });
}
///上拉加载更多 （子类要进行覆写）
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 结束刷新
//        [self.tableView.mj_footer endRefreshing];
//    });
}
///KVO 监听 MJRefresh + 震动特效反馈
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([object isEqual:self.mjRefreshGifHeader] &&
        self.mjRefreshGifHeader.state == MJRefreshStatePulling) {
        [NSObject feedbackGenerator];
    }else if (([object isEqual:self.mjRefreshAutoGifFooter] ||
               [object isEqual:self.mjRefreshBackNormalFooter] ||
               [object isEqual:self.mjRefreshAutoNormalFooter]) && (self.mjRefreshAutoGifFooter.state == MJRefreshStatePulling ||
                                                                    self.mjRefreshBackNormalFooter.state == MJRefreshStatePulling ||
                                                                    self.mjRefreshAutoNormalFooter.state == MJRefreshStatePulling)
             ) {
        [NSObject feedbackGenerator];
    }else{}
}
#pragma mark —— SET | GET
#pragma mark —— @property(nonatomic,strong)MJRefreshConfigModel *refreshConfigHeader;//头部的配置信息
-(MJRefreshConfigModel *)refreshConfigHeader{
    MJRefreshConfigModel *RefreshConfigHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_refreshConfigHeader);
    if (!RefreshConfigHeader) {
        RefreshConfigHeader = MJRefreshConfigModel.new;
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_refreshConfigHeader,
                                 RefreshConfigHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RefreshConfigHeader;
}

-(void)setRefreshConfigHeader:(MJRefreshConfigModel *)refreshConfigHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_refreshConfigHeader,
                             refreshConfigHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshConfigModel *refreshConfigFooter;//尾部的配置信息
-(MJRefreshConfigModel *)refreshConfigFooter{
    MJRefreshConfigModel *RefreshConfigFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_refreshConfigFooter);
    if (!RefreshConfigFooter) {
        RefreshConfigFooter = MJRefreshConfigModel.new;
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_refreshConfigFooter,
                                 RefreshConfigFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RefreshConfigFooter;
}

-(void)setRefreshConfigFooter:(MJRefreshConfigModel *)refreshConfigFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_refreshConfigFooter,
                             refreshConfigFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 MJRefreshStateIdle,   //   普通闲置状态
 MJRefreshStatePulling,   //   松开就可以进行刷新的状态
 MJRefreshStateRefreshing,   //   正在刷新中的状态
 MJRefreshStateWillRefresh,   //   即将刷新的状态
 MJRefreshStateNoMoreData   //   所有数据加载完毕，没有更多的数据了
 */
#pragma mark —— MJRefreshHeader
-(LOTAnimationMJRefreshHeader *)lotAnimationMJRefreshHeader{
    LOTAnimationMJRefreshHeader *lotAnimMJRefreshHeader;
    if (!lotAnimMJRefreshHeader) {
        @weakify(self)
        lotAnimMJRefreshHeader = [LOTAnimationMJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //图片
        {
            // 普通闲置状态
            [lotAnimMJRefreshHeader setImages:self.refreshConfigHeader.stateIdlePicsMutArr
                                     forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [lotAnimMJRefreshHeader setImages:self.refreshConfigHeader.pullingPicsMutArr
                                     forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [lotAnimMJRefreshHeader setImages:self.refreshConfigHeader.refreshingPicsMutArr
                                     duration:self.refreshConfigHeader.refreshingDuration
                                     forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [lotAnimMJRefreshHeader setImages:self.refreshConfigHeader.willRefreshPicsMutArr
                                     forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [lotAnimMJRefreshHeader setImages:self.refreshConfigHeader.noMoreDataPicsMutArr
                                     forState:MJRefreshStateNoMoreData];
        }
        //文字
        {
            // 普通闲置状态
            [lotAnimMJRefreshHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                    forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [lotAnimMJRefreshHeader setTitle:self.refreshConfigHeader.pullingTitle
                                    forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [lotAnimMJRefreshHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                  forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [lotAnimMJRefreshHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                    forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [lotAnimMJRefreshHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                    forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            lotAnimMJRefreshHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            lotAnimMJRefreshHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
    }return lotAnimMJRefreshHeader;
}

-(MJRefreshNormalHeader *)mjRefreshNormalHeader{
    MJRefreshNormalHeader *mjRefreshNormalHeader;
    if (!mjRefreshNormalHeader) {
        @weakify(self)
        mjRefreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //文字
        {
            // 普通闲置状态
            [mjRefreshNormalHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                   forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshNormalHeader setTitle:self.refreshConfigHeader.pullingTitle
                                   forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshNormalHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                   forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshNormalHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                   forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshNormalHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                   forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshNormalHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            mjRefreshNormalHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
    }return mjRefreshNormalHeader;
}

-(MJRefreshStateHeader *)mjRefreshStateHeader{
    MJRefreshStateHeader *mjRefreshStateHeader;
    if (!mjRefreshStateHeader) {
        @weakify(self)
        mjRefreshStateHeader = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //文字
        {
            // 普通闲置状态
            [mjRefreshStateHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                   forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshStateHeader setTitle:self.refreshConfigHeader.pullingTitle
                                   forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshStateHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                   forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshStateHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                   forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshStateHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                   forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshStateHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            mjRefreshStateHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
    }return mjRefreshStateHeader;
}

-(MJRefreshHeader *)mjRefreshHeader{
    MJRefreshHeader *mjRefreshHeader;
    if (!mjRefreshHeader) {
        @weakify(self)
        mjRefreshHeader = [MJRefreshHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //其他
        {
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
    }return mjRefreshHeader;
}

-(MJRefreshGifHeader *)mjRefreshGifHeader{
    MJRefreshGifHeader *mjRefreshGifHeader;
    if (!mjRefreshGifHeader) {
        @weakify(self)
        mjRefreshGifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //图片
        {
            // 普通闲置状态
            [mjRefreshGifHeader setImages:self.refreshConfigHeader.stateIdlePicsMutArr
                                 forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshGifHeader setImages:self.refreshConfigHeader.pullingPicsMutArr
                                 forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshGifHeader setImages:self.refreshConfigHeader.refreshingPicsMutArr
                                 duration:self.refreshConfigHeader.refreshingDuration
                                 forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshGifHeader setImages:self.refreshConfigHeader.willRefreshPicsMutArr
                                 forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshGifHeader setImages:self.refreshConfigHeader.noMoreDataPicsMutArr
                                 forState:MJRefreshStateNoMoreData];
        }
        //文字
        {
            // 普通闲置状态
            [mjRefreshGifHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshGifHeader setTitle:self.refreshConfigHeader.pullingTitle
                                forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshGifHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshGifHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshGifHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshGifHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            mjRefreshGifHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
    }return mjRefreshGifHeader;
}
#pragma mark —— MJRefreshFooter
-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter{
    MJRefreshAutoGifFooter *mjRefreshAutoGifFooter;
    if (!mjRefreshAutoGifFooter) {
        @weakify(self)
        mjRefreshAutoGifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 图片
        {
            // 普通闲置状态
            [mjRefreshAutoGifFooter setImages:self.refreshConfigFooter.stateIdlePicsMutArr
                                     forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshAutoGifFooter setImages:self.refreshConfigFooter.pullingPicsMutArr
                                     forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshAutoGifFooter setImages:self.refreshConfigFooter.refreshingPicsMutArr
                                     duration:self.refreshConfigFooter.refreshingDuration
                                     forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshAutoGifFooter setImages:self.refreshConfigFooter.willRefreshPicsMutArr
                                     forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshAutoGifFooter setImages:self.refreshConfigFooter.noMoreDataPicsMutArr
                                     forState:MJRefreshStateNoMoreData];
        }
        // 文字
        {
            // 普通闲置状态
            [mjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                    forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.pullingTitle
                                    forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                    forState:MJRefreshStateRefreshing];
            /** 即将刷新的状态 */
            [mjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                    forState:MJRefreshStateWillRefresh];
            /** 所有数据加载完毕，没有更多的数据了 */
            [mjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                    forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshAutoGifFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            mjRefreshAutoGifFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        mjRefreshAutoGifFooter.hidden = YES;
    }return mjRefreshAutoGifFooter;
}

-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter{
    MJRefreshBackNormalFooter *mjRefreshBackNormalFooter;
    if (!mjRefreshBackNormalFooter) {
        @weakify(self)
        mjRefreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 文字 (此模式下只有文字而没有图片)
        {
            // 普通闲置状态
            [mjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                       forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.pullingTitle
                                       forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                       forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                       forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                       forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshBackNormalFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            mjRefreshBackNormalFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        mjRefreshBackNormalFooter.hidden = YES;
    }return mjRefreshBackNormalFooter;
}

-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter{
    MJRefreshAutoNormalFooter *mjRefreshAutoNormalFooter;
    if (!mjRefreshAutoNormalFooter) {
        @weakify(self)
        mjRefreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        
        // 文字
        {
            // 普通闲置状态
            [mjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                       forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [mjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.pullingTitle
                                       forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [mjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                       forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [mjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                       forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [mjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                       forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            mjRefreshAutoNormalFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            mjRefreshAutoNormalFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        mjRefreshAutoNormalFooter.hidden = YES;
    }return mjRefreshAutoNormalFooter;
}

@end
