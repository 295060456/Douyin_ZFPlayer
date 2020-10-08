//
//  CustomSYSUITabBarController.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "CustomSYSUITabBarController.h"
#import "BaseNavigationVC.h"

#import "ViewController@1.h"
#import "ViewController@2.h"

#import "ViewController@5.h"

#import "ViewController@3.h"
#import "ViewController@4.h"

@interface CustomSYSUITabBarController ()
<
LZBTabBarVCDelegate
>

@property(nonatomic,strong)BaseNavigationVC *customNavigationVC;

@property(nonatomic,strong)NSMutableArray<UIImage *> *customUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<UIImage *> *customSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *titleStrMutArr;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *viewControllerMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *lottieJsonNameStrMutArr;
@property(nonatomic,strong)NSMutableArray *mutArr;

@end

CGFloat LZB_TABBAR_HEIGHT;

@implementation CustomSYSUITabBarController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        LZB_TABBAR_HEIGHT = isiPhoneX_series() ? (50 + isiPhoneX_seriesBottom) : 49;
    }return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navigationBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    [self p_setUpAllChildViewController];
 
    self.lzb_tabBar.tabBarStyleType = LZBTabBarStyleType_middleItemUp;//决定中间是否突起 必须在p_setUpAllChildViewController 之后
    self.lzb_tabBar.topLine.alpha = 0;//TabBar顶部分割线
    self.lzb_tabBar.lottieJsonNameStrMutArr = self.lottieJsonNameStrMutArr;

//    [self Badge];
}
///右上角角标
-(void)Badge{
    LZBTabBarItem *tabBarItem = self.lzb_tabBar.lzbTabBarItemsArr[0];
//    [tabBarItem pp_addBadgeWithText:@"99+"];
    [tabBarItem pp_addBadgeWithNumber:99];
    [tabBarItem pp_moveBadgeWithX:-20 Y:20];
    [tabBarItem pp_decreaseBy:10];
}
///登录流程
-(void)presentLoginVC{
//    @weakify(self)
    
}

- (void)p_setUpAllChildViewController {
    self.delegate = self;
    for (int i = 0; i < self.viewControllerMutArr.count; i ++) {
        [self.mutArr addObject:(UIViewController *)self.viewControllerMutArr[i]];
    }
    self.viewControllers = (NSArray *)self.mutArr;
    for (int i = 0; i <self.titleStrMutArr.count; i++) {
        [self p_setupCustomTBCWithViewController:self.viewControllerMutArr[i]
                                           Title:self.titleStrMutArr[i]
                                     SelectImage:(UIImage *)self.customSelectedImgMutArr[i]
                                   NnSelectImage:(UIImage *)self.customUnselectedImgMutArr[i]];
    }
    self.lzb_tabBar.backgroundColor = [UIColor blackColor];
    self.isShouldAnimation = YES;
}

-(void)p_setupCustomTBCWithViewController:(UIViewController *)vc
                                    Title:(NSString *)titleStr
                              SelectImage:(UIImage *)selectImage
                            NnSelectImage:(UIImage *)unSelectImage{
    vc.lzb_tabBarItem.selectImage = selectImage;
    vc.lzb_tabBarItem.unSelectImage = unSelectImage;
    vc.lzb_tabBarItem.title = titleStr;//下
    vc.title = titleStr;//上
}
#pragma mark ======== LZBTabBarViewControllerDelegate ======
- (BOOL)lzb_tabBarController:(LZBTabBarVC *)tabBarController
  shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
//改1
//点击的时候进行确认是否登录
- (void)lzb_tabBarController:(LZBTabBarVC *)tabBarController
     didSelectViewController:(UIViewController *)viewController{
    [NSObject feedbackGenerator];
    if ([viewController isKindOfClass:[ViewController_1 class]]) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"posy" object:nil];
    } else if ([viewController isKindOfClass:[ViewController_2 class]]) {
        [self presentLoginVC];
    } else if ([viewController isKindOfClass:[ViewController_3 class]]) {
        [self presentLoginVC];
    } else if ([viewController isKindOfClass:[ViewController_4 class]]) {
        [self presentLoginVC];
    }else if ([viewController isKindOfClass:[ViewController_5 class]]) {
        [self presentLoginVC];
    }
}
#pragma mark —— lazyLoad
-(NSMutableArray *)mutArr{
    if (!_mutArr) {
        _mutArr = NSMutableArray.array;
    }return _mutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"首页"];
        [_titleStrMutArr addObject:@"社区"];
        [_titleStrMutArr addObject:@"拍摄"];
        [_titleStrMutArr addObject:@"任务"];
        [_titleStrMutArr addObject:@"我的"];
    }return _titleStrMutArr;
}

-(NSMutableArray<UIImage *> *)customUnselectedImgMutArr{
    if (!_customUnselectedImgMutArr) {
        _customUnselectedImgMutArr = NSMutableArray.array;
        [_customUnselectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"Home")];
        [_customUnselectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"MyStore")];
        [_customUnselectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"摄像机")];
        [_customUnselectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"ShoppingCart")];
        [_customUnselectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"My")];
    }return _customUnselectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)customSelectedImgMutArr{
    if (!_customSelectedImgMutArr) {
        _customSelectedImgMutArr = NSMutableArray.array;
        [_customSelectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"Home")];
        [_customSelectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"MyStore")];
        [_customSelectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"摄像机")];
        [_customSelectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"ShoppingCart")];
        [_customSelectedImgMutArr addObject:KBuddleIMG(@"Others", nil, @"My")];
    }return _customSelectedImgMutArr;
}

-(NSMutableArray<UIViewController *> *)viewControllerMutArr{
    if (!_viewControllerMutArr) {
        _viewControllerMutArr = NSMutableArray.array;
        [_viewControllerMutArr addObject:ViewController_1.new];
        [_viewControllerMutArr addObject:ViewController_2.new];
        [_viewControllerMutArr addObject:ViewController_5.new];
        [_viewControllerMutArr addObject:ViewController_3.new];
        [_viewControllerMutArr addObject:ViewController_4.new];
    }return _viewControllerMutArr;
}

-(NSMutableArray<NSString *> *)lottieJsonNameStrMutArr{
    if (!_lottieJsonNameStrMutArr) {
        _lottieJsonNameStrMutArr = NSMutableArray.array;
        
        [_lottieJsonNameStrMutArr addObject:@"任务.json"];
        [_lottieJsonNameStrMutArr addObject:@"上传与拍照.json"];
        [_lottieJsonNameStrMutArr addObject:@"社区.json"];
        [_lottieJsonNameStrMutArr addObject:@"我的.json"];
        [_lottieJsonNameStrMutArr addObject:@"主页.json"];//green_lottie_tab_discover
        
//        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_discover.json"];
//        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_discover.json"];
//        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_discover.json"];
//        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_discover.json"];
//        [_lottieJsonNameStrMutArr addObject:@"主页.json"];//green_lottie_tab_discover
        
//        [_lottieJsonNameStrMutArr addObject:@"dingdan.json"];
//        [_lottieJsonNameStrMutArr addObject:@"dingdan.json"];
//        [_lottieJsonNameStrMutArr addObject:@"dingdan.json"];
//        [_lottieJsonNameStrMutArr addObject:@"dingdan.json"];
//        [_lottieJsonNameStrMutArr addObject:@"dingdan.json"];//green_lottie_tab_discover
        
    }return _lottieJsonNameStrMutArr;
}

@end
