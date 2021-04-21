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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        self.isHiddenNavigationBar = YES;
        self.setupNavigationBarHidden = YES;
    }return self;
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
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
