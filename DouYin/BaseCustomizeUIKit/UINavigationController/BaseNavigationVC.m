//
//  NavigationViewController.m
//  ShengAi
//
//  Created by 刘赓 on 2018/10/29.
//  Copyright © 2018年 刘赓. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()

@end

@implementation BaseNavigationVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+(UINavigationController *)rootNavigationController{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    CustomSYSUITabBarController *tabC = nil;
    if(@available(iOS 13.0, *)){
        tabC = (CustomSYSUITabBarController *)UIApplication.sharedApplication.windows.firstObject.rootViewController;
    }else{
        tabC = (CustomSYSUITabBarController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
    UINavigationController *navigationController = (UINavigationController *)tabC.lzb_selectedViewController;
    return navigationController;
    #pragma clang diagnostic pop
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self configNavigationBar];
        [self configBackgroundImage];
        [self configTitleTextStyle];
    }return self;
}
#pragma mark —— private
- (void)configNavigationBar {
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:UIImage.new
                             forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:UIImage.new];
}
/**
 *  设置NavgationBar的背景图片，红色背景
 */
-(void)configBackgroundImage{
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBarTintColor:kWhiteColor];//一般的业务是全局设置，因为一个App里面只有一个主题
        self.navigationBar.tintColor = kBlackColor;//系统的组件着色（返回按钮——箭头图标 和 上面的字）
    }
}
/**
 *  设置导航上的title显示样式，白色文
 字
 */
-(void)configTitleTextStyle{
    NSShadow *shadow = NSShadow.new;
    shadow.shadowColor = COLOR_RGB(0,
                                   0,
                                   0,
                                   0.8);
    shadow.shadowOffset = CGSizeZero;
    UIColor *textColor = kBlackColor;
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                textColor,NSForegroundColorAttributeName,
                                                shadow,NSShadowAttributeName,
                                                [UIFont fontWithName:@"PingFang SC" size:18.0f],NSFontAttributeName,
                                                nil]];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 不是根控制器
        viewController.hidesBottomBarWhenPushed = YES;//push 的时候把 tabBar 隐藏了
    }
    [super pushViewController:viewController animated:animated];//只能写在后面
}

-(void)setupEditBtn:(UIViewController *)vc{
    UIBarButtonItem *editBarBtnItems = [[UIBarButtonItem alloc]initWithTitle:@"编辑"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(action_EditBtn:)];
    vc.navigationItem.rightBarButtonItem = editBarBtnItems;
}

-(void)action_EditBtn:(UIButton *)sender{
    NSLog(@"123");
}







@end
