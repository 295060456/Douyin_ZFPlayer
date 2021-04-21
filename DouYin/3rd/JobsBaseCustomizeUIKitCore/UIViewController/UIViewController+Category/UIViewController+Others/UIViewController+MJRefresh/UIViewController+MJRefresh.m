//
//  UIViewController+MJRefresh.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+MJRefresh.h"
#import <objc/runtime.h>

@implementation UIViewController (MJRefresh)

static char *UIViewController_MJRefresh_refreshConfigHeader = "UIViewController_MJRefresh_refreshConfigHeader";
@dynamic refreshConfigHeader;

static char *UIViewController_MJRefresh_refreshConfigFooter = "UIViewController_MJRefresh_refreshConfigFooter";
@dynamic refreshConfigFooter;

#pragma mark —— MJRefreshHeader
static char *UIViewController_MJRefresh_lotAnimMJRefreshHeader = "UIViewController_MJRefresh_lotAnimMJRefreshHeader";
@dynamic lotAnimMJRefreshHeader;

static char *UIViewController_MJRefresh_mjRefreshNormalHeader = "UIViewController_MJRefresh_mjRefreshNormalHeader";
@dynamic mjRefreshNormalHeader;

static char *UIViewController_MJRefresh_mjRefreshStateHeader = "UIViewController_MJRefresh_mjRefreshStateHeader";
@dynamic mjRefreshStateHeader;

static char *UIViewController_MJRefresh_mjRefreshHeader = "UIViewController_MJRefresh_mjRefreshHeader";
@dynamic mjRefreshHeader;

static char *UIViewController_MJRefresh_mjRefreshGifHeader = "UIViewController_MJRefresh_mjRefreshGifHeader";
@dynamic mjRefreshGifHeader;
#pragma mark —— MJRefreshFooter
static char *UIViewController_MJRefresh_mjRefreshAutoGifFooter = "UIViewController_MJRefresh_mjRefreshAutoGifFooter";
@dynamic mjRefreshAutoGifFooter;

static char *UIViewController_MJRefresh_mjRefreshBackNormalFooter = "UIViewController_MJRefresh_mjRefreshBackNormalFooter";
@dynamic mjRefreshBackNormalFooter;

static char *UIViewController_MJRefresh_mjRefreshAutoNormalFooter = "UIViewController_MJRefresh_mjRefreshAutoNormalFooter";
@dynamic mjRefreshAutoNormalFooter;

static char *UIViewController_MJRefresh_mjRefreshAutoStateFooter = "UIViewController_MJRefresh_mjRefreshAutoStateFooter";
@dynamic mjRefreshAutoStateFooter;

static char *UIViewController_MJRefresh_mjRefreshAutoFooter = "UIViewController_MJRefresh_mjRefreshAutoFooter";
@dynamic mjRefreshAutoFooter;

static char *UIViewController_MJRefresh_mjRefreshBackGifFooter = "UIViewController_MJRefresh_mjRefreshBackGifFooter";
@dynamic mjRefreshBackGifFooter;

static char *UIViewController_MJRefresh_mjRefreshBackStateFooter = "UIViewController_MJRefresh_mjRefreshBackStateFooter";
@dynamic mjRefreshBackStateFooter;

static char *UIViewController_MJRefresh_mjRefreshBackFooter = "UIViewController_MJRefresh_mjRefreshBackFooter";
@dynamic mjRefreshBackFooter;

static char *UIViewController_MJRefresh_mjRefreshFooter = "UIViewController_MJRefresh_mjRefreshFooter";
@dynamic mjRefreshFooter;
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
#pragma mark —— @property(nonatomic,strong)LOTAnimationMJRefreshHeader *lotAnimMJRefreshHeader;
-(LOTAnimationMJRefreshHeader *)lotAnimMJRefreshHeader{
    LOTAnimationMJRefreshHeader *lotAnimMJRefreshHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_lotAnimMJRefreshHeader);
    NSLog(@"DDD = %@",lotAnimMJRefreshHeader);
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
//            NSLog(@"%@",self.refreshConfigHeader.stateIdleTitle);
            NSLog(@"%@",self.refreshConfigHeader);
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
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_lotAnimMJRefreshHeader,
                                 lotAnimMJRefreshHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return lotAnimMJRefreshHeader;
}

-(void)setLotAnimMJRefreshHeader:(LOTAnimationMJRefreshHeader *)lotAnimMJRefreshHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_lotAnimMJRefreshHeader,
                             lotAnimMJRefreshHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshNormalHeader *mjRefreshNormalHeader;
-(MJRefreshNormalHeader *)mjRefreshNormalHeader{
    MJRefreshNormalHeader *MjRefreshNormalHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshNormalHeader);
    if (!MjRefreshNormalHeader) {
        @weakify(self)
        MjRefreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //文字
        {
            // 普通闲置状态
            [MjRefreshNormalHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                   forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshNormalHeader setTitle:self.refreshConfigHeader.pullingTitle
                                   forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshNormalHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                   forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshNormalHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                   forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshNormalHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                   forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshNormalHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            MjRefreshNormalHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshNormalHeader,
                                 MjRefreshNormalHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshNormalHeader;
}

-(void)setMjRefreshNormalHeader:(MJRefreshNormalHeader *)mjRefreshNormalHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshNormalHeader,
                             mjRefreshNormalHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshStateHeader *mjRefreshStateHeader;
-(MJRefreshStateHeader *)mjRefreshStateHeader{
    MJRefreshStateHeader *MjRefreshStateHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshStateHeader);
    if (!MjRefreshStateHeader) {
        @weakify(self)
        MjRefreshStateHeader = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //文字
        {
            // 普通闲置状态
            [MjRefreshStateHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                   forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshStateHeader setTitle:self.refreshConfigHeader.pullingTitle
                                   forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshStateHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                   forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshStateHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                   forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshStateHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                   forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshStateHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            MjRefreshStateHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshStateHeader,
                                 MjRefreshStateHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshStateHeader;
}

-(void)setMjRefreshStateHeader:(MJRefreshStateHeader *)mjRefreshStateHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshStateHeader,
                             mjRefreshStateHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshHeader *mjRefreshHeader;
-(MJRefreshHeader *)mjRefreshHeader{
    MJRefreshHeader *MjRefreshHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshHeader);
    if (!MjRefreshHeader) {
        @weakify(self)
        MjRefreshHeader = [MJRefreshHeader headerWithRefreshingBlock:^{
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
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshHeader,
                                 MjRefreshHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshHeader;
}

-(void)setMjRefreshHeader:(MJRefreshHeader *)mjRefreshHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshHeader,
                             mjRefreshHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshGifHeader *mjRefreshGifHeader;
-(MJRefreshGifHeader *)mjRefreshGifHeader{
    MJRefreshGifHeader *MjRefreshGifHeader = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshGifHeader);
    if (!MjRefreshGifHeader) {
        @weakify(self)
        MjRefreshGifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self pullToRefresh];
        }];
        //图片
        {
            // 普通闲置状态
            [MjRefreshGifHeader setImages:self.refreshConfigHeader.stateIdlePicsMutArr
                                 forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshGifHeader setImages:self.refreshConfigHeader.pullingPicsMutArr
                                 forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshGifHeader setImages:self.refreshConfigHeader.refreshingPicsMutArr
                                 duration:self.refreshConfigHeader.refreshingDuration
                                 forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshGifHeader setImages:self.refreshConfigHeader.willRefreshPicsMutArr
                                 forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshGifHeader setImages:self.refreshConfigHeader.noMoreDataPicsMutArr
                                 forState:MJRefreshStateNoMoreData];
        }
        //文字
        {
            // 普通闲置状态
            [MjRefreshGifHeader setTitle:self.refreshConfigHeader.stateIdleTitle
                                forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshGifHeader setTitle:self.refreshConfigHeader.pullingTitle
                                forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshGifHeader setTitle:self.refreshConfigHeader.refreshingTitle
                                forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshGifHeader setTitle:self.refreshConfigHeader.willRefreshTitle
                                forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshGifHeader setTitle:self.refreshConfigHeader.noMoreDataTitle
                                forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshGifHeader.stateLabel.font = self.refreshConfigHeader.font;
            // 设置颜色
            MjRefreshGifHeader.stateLabel.textColor = self.refreshConfigHeader.textColor;
            //震动特效反馈
            if (self.refreshConfigHeader.isShake) {
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshGifHeader,
                                 MjRefreshGifHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshGifHeader;
}

-(void)setMjRefreshGifHeader:(MJRefreshGifHeader *)mjRefreshGifHeader{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshGifHeader,
                             mjRefreshGifHeader,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— MJRefreshFooter
#pragma mark —— @property(nonatomic,strong)MJRefreshAutoGifFooter *mjRefreshAutoGifFooter;
-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter{
    MJRefreshAutoGifFooter *MjRefreshAutoGifFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshAutoGifFooter);
    if (!MjRefreshAutoGifFooter) {
        @weakify(self)
        MjRefreshAutoGifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 图片
        {
            // 普通闲置状态
            [MjRefreshAutoGifFooter setImages:self.refreshConfigFooter.stateIdlePicsMutArr
                                     forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshAutoGifFooter setImages:self.refreshConfigFooter.pullingPicsMutArr
                                     forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshAutoGifFooter setImages:self.refreshConfigFooter.refreshingPicsMutArr
                                     duration:self.refreshConfigFooter.refreshingDuration
                                     forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshAutoGifFooter setImages:self.refreshConfigFooter.willRefreshPicsMutArr
                                     forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshAutoGifFooter setImages:self.refreshConfigFooter.noMoreDataPicsMutArr
                                     forState:MJRefreshStateNoMoreData];
        }
        // 文字
        {
            // 普通闲置状态
            [MjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                    forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.pullingTitle
                                    forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                    forState:MJRefreshStateRefreshing];
            /** 即将刷新的状态 */
            [MjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                    forState:MJRefreshStateWillRefresh];
            /** 所有数据加载完毕，没有更多的数据了 */
            [MjRefreshAutoGifFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                    forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshAutoGifFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshAutoGifFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshAutoGifFooter,
                                 MjRefreshAutoGifFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshAutoGifFooter;
}

-(void)setMjRefreshAutoGifFooter:(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshAutoGifFooter,
                             mjRefreshAutoGifFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshBackNormalFooter *mjRefreshBackNormalFooter;
-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter{
    MJRefreshBackNormalFooter *MjRefreshBackNormalFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshBackNormalFooter);
    if (!MjRefreshBackNormalFooter) {
        @weakify(self)
        MjRefreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 文字 (此模式下只有文字而没有图片)
        {
            // 普通闲置状态
            [MjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                       forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.pullingTitle
                                       forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                       forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                       forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshBackNormalFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                       forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshBackNormalFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshBackNormalFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshBackNormalFooter,
                                 MjRefreshBackNormalFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshBackNormalFooter;
}

-(void)setMjRefreshBackNormalFooter:(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshBackNormalFooter,
                             mjRefreshBackNormalFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshAutoNormalFooter *mjRefreshAutoNormalFooter;
-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter{
    MJRefreshAutoNormalFooter *MjRefreshAutoNormalFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshAutoNormalFooter);
    if (!MjRefreshAutoNormalFooter) {
        @weakify(self)
        MjRefreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        
        // 文字
        {
            // 普通闲置状态
            [MjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                       forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.pullingTitle
                                       forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                       forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                       forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshAutoNormalFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                       forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshAutoNormalFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshAutoNormalFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshAutoNormalFooter,
                                 MjRefreshAutoNormalFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshAutoNormalFooter;
}

-(void)setMjRefreshAutoNormalFooter:(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshAutoNormalFooter,
                             mjRefreshAutoNormalFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshAutoStateFooter *mjRefreshAutoStateFooter;
-(MJRefreshAutoStateFooter *)mjRefreshAutoStateFooter{
    MJRefreshAutoStateFooter *MjRefreshAutoStateFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshAutoStateFooter);
    if (!MjRefreshAutoStateFooter) {
        @weakify(self)
        MjRefreshAutoStateFooter = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 文字
        {
            // 普通闲置状态
            [MjRefreshAutoStateFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                      forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshAutoStateFooter setTitle:self.refreshConfigFooter.pullingTitle
                                      forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshAutoStateFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                      forState:MJRefreshStateRefreshing];
            /** 即将刷新的状态 */
            [MjRefreshAutoStateFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                      forState:MJRefreshStateWillRefresh];
            /** 所有数据加载完毕，没有更多的数据了 */
            [MjRefreshAutoStateFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                      forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshAutoStateFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshAutoStateFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshAutoStateFooter,
                                 MjRefreshAutoStateFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshAutoStateFooter;
}

-(void)setMjRefreshAutoStateFooter:(MJRefreshAutoStateFooter *)mjRefreshAutoStateFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshAutoStateFooter,
                             mjRefreshAutoStateFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshAutoFooter *mjRefreshAutoFooter;
-(MJRefreshAutoFooter *)mjRefreshAutoFooter{
    MJRefreshAutoFooter *MjRefreshAutoFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshAutoFooter);
    if (!MjRefreshAutoFooter) {
        @weakify(self)
        MjRefreshAutoFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshAutoFooter,
                                 MjRefreshAutoFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshAutoFooter;
}

-(void)setMjRefreshAutoFooter:(MJRefreshAutoFooter *)mjRefreshAutoFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshAutoFooter,
                             mjRefreshAutoFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshBackGifFooter *mjRefreshBackGifFooter;
-(MJRefreshBackGifFooter *)mjRefreshBackGifFooter{
    MJRefreshBackGifFooter *MjRefreshBackGifFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshBackGifFooter);
    if (!MjRefreshBackGifFooter) {
        @weakify(self)
        MjRefreshBackGifFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 图片
        {
            // 普通闲置状态
            [MjRefreshBackGifFooter setImages:self.refreshConfigFooter.stateIdlePicsMutArr
                                     forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshBackGifFooter setImages:self.refreshConfigFooter.pullingPicsMutArr
                                     forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshBackGifFooter setImages:self.refreshConfigFooter.refreshingPicsMutArr
                                     duration:self.refreshConfigFooter.refreshingDuration
                                     forState:MJRefreshStateRefreshing];
            // 即将刷新的状态
            [MjRefreshBackGifFooter setImages:self.refreshConfigFooter.willRefreshPicsMutArr
                                     forState:MJRefreshStateWillRefresh];
            // 所有数据加载完毕，没有更多的数据了
            [MjRefreshBackGifFooter setImages:self.refreshConfigFooter.noMoreDataPicsMutArr
                                     forState:MJRefreshStateNoMoreData];
        }
        // 文字
        {
            // 普通闲置状态
            [MjRefreshBackGifFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                    forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshBackGifFooter setTitle:self.refreshConfigFooter.pullingTitle
                                    forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshBackGifFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                    forState:MJRefreshStateRefreshing];
            /** 即将刷新的状态 */
            [MjRefreshBackGifFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                    forState:MJRefreshStateWillRefresh];
            /** 所有数据加载完毕，没有更多的数据了 */
            [MjRefreshBackGifFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                    forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshBackGifFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshBackGifFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshBackGifFooter,
                                 MjRefreshBackGifFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshBackGifFooter;
}

-(void)setMjRefreshBackGifFooter:(MJRefreshBackGifFooter *)mjRefreshBackGifFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshBackGifFooter,
                             mjRefreshBackGifFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshBackStateFooter *mjRefreshBackStateFooter;
-(MJRefreshBackStateFooter *)mjRefreshBackStateFooter{
    MJRefreshBackStateFooter *MjRefreshBackStateFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshBackStateFooter);
    if (!MjRefreshBackStateFooter) {
        @weakify(self)
        MjRefreshBackStateFooter = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        // 文字
        {
            // 普通闲置状态
            [MjRefreshBackStateFooter setTitle:self.refreshConfigFooter.stateIdleTitle
                                    forState:MJRefreshStateIdle];
            // 松开就可以进行刷新的状态
            [MjRefreshBackStateFooter setTitle:self.refreshConfigFooter.pullingTitle
                                    forState:MJRefreshStatePulling];
            // 正在刷新中的状态
            [MjRefreshBackStateFooter setTitle:self.refreshConfigFooter.refreshingTitle
                                    forState:MJRefreshStateRefreshing];
            /** 即将刷新的状态 */
            [MjRefreshBackStateFooter setTitle:self.refreshConfigFooter.willRefreshTitle
                                    forState:MJRefreshStateWillRefresh];
            /** 所有数据加载完毕，没有更多的数据了 */
            [MjRefreshBackStateFooter setTitle:self.refreshConfigFooter.noMoreDataTitle
                                    forState:MJRefreshStateNoMoreData];
        }
        //其他
        {
            // 设置字体
            MjRefreshBackStateFooter.stateLabel.font = self.refreshConfigFooter.font;
            // 设置颜色
            MjRefreshBackStateFooter.stateLabel.textColor = self.refreshConfigFooter.textColor;
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshBackStateFooter,
                                 MjRefreshBackStateFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshBackStateFooter;
}

-(void)setMjRefreshBackStateFooter:(MJRefreshBackStateFooter *)mjRefreshBackStateFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshBackStateFooter,
                             mjRefreshBackStateFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshBackFooter *mjRefreshBackFooter;
-(MJRefreshBackFooter *)mjRefreshBackFooter{
    MJRefreshBackFooter *MjRefreshBackFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshBackFooter);
    if (!MjRefreshBackFooter) {
        @weakify(self)
        MjRefreshBackFooter = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        //其他
        {
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshBackFooter,
                                 MjRefreshBackFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshBackFooter;
}

-(void)setMjRefreshBackFooter:(MJRefreshBackFooter *)mjRefreshBackFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshBackFooter,
                             mjRefreshBackFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)MJRefreshFooter *mjRefreshFooter;
-(MJRefreshFooter *)mjRefreshFooter{
    MJRefreshFooter *MjRefreshFooter = objc_getAssociatedObject(self, UIViewController_MJRefresh_mjRefreshFooter);
    if (!MjRefreshFooter) {
        @weakify(self)
        MjRefreshFooter = [MJRefreshFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreRefresh];
        }];
        //其他
        {
            if (self.refreshConfigFooter.isShake) {
                //震动特效反馈
                [self addObserver:self
                       forKeyPath:@"state"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
            }
        }
        
        objc_setAssociatedObject(self,
                                 UIViewController_MJRefresh_mjRefreshFooter,
                                 MjRefreshFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MjRefreshFooter;
}

-(void)setMjRefreshFooter:(MJRefreshFooter *)mjRefreshFooter{
    objc_setAssociatedObject(self,
                             UIViewController_MJRefresh_mjRefreshFooter,
                             mjRefreshFooter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
