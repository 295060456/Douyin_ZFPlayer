//
//  UIViewController+MJRefresh.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+MJRefresh.h"

@implementation UIViewController (MJRefresh)

/*
 
    MJRefreshGifHeader  👌 ->MJRefreshStateHeader->MJRefreshHeader->MJRefreshComponent->UIView
    MJRefreshHeader ->MJRefreshComponent->UIView
    MJRefreshNormalHeader ->MJRefreshStateHeader->MJRefreshHeader->MJRefreshComponent->UIView
    MJRefreshStateHeader ->MJRefreshHeader->MJRefreshComponent->UIView
 
    MJRefreshAutoFooter ->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoGifFooter  👌 ->MJRefreshAutoStateFooter->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoNormalFooter  👌 ->MJRefreshAutoStateFooter->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshAutoStateFooter ->MJRefreshAutoFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackFooter ->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackGifFooter ->MJRefreshBackStateFooter->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackNormalFooter  👌 ->MJRefreshBackStateFooter->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshBackStateFooter ->MJRefreshBackFooter->MJRefreshFooter->MJRefreshComponent->UIView
    MJRefreshFooter->MJRefreshComponent->UIView
 *
 */

///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
}
///上拉加载更多
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
#pragma mark —— lazyLoad
#pragma mark —— Header
-(MJRefreshGifHeader *)mjRefreshGifHeader{
    MJRefreshGifHeader *mjRefreshGifHeader;
    if (!mjRefreshGifHeader) {
        mjRefreshGifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                           refreshingAction:@selector(pullToRefresh)];
        // 设置普通状态的动画图片
        [mjRefreshGifHeader setImages:@[KBuddleIMG(nil,@"刷新", nil, @"header.png")]
                             forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [mjRefreshGifHeader setImages:@[KBuddleIMG(nil,@"刷新", nil, @"Indeterminate Spinner - Small.png")]
                             forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:KBuddleIMG(nil,@"刷新",@"刷新图片 166 * 166 @3x 100 * 100 @2x", str)];
        }

        [mjRefreshGifHeader setImages:dataMutArr
                             duration:0.7
                             forState:MJRefreshStateRefreshing];
        // 设置文字
        [mjRefreshGifHeader setTitle:@"Click or drag down to refresh"
                            forState:MJRefreshStateIdle];
        [mjRefreshGifHeader setTitle:@"Loading more ..."
                            forState:MJRefreshStateRefreshing];
        [mjRefreshGifHeader setTitle:@"No more data"
                            forState:MJRefreshStateNoMoreData];
        // 设置字体
        mjRefreshGifHeader.stateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        // 设置颜色
        mjRefreshGifHeader.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [self addObserver:self
               forKeyPath:@"state"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }return mjRefreshGifHeader;
}
#pragma mark —— Footer

///** 松开就可以进行刷新的状态 */
//MJRefreshStatePulling,
///** 正在刷新中的状态 */
//MJRefreshStateRefreshing,
///** 即将刷新的状态 */
//MJRefreshStateWillRefresh,
///** 所有数据加载完毕，没有更多的数据了 */
//MJRefreshStateNoMoreData

-(MJRefreshAutoGifFooter *)mjRefreshAutoGifFooter{
    MJRefreshAutoGifFooter *mjRefreshAutoGifFooter;
    if (!mjRefreshAutoGifFooter) {
        mjRefreshAutoGifFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self
                                                                   refreshingAction:@selector(loadMoreRefresh)];
        // 设置字体
        mjRefreshAutoGifFooter.stateLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
        // 设置颜色
        mjRefreshAutoGifFooter.stateLabel.textColor = KLightGrayColor;
        /** 普通闲置状态 */
        [mjRefreshAutoGifFooter setImages:@[KBuddleIMG(@"刷新", nil, nil,@"header.png")]
                                 forState:MJRefreshStateIdle];
        [mjRefreshAutoGifFooter setTitle:@"Click or drag up to refresh"
                                forState:MJRefreshStateIdle];
        
        /** 松开就可以进行刷新的状态 */
        [mjRefreshAutoGifFooter setImages:@[KBuddleIMG(@"刷新", nil, nil, @"Indeterminate Spinner - Small.png")]
                                 forState:MJRefreshStatePulling];
        
        /** 正在刷新中的状态 */
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            str = [str stringByAppendingString:@".png"];
            [dataMutArr addObject:KBuddleIMG(@"刷新", nil, @"刷新图片 166 * 166 @3x 100 * 100 @2x", str)];
        }

        [mjRefreshAutoGifFooter setImages:dataMutArr
                                 duration:0.4
                                 forState:MJRefreshStateRefreshing];
        [mjRefreshAutoGifFooter setTitle:@"Loading more ..."
                                forState:MJRefreshStateRefreshing];
        /** 即将刷新的状态 */    //MJRefreshStateWillRefresh

        /** 所有数据加载完毕，没有更多的数据了 */
        [mjRefreshAutoGifFooter setTitle:@"No more data"
                                forState:MJRefreshStateNoMoreData];

        //震动特效反馈
        [self addObserver:self
               forKeyPath:@"state"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        mjRefreshAutoGifFooter.hidden = YES;
    }return mjRefreshAutoGifFooter;
}

-(MJRefreshBackNormalFooter *)mjRefreshBackNormalFooter{
    MJRefreshBackNormalFooter *mjRefreshBackNormalFooter;
    if (!mjRefreshBackNormalFooter) {
        mjRefreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreRefresh)];
    }return mjRefreshBackNormalFooter;
}

-(MJRefreshAutoNormalFooter *)mjRefreshAutoNormalFooter{
    MJRefreshAutoNormalFooter *mjRefreshAutoNormalFooter;
    if (!mjRefreshAutoNormalFooter) {
        @weakify(self)
        mjRefreshAutoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            NSLog(@"123");
        }];
        [mjRefreshAutoNormalFooter setTitle:@"没有更多视频" forState:MJRefreshStateNoMoreData];
        mjRefreshAutoNormalFooter.stateLabel.textColor = KGreenColor;
    }return mjRefreshAutoNormalFooter;
}


@end
