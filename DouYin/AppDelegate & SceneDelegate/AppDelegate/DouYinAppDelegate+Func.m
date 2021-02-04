//
//  DouYinAppDelegate+Func.m
//  DouYin
//
//  Created by Jobs on 2021/1/25.
//

#import "DouYinAppDelegate+Func.h"

@implementation DouYinAppDelegate (Func)
#if DEBUG
static char *AppDelegate_Func_bitsMonitorSuspendLab = "AppDelegate_Func_bitsMonitorSuspendLab";
@dynamic bitsMonitorSuspendLab;
//测试代码
-(void)testFunc{
    static BOOL isCreate = YES;
    isCreate = NO;
    NSLog(@"");
}

#endif

-(void)reachabilityChanged:(NSNotification *)notify{
    
}
#pragma mark —— 全局配置 TABAnimated
-(void)makeTABAnimatedConfigure{
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    [TABAnimated sharedAnimated].openLog = YES;
}
#pragma mark —— 全局配置 GKNavigationBar
-(void)makeGKNavigationBarConfigure{
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        // 导航栏背景色
        configure.backgroundColor = kWhiteColor;
        // 导航栏标题颜色
        configure.titleColor = kWhiteColor;
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
        
        configure.gk_disableFixSpace = YES;
        
        configure.shiledItemSpaceVCs = @[@"PUPhotoPickerHostViewController"];
    }];
}
#pragma mark —— 网络环境监测
-(void)makeReachabilityConfigure{
    // Allocate a reachability object
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = NO;
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
    dispatch_async(dispatch_get_main_queue(), ^{
         [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification
                                                             object:self];
     });
}
#pragma mark —— 网络流量实时监控
-(void)makeNetworkingBitsMonitor{
#ifdef DEBUG
//    self.bitsMonitorSuspendLab.alpha = 1;
#endif
}
#pragma mark —— 滴滴打车团队出的一款小工具
-(void)makeDoraemonManagerConfigure{
#ifdef DEBUG
       [[DoraemonManager shareInstance] install];
#endif
}
#pragma mark SET | GET
#if DEBUG
#pragma mark —— @property(nonatomic,strong)JobsBitsMonitorSuspendLab *bitsMonitorSuspendLab;
-(JobsBitsMonitorSuspendLab *)bitsMonitorSuspendLab{
    JobsBitsMonitorSuspendLab *BitsMonitorSuspendLab = objc_getAssociatedObject(self, AppDelegate_Func_bitsMonitorSuspendLab);
    if (!BitsMonitorSuspendLab) {
        BitsMonitorSuspendLab = JobsBitsMonitorSuspendLab.new;
        BitsMonitorSuspendLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
        BitsMonitorSuspendLab.backgroundColor = KLightGrayColor;
        BitsMonitorSuspendLab.textColor = kRedColor;
        @weakify(self)
        BitsMonitorSuspendLab.vc = weak_self.tabBarVC;
        BitsMonitorSuspendLab.isAllowDrag = YES;//悬浮效果必须要的参数
        [self.tabBarVC.view addSubview:BitsMonitorSuspendLab];
        BitsMonitorSuspendLab.frame = CGRectMake(20,
                                                 SCREEN_HEIGHT - 200,
                                                 80,
                                                 30);
        objc_setAssociatedObject(self,
                                 AppDelegate_Func_bitsMonitorSuspendLab,
                                 BitsMonitorSuspendLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BitsMonitorSuspendLab;
}

-(void)setBitsMonitorSuspendLab:(JobsBitsMonitorSuspendLab *)bitsMonitorSuspendLab{
    objc_setAssociatedObject(self,
                             AppDelegate_Func_bitsMonitorSuspendLab,
                             bitsMonitorSuspendLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#endif


@end
