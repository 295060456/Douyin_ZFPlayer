//
//  UIView+MJRefresh.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/17.
//

#import "UIView+MJRefresh.h"
#import <objc/runtime.h>

@implementation UIView (MJRefresh)

static char *UIView_MJRefresh_mjRefreshTargetView = "UIView_MJRefresh_mjRefreshTargetView";
@dynamic mjRefreshTargetView;

#pragma mark —— @property(nonatomic,weak)UIScrollView *mjRefreshTargetView; MJRefresh 作用于targetView
-(UIScrollView *)mjRefreshTargetView{
    return objc_getAssociatedObject(self, UIView_MJRefresh_mjRefreshTargetView);
}

-(void)setMjRefreshTargetView:(UIScrollView *)mjRefreshTargetView{
    objc_setAssociatedObject(self,
                             UIView_MJRefresh_mjRefreshTargetView,
                             mjRefreshTargetView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
