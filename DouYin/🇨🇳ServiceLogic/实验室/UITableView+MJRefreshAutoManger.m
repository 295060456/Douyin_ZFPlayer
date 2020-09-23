//
//  UITableView+MJRefreshAutoManger.m
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "UITableView+MJRefreshAutoManger.h"

@implementation UITableView (MJRefreshAutoManger)

static char *UITableView_MJRefreshAutoManger_footRefreshState = "UITableView_MJRefreshAutoManger_footRefreshState";
@dynamic footRefreshState;

-(void)setFootRefreshState:(MJFooterRefreshState)footRefreshState{
    //这里的意思是监视mj_footer的frame变化，可以使用kvo代替RACObserve
    [RACObserve(self.mj_footer, frame) subscribeNext:^(id x){
        //计算A上的B视图在C中的位置CGPoint
        CGPoint point = [self convertPoint:self.mj_footer.frame.origin toView:getMainWindow()];
        if (point.y < getMainWindow().frame.size.height){
            [(MJRefreshAutoNormalFooter *)self.mj_footer setTitle:@""
                                                         forState:MJRefreshStateNoMoreData];
            [self.mj_footer endRefreshingWithNoMoreData]; 
        }
    }];

    [self handleFooterRefresh:footRefreshState];
    NSString *value = [NSString stringWithFormat:@"%ld",(long)footRefreshState];
    objc_setAssociatedObject(self,
                             &UITableView_MJRefreshAutoManger_footRefreshState,
                             value,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(MJFooterRefreshState)footRefreshState{
    NSString *refreshState = objc_getAssociatedObject(self,
                                                      &UITableView_MJRefreshAutoManger_footRefreshState);
    if ([refreshState isEqualToString:@"MJFooterRefreshStateLoadMore"]){
        return MJFooterRefreshStateNoMore;
    }else{
        return MJFooterRefreshStateLoadMore;
    }
}

-(void)handleFooterRefresh:(MJFooterRefreshState)footRefreshState{
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter*)self.mj_footer;
    switch (footRefreshState) {
        case MJFooterRefreshStateNormal:{
            [footer setTitle:@"没数据了"
                    forState:MJRefreshStateIdle];
            break;
        }
        case MJFooterRefreshStateLoadMore:{
            [self.mj_footer endRefreshing];
            break;
        }
        case MJFooterRefreshStateNoMore: {
            [footer setTitle:@"没数据了"
                    forState:MJRefreshStateNoMoreData];
            [self.mj_footer endRefreshingWithNoMoreData];
            break;
        }
        default:
            break;
    }
}

@end
