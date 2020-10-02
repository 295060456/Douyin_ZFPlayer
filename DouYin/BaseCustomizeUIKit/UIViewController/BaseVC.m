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

@end

@implementation BaseVC

- (void)dealloc{
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

+(instancetype)comingFromVC:(UIViewController *)rootVC
                       toVC:(BaseVC *)toVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
                    success:(MKDataBlock)successBlock
                   animated:(BOOL)animated{
    toVC.requestParams = requestParams;
    @weakify(rootVC)
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                toVC.pushOrPresent = ComingStyle_PUSH;
                if (successBlock) {
                    successBlock(toVC);
                }
                [weak_rootVC.navigationController pushViewController:toVC
                                                            animated:animated];
            }else{
                toVC.pushOrPresent = ComingStyle_PRESENT;
                //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                toVC.modalPresentationStyle = presentationStyle;
                if (successBlock) {
                    successBlock(toVC);
                }
                [weak_rootVC presentViewController:toVC
                                          animated:animated
                                        completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            toVC.pushOrPresent = ComingStyle_PRESENT;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            toVC.modalPresentationStyle = presentationStyle;
            if (successBlock) {
                successBlock(toVC);
            }
            [weak_rootVC presentViewController:toVC
                                      animated:animated
                                    completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return toVC;
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

@end

