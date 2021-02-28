//
//  BaseViewController.m
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    self.currentPage = 1;
    self.view.backgroundColor = kWhiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     *  #pragma mark —— 全局配置 GKNavigationBar -(void)makeGKNavigationBarConfigure
     */
//    {
//        self.gk_navBackgroundColor = kWhiteColor;
//        self.gk_navTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
//        self.gk_navTitleColor = AppMainCor_01;
//        self.gk_backStyle = GKNavigationBarBackStyleBlack;
//        self.gk_navLineHidden = YES;
//    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [self ifEmptyData];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.mjRefreshTargetView.mj_footer.y = self.view.mjRefreshTargetView.contentSize.height;
}
/*
    用于以此为基类的控制器上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockViewController:(MKDataBlock)viewControllerBlock{
    self.viewControllerBlock = viewControllerBlock;
}
/// 停止刷新
-(void)endRefreshing:(UIScrollView *)targetScrollView{
    if ([targetScrollView isKindOfClass:UITableView.class]) {
        UITableView *tableView = (UITableView *)targetScrollView;
        [tableView reloadData];
    }else if ([targetScrollView isKindOfClass:UICollectionView.class]){
        UICollectionView *collectionView = (UICollectionView *)targetScrollView;
        [collectionView reloadData];
    }else{}
    
    [targetScrollView tab_endAnimation];//里面实现了 [self.collectionView reloadData];
    if (targetScrollView.mj_header.refreshing) {
        [targetScrollView.mj_header endRefreshing];// 结束刷新
    }
    if (targetScrollView.mj_footer.refreshing) {
        [targetScrollView.mj_footer endRefreshing];// 结束刷新
    }
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
/// 加入键盘通知的监听者
-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;// 正则抬起 ，负值下降
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
 
    if (KeyboardOffsetY > 0) {
        NSLog(@"键盘抬起");
    }else if(KeyboardOffsetY < 0){
        NSLog(@"键盘收回");
    }else{
        NSLog(@"键盘");
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{

}
#pragma mark —— lazyLoad
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.frame = self.view.bounds;
        self.view = _bgImageView;
    }return _bgImageView;
}

@end
