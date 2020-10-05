//
//  LZBTabBarVC.m
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBarVC.h"

#define LZB_TABBAR_DEFULT_HEIGHT 49

@interface LZBTabBarVC ()<LZBTabBarDelegate>

@property(nonatomic,strong)NSMutableArray <LZBTabBarItem *>*tabBarItems;

@end

@implementation LZBTabBarVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
        self.isTop = YES;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.alpha = 1;
    self.lzb_tabBar.alpha = 1;
    
    self.isShouldAnimation = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setSelectedIndex:self.selectedIndex];
    [self setLzb_tabBarHidden:self.lzb_tabBarHidden
                     animated:NO];
}

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers{
    if(viewControllers.count == 0) return;
    //移除之前的
    for (UIViewController *viewController in _viewControllers){
        //注意：在removeFromParentViewController必须先调用willMoveToParentViewController
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = viewControllers;
    for (UIViewController *viewController in viewControllers) {
        LZBTabBarItem *tabBarItem = LZBTabBarItem.new;
        [tabBarItem setTitle:viewController.title];
        [self.tabBarItems addObject:tabBarItem];
        viewController.lzb_tabBarController = self;
    }
    [self.lzb_tabBar setLzbTabBarItemsArr:self.tabBarItems];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex
                 animation:self.isShouldAnimation];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
               animation:(BOOL)animation{
    if(selectedIndex >= self.viewControllers.count) return;
    if(self.selectedViewController){
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
    }
    _selectedIndex = selectedIndex;
    self.isShouldAnimation = animation;
    LZBTabBarItem *selectItem = [self.lzb_tabBar.lzbTabBarItemsArr objectAtIndex:selectedIndex];
    [self.lzb_tabBar setCurrentSelectItem:selectItem
                                animation:self.isShouldAnimation];
    self.selectedViewController = [self.viewControllers objectAtIndex:selectedIndex];
    [self addChildViewController:self.selectedViewController];
    self.selectedViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
                        animation:(BOOL)animation{
    if(![self.viewControllers containsObject:selectedViewController]) return;
    NSInteger index = [self.viewControllers indexOfObject:selectedViewController];
    self.isShouldAnimation = animation;
    [self setSelectedIndex:index
                 animation:self.isShouldAnimation];
}

-(UIViewController *)lzb_selectedViewController{
    return self.selectedViewController;
}

- (void)setLzb_tabBarHidden:(BOOL)lzb_tabBarHidden
                   animated:(BOOL)animation{
    _lzb_tabBarHidden = lzb_tabBarHidden;
    //定义Block处理隐藏的lzb_tabBarHidden
    __weak LZBTabBarVC *weakSelf = self;
    void(^blcokHidden)(void) = ^{
        CGSize fullSize = weakSelf.view.bounds.size;
        CGFloat tabBarStartingY = fullSize.height;
        CGFloat contentViewHeight = fullSize.height;
        CGFloat tabBarHeight = CGRectGetHeight(weakSelf.lzb_tabBar.frame);
        if(!lzb_tabBarHidden){//显示
            tabBarStartingY = fullSize.height - tabBarHeight;
            weakSelf.lzb_tabBar.frame = CGRectMake(0,
                                                   tabBarStartingY,
                                                   fullSize.width,
                                                   tabBarHeight);
            weakSelf.lzb_tabBar.hidden = NO;
        }else{
            //不显示
            weakSelf.lzb_tabBar.frame = CGRectMake(0,
                                                   tabBarStartingY,
                                                   fullSize.width,
                                                   tabBarHeight);
        }
        weakSelf.contentView.frame = CGRectMake(0,
                                                0,
                                                fullSize.width,
                                                contentViewHeight);
    };
    //动画完成
    void(^compeletion)(BOOL) = ^(BOOL finish){
        weakSelf.lzb_tabBar.hidden = finish;
    };
    //动画
    if(animation){
        [UIView animateWithDuration:0.25
                         animations:^{
            if(blcokHidden)
                blcokHidden();
        } completion:^(BOOL finished) {
             if(compeletion && finished)
                compeletion(lzb_tabBarHidden);
        }];
    }else{
        if(blcokHidden)
            blcokHidden();
        if(compeletion)
            compeletion(lzb_tabBarHidden);
    }
}

- (void)setLzb_tabBarHidden:(BOOL)lzb_tabBarHidden{
    [self setLzb_tabBarHidden:lzb_tabBarHidden
                     animated:NO];
}

- (NSInteger)indexForTabBarViewControllerViewControllers:(UIViewController *)viewController{
  if(viewController.navigationController)
      viewController = viewController.navigationController;
    return [self.viewControllers indexOfObject:viewController];
}
#pragma mark- tabbarDelegate
- (BOOL)lzb_tabBar:(LZBTabBar *)tabBar
shouldSelectItemAtIndex:(NSInteger)index{
    if (index < 0 ||
        index >= self.viewControllers.count) return NO;
    if([self.delegate respondsToSelector:@selector(lzb_tabBarController:shouldSelectViewController:)]){
        if(![self.delegate lzb_tabBarController:self
                     shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
            return NO;
    }
    if(self.selectedViewController == [self.viewControllers objectAtIndex:index]){
        if([self.selectedViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController *selectViewControler = (UINavigationController *)self.selectedViewController;
            //如果不是顶层控制器，就回到顶层
            if(selectViewControler.topViewController != [selectViewControler.viewControllers objectAtIndex:0]){
                [selectViewControler popToRootViewControllerAnimated:YES];
            }
        }return NO;
    }return YES;
}

- (void)lzb_tabBar:(LZBTabBar *)tabBar
didSelectItemAtIndex:(NSInteger)index{
    //播放声音
//    [PlaySound playSoundEffect:@"Sound"
//                          type:@"wav"];
    //震动特效反馈
    [NSObject feedbackGenerator];
    if (index < 0 || index >= self.viewControllers.count) return;
    [self setSelectedIndex:index
                 animation:self.isShouldAnimation];
    if([self.delegate respondsToSelector:@selector(lzb_tabBarController:didSelectViewController:)]){
        [self.delegate lzb_tabBarController:self
                    didSelectViewController:[self.viewControllers objectAtIndex:index]];
    }
}
#pragma mark —— LazyLoad
- (UIView *)contentView{
  if(!_contentView){
      _contentView = UIView.new;
//      _contentView.backgroundColor = [UIColor greenColor];
      _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|
      UIViewAutoresizingFlexibleHeight;
      _contentView.frame = [UIScreen mainScreen].bounds;
      [self.view addSubview:_contentView];
  }return _contentView;
}

-(LZBTabBar *)lzb_tabBar{
    if (!_lzb_tabBar) {
        _lzb_tabBar = LZBTabBar.new;
        _lzb_tabBar.tabBarStyleType = LZBTabBarStyleType_middleItemUp;
        _lzb_tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth|
                                    UIViewAutoresizingFlexibleTopMargin|
                                   UIViewAutoresizingFlexibleLeftMargin|
                                   UIViewAutoresizingFlexibleRightMargin|
                                   UIViewAutoresizingFlexibleBottomMargin;
        extern CGFloat LZB_TABBAR_HEIGHT;
        _lzb_tabBar.frame = CGRectMake(0,
                                       self.contentView.frame.size.height - LZB_TABBAR_HEIGHT,
                                       [UIScreen mainScreen].bounds.size.width,
                                       LZB_TABBAR_HEIGHT);
        _lzb_tabBar.delegate = self;
        if (self.isTop) {
            [getMainWindow() addSubview:_lzb_tabBar];
        }else{
            [self.view addSubview:_lzb_tabBar];
        }
    }return _lzb_tabBar;
}

-(NSMutableArray<LZBTabBarItem *> *)tabBarItems{
    if (!_tabBarItems) {
        _tabBarItems = NSMutableArray.array;
    }return _tabBarItems;
}

@end

