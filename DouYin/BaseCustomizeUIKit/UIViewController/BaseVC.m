//
//  BaseVC.m
//  gtp
//
//  Created by GT on 2019/1/8.
//  Copyright © 2019 GT. All rights reserved.
//

#import "BaseVC.h"
#import "UIButton+ImageTitleSpacing.h"

@interface BaseVC ()

@property(nonatomic,copy)MKDataBlock willComingBlock;
@property(nonatomic,copy)MKDataBlock didComingBlock;
@property(nonatomic,copy)MKDataBlock willBackBlock;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation BaseVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    BaseVC *vc = BaseVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}
#pragma mark —— Sys_LifeCycle
-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO];
}
//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO];
    printf("retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));//打印对象的引用计数器
}

-(void)VCwillComingBlock:(MKDataBlock)block{//即将进来
    self.willComingBlock = block;
}

-(void)VCdidComingBlock:(MKDataBlock)block{//已经进来
    self.didComingBlock = block;
}

-(void)VCwillBackBlock:(MKDataBlock)block{//即将出去
    self.willBackBlock = block;
}

-(void)VCdidBackBlock:(MKDataBlock)block{//已经出去
    self.didBackBlock = block;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//状态栏字体白色 UIStatusBarStyleDefault黑色
}
#pragma mark —— 截取 UIViewController 手势返回事件 这两个方法进出均调用，只不过进场的时候parent有值，出场的时候是nil
- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    if (parent) {
        NSLog(@"进场:%s,%@",__FUNCTION__,parent);
        if (self.willComingBlock) {//即将进来
            self.willComingBlock(parent);
        }
    }else{
        NSLog(@"出场:%s,%@",__FUNCTION__,parent);
        if (self.willBackBlock) {//即将出去
            self.willBackBlock(parent);
        }
    }
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO];
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(parent){
        NSLog(@"进场:%s,%@",__FUNCTION__,parent);
        if (self.didComingBlock) {//已经进来
            self.didComingBlock(parent);
        }
    }else{
        NSLog(@"出场:%s,%@",__FUNCTION__,parent);
//        NSLog(@"页面pop成功了");
        if (self.didBackBlock) {//已经出去
            self.didBackBlock(parent);
        }
    }
    [self.navigationController setNavigationBarHidden:YES
                                             animated:NO];
}

-(void)locateTabBar:(NSInteger)index{//backHome
    if (self.navigationController.tabBarController.selectedIndex == index) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        self.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
        self.navigationController.tabBarController.selectedIndex = index;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
///设置状态栏背景颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

//KVO 监听 MJRefresh + 震动特效反馈
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([object isEqual:self.tableViewHeader] &&
        self.tableViewHeader.state == MJRefreshStatePulling) {
        [NSObject feedbackGenerator];
    }else if ([object isEqual:self.tableViewFooter] &&
             self.tableViewFooter.state == MJRefreshStatePulling) {
        [NSObject feedbackGenerator];
    }
}

///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}
#pragma mark —— lazyLoad
-(MJRefreshGifHeader *)tableViewHeader{
    if (!_tableViewHeader) {
        _tableViewHeader =  [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(pullToRefresh)];
        // 设置普通状态的动画图片
        [_tableViewHeader setImages:@[kIMG(@"官方")]
                           forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [_tableViewHeader setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                           forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
//        [_tableViewHeader setImages:@[kIMG(@"gif_header_1"),
//                                      kIMG(@"gif_header_2"),
//                                      kIMG(@"gif_header_3"),
//                                      kIMG(@"gif_header_4")]
//                           duration:0.4
//                           forState:MJRefreshStateRefreshing];
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [_tableViewHeader setImages:dataMutArr
                           duration:0.7
                           forState:MJRefreshStateRefreshing];
        
        // 设置文字
        [_tableViewHeader setTitle:@"Click or drag down to refresh"
                          forState:MJRefreshStateIdle];
        [_tableViewHeader setTitle:@"Loading more ..."
                          forState:MJRefreshStateRefreshing];
        [_tableViewHeader setTitle:@"No more data"
                          forState:MJRefreshStateNoMoreData];

        // 设置字体
        _tableViewHeader.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        _tableViewHeader.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [_tableViewHeader addObserver:self
                           forKeyPath:@"state"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    }return _tableViewHeader;
}

-(MJRefreshAutoGifFooter *)tableViewFooter{
    if (!_tableViewFooter) {
        _tableViewFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadMoreRefresh)];
        // 设置普通状态的动画图片
        [_tableViewFooter setImages:@[kIMG(@"官方")]
                           forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [_tableViewFooter setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                           forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
//        [_tableViewFooter setImages:@[kIMG(@"gif_header_1"),
//                                      kIMG(@"gif_header_2"),
//                                      kIMG(@"gif_header_3"),
//                                      kIMG(@"gif_header_4")]
//                           duration:0.4
//                           forState:MJRefreshStateRefreshing];
        
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [_tableViewHeader setImages:dataMutArr
                           duration:0.4
                           forState:MJRefreshStateRefreshing];
        
        // 设置文字
        [_tableViewFooter setTitle:@"Click or drag up to refresh"
                          forState:MJRefreshStateIdle];
        [_tableViewFooter setTitle:@"Loading more ..."
                          forState:MJRefreshStateRefreshing];
        [_tableViewFooter setTitle:@"No more data"
                          forState:MJRefreshStateNoMoreData];
        // 设置字体
        _tableViewFooter.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        _tableViewFooter.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [_tableViewFooter addObserver:self
                           forKeyPath:@"state"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        _tableViewFooter.hidden = YES;
    }return _tableViewFooter;
}

-(MJRefreshBackNormalFooter *)refreshBackNormalFooter{
    if (!_refreshBackNormalFooter) {
        _refreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(loadMoreRefresh)];
    }return _refreshBackNormalFooter;
}

@end

