//
//  UIView+MJRefresh.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/17.
//

#import "UIView+MJRefresh.h"

@implementation UIView (MJRefresh)

static char *UIView_MJRefresh_targetView = "UIView_MJRefresh_targetView";
@dynamic targetView;

#pragma mark —— @property(nonatomic,weak)UIScrollView *targetView; MJRefresh 作用于targetView
-(UIScrollView *)targetView{
    return objc_getAssociatedObject(self, UIView_MJRefresh_targetView);
}

-(void)setTargetView:(UIScrollView *)targetView{
    objc_setAssociatedObject(self,
                             UIView_MJRefresh_targetView,
                             targetView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
