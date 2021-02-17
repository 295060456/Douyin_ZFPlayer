//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "TabbarVC.h"
#import "UIView+Gesture.h"
#import "TLTabBarAnimation.h"
#import "UITabBar+TLAnimation.h"
#import "UITabBarItem+TLAnimation.h"
#import "TransitionController.h"
#import "TransitionAnimation.h"

TabbarVC *tabBarVC;

@interface TabbarVC ()
<
UITabBarControllerDelegate,
UIGestureRecognizerDelegate
>

@property(nonatomic,assign)NSInteger subViewControllerCount;
@property(nonatomic,strong)NSMutableArray <UIView *>*UITabBarButtonMutArr;//UITabBarButton 是内部类 直接获取不到，需要间接获取

@end

@implementation TabbarVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    self.delegate = self;
    tabBarVC = self;
    self.isOpenScrollTabbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isOpenScrollTabbar) {
        self.view.target = self;
        self.view.panGRSEL = NSStringFromSelector(@selector(panGestureRecognizer:));
        self.view.panGR.enabled = self.isOpenScrollTabbar;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;
    [self UISetting];//最高只能在viewWillAppear，在viewDidLoad不出效果 self.tabBar.subviews为空
    [self 添加长按手势];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myTabBar.height += self.myTabBar.offsetHeight;
    self.myTabBar.y = self.view.height - self.myTabBar.height;
    
    for (UITabBarItem *item in self.tabBar.items) {
        if ([item.title isEqualToString:@"首页"]) {
            [item pp_addBadgeWithText:@"919+"];
#pragma mark —— 动画
            [UIView animationAlert:item.badgeView];//图片从小放大
            shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
//            [UIView 视图上下一直来回跳动的动画:item.badgeView];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark —— 一些私有方法
-(void)UISetting{
    for (int i = 0; i < self.tabBarControllerConfigMutArr.count; i++) {
        TabBarControllerConfig *config = (TabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];

        
        UIViewController *viewController = self.childMutArr[i];
        //
//        [self addLottieImage:viewController
//                 lottieImage:config.lottieName];
        
        viewController.title = config.title;
        viewController.tabBarItem = [[TabBarItem alloc] initWithConfig:config];
        
//        viewController.view.backgroundColor = RandomColor;
        
        if (config.humpOffsetY != 0) {
            //一般的图片
            [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(-config.humpOffsetY,
                                                                       0,
                                                                       -config.humpOffsetY / 2,
                                                                       0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
            [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];//修改文字偏移量
        }

        if (![viewController isKindOfClass:UINavigationController.class]) {//防止UIImagePickerController崩
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            nav.title = config.title;
            [self.childMutArr replaceObjectAtIndex:i withObject:nav];//替换元素，每个VC加Navigation
        }
    }
#warning 这句话走了以后 才会有self.tabBar
    self.viewControllers = self.childMutArr;
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [UIView animationAlert:subView];//图片从小放大
            [self.UITabBarButtonMutArr addObject:subView];
        }
    }
    
    for (int i = 0; i < self.childMutArr.count; i++) {
        TabBarControllerConfig *config = (TabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];
        if (![NSString isNullString:config.lottieName]) {
            [self.tabBar addLottieImage:i
                                offsetY:-config.humpOffsetY / 2
                             lottieName:config.lottieName];
        }
    }
    
    //初始显示
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        [self lottieImagePlay:self.childMutArr[self.firstUI_selectedIndex]];
        [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
    }
}
#pragma mark —— 手势事件
-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGR {
    switch (longPressGR.state) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            //长按手势
            [self 长按手势做什么:longPressGR];
            NSLog(@"一个手势已经开始  但尚未改变或者完成时");
        }break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}

-(void)长按手势做什么:(UILongPressGestureRecognizer *)longPressGR{
    [NSObject feedbackGenerator];//震动反馈
    [JobsPullListAutoSizeView initWithTargetView:self.UITabBarButtonMutArr[longPressGR.view.tag]
                                    imagesMutArr:nil
                                     titleMutArr:[NSMutableArray arrayWithObjects:@"qqq",@"24r",nil]];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    if (self.transitionCoordinator) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan ||
        pan.state == UIGestureRecognizerStateChanged){
        [self beginInteractiveTransitionIfPossible:pan];
    }
}

-(void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:self.view];
    if (translation.x > 0.f && self.selectedIndex > 0) {
        self.selectedIndex --;
    }
    else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
        self.selectedIndex ++;
    }
}

-(void)添加长按手势{
    for (UIView *subView in self.UITabBarButtonMutArr) {
        subView.tag = [self.UITabBarButtonMutArr indexOfObject:subView];

        subView.longPressGRSEL = NSStringFromSelector(@selector(LZBTabBarItemLongPress:));
        subView.numberOfTouchesRequired = 1;//手指数
        subView.minimumPressDuration = 1;
        subView.target = self;
        subView.longPressGR.enabled = YES;
    }
}

-(void)addLottieImage:(UIViewController *)vc
          lottieImage:(NSString *)lottieImage{
    vc.view.backgroundColor = [UIColor lightGrayColor];

    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

-(void)lottieImagePlay:(UIViewController *)vc{
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    if (!lottieView ||
        ![lottieView isKindOfClass:LOTAnimationView.class]) {
        return;
    }
    lottieView.animationProgress = 0;
    [lottieView play];
}
#pragma mark —— UITabBarDelegate 监听TabBarItem点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        NSLog(@"当前点击：%ld",(long)index);
        [self.tabBar animationLottieImage:(int)index];
        [NSObject playSoundWithFileName:@"Sound.wav"];
        [NSObject feedbackGenerator];
        shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
        [item pp_increase];

        UIView *UITabBarButton = self.UITabBarButtonMutArr[index];
        [UIView animationAlert:UITabBarButton];//图片从小放大
    }
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC{
    // 打开注释 可以屏蔽点击item时的动画效果
//    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSArray *viewControllers = tabBarController.viewControllers;
        if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
            return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeLeft];
        }
        else {
            return [[TransitionAnimation alloc] initWithTargetEdge:UIRectEdgeRight];
        }
//    }
//    else{
//        return nil;
//    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.view.panGR.state == UIGestureRecognizerStateBegan ||
        self.view.panGR.state == UIGestureRecognizerStateChanged) {
        return [[TransitionController alloc] initWithGestureRecognizer:self.view.panGR];
    }else {
        return nil;
    }
}
#pragma mark —— lazyLoad
-(CustomTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[CustomTabBar alloc] initWithBgImg:nil];
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
        _myTabBar.frame = self.tabBar.bounds;
    }return _myTabBar;
}

-(SuspendBtn *)suspendBtn{
    if (!_suspendBtn) {
        _suspendBtn = SuspendBtn.new;
        [_suspendBtn setImage:KIMG(@"旋转")
                     forState:UIControlStateNormal];
        _suspendBtn.isAllowDrag = NO;//悬浮效果必须要的参数
        @weakify(self)
        self.view.vc = weak_self;
        [self.view addSubview:_suspendBtn];
        _suspendBtn.frame = CGRectMake(80,
                                       100,
                                       50,
                                       50);
        [UIView cornerCutToCircleWithView:_suspendBtn
                          andCornerRadius:25];
        [[_suspendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof SuspendBtn * _Nullable x) {
//            @strongify(self)
            [x startRotateAnimation];
        }];
    }return _suspendBtn;
}

-(NSMutableArray<UIView *> *)UITabBarButtonMutArr{
    if (!_UITabBarButtonMutArr) {
        _UITabBarButtonMutArr = NSMutableArray.array;
    }return _UITabBarButtonMutArr;
}

-(NSMutableArray<UIViewController *> *)childMutArr{
    if (!_childMutArr) {
        _childMutArr = NSMutableArray.array;
    }return _childMutArr;
}

-(NSMutableArray<TabBarControllerConfig *> *)tabBarControllerConfigMutArr{
    if (!_tabBarControllerConfigMutArr) {
        _tabBarControllerConfigMutArr = NSMutableArray.array;
    }return _tabBarControllerConfigMutArr;
}

@end
