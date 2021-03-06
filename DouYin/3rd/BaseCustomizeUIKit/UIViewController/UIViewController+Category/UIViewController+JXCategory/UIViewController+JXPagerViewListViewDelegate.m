//
//  UIViewController+JXPagingViewListViewDelegate.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "UIViewController+JXPagerViewListViewDelegate.h"
#import <objc/runtime.h>

@implementation UIViewController (JXPagerViewListViewDelegate)

static char *UIViewController_JXPagingViewListViewDelegate_scrollView = "UIViewController_JXPagingViewListViewDelegate_scrollView";
static char *UIViewController_JXPagingViewListViewDelegate_scrollCallback = "UIViewController_JXPagingViewListViewDelegate_scrollCallback";
static char *UIViewController_JXPagingViewListViewDelegate_scrollViewClass = "UIViewController_JXPagingViewListViewDelegate_scrollViewClass";

@dynamic scrollView;
@dynamic scrollCallback;
@dynamic scrollViewClass;

#pragma mark —— UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:self.scrollViewClass]) {
        CGFloat sectionHeaderHeight = 40;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}
#pragma mark —— JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.scrollView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
#pragma mark —— @property(nonatomic,strong)Class scrollViewClass;
-(Class)scrollViewClass{
    Class ScrollViewClass = objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollViewClass);
    return ScrollViewClass;
}

-(void)setScrollViewClass:(Class)scrollViewClass{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollViewClass,
                             scrollViewClass,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(nonatomic,strong)UIScrollView *scrollView;
-(UIScrollView *)scrollView{
    UIScrollView *ScrollView = objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollView);
    if (!ScrollView) {
        ScrollView = UIScrollView.new;
        ScrollView.delegate = self;
        [self.view addSubview:ScrollView];
        objc_setAssociatedObject(self,
                                 UIViewController_JXPagingViewListViewDelegate_scrollView,
                                 ScrollView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [ScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return ScrollView;
}

-(void)setScrollView:(UIScrollView *)scrollView{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollView,
                             scrollView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)void(^scrollCallback)(UIScrollView *scrollView);
-(void)setScrollCallback:(void (^)(UIScrollView * _Nonnull))scrollCallback{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollCallback,
                             scrollCallback,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIScrollView * _Nonnull))scrollCallback{
    return objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollCallback);
}

@end
