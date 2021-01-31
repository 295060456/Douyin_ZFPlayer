//
//  JobsBitsMonitorSuspendLab.m
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "JobsBitsMonitorSuspendLab.h"

/// 柬埔寨（主要）开发环境
extern BOOL DevEnviron_Cambodia_Main;
///// 柬埔寨（次要）开发环境
extern BOOL DevEnviron_Cambodia_Minor;
/// 柬埔寨Rally（次要）开发环境
extern BOOL DevEnviron_Cambodia_Rally;
/// 中国大陆开发环境
extern BOOL DevEnviron_China_Mainland;
/// 测试环境
extern BOOL TestEnviron;
/// 生产环境
extern BOOL ProductEnviron;

@interface JobsBitsMonitorSuspendLab ()

@end

@implementation JobsBitsMonitorSuspendLab

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(download:)
//                                                     name:GSDownloadNetworkSpeedNotificationKey
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(upload:)
//                                                     name:GSUploadNetworkSpeedNotificationKey
//                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(uploadAndDownload:)
                                                     name:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                   object:nil];
        {// A
            self.userInteractionEnabled = YES;
            self.target = self;
            self.tapGRSEL = NSStringFromSelector(@selector(showMenu));
            self.numberOfTouchesRequired = 1;
            self.numberOfTapsRequired = 1;
            self.tapGR.enabled = YES;
        }
    }return self;
}

//-(void)download:(NSNotification *)noti{
//    noti.object;
//
//}
//
//-(void)upload:(NSNotification *)noti{
//    noti.object;
//}

-(void)uploadAndDownload:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    self.text = noti.object;
    [self sizeToFit];
    [self adjustsFontSizeToFitWidth];
    self.height = 30;
}

-(void)showMenu{
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:self
                                                       titleArray:@[@"柬埔寨（主要）开发环境",
                                                                    @"柬埔寨（次要）开发环境",
                                                                    @"柬埔寨Rally（次要）开发环境",
                                                                    @"中国大陆开发环境",
                                                                    @"测试环境",
                                                                    @"生产环境"]];
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        NSLog(@"action----->%ld",(long)menuRow);
        
        switch (menuRow) {
            case 0:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = YES;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = NO;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = NO;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = NO;
                /// 测试环境
                TestEnviron = NO;
                /// 生产环境
                ProductEnviron = NO;
                [WHToast toastMsg:@"当前环境：柬埔寨（主要）开发环境"];
            }break;
            case 1:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = NO;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = YES;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = NO;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = NO;
                /// 测试环境
                TestEnviron = NO;
                /// 生产环境
                ProductEnviron = NO;
                [WHToast toastMsg:@"当前环境：柬埔寨（次要）开发环境"];
            }break;
            case 2:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = NO;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = NO;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = YES;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = NO;
                /// 测试环境
                TestEnviron = NO;
                /// 生产环境
                ProductEnviron = NO;
                [WHToast toastMsg:@"当前环境：柬埔寨Rally（次要）开发环境"];
            }break;
            case 3:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = NO;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = NO;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = NO;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = YES;
                /// 测试环境
                TestEnviron = NO;
                /// 生产环境
                ProductEnviron = NO;
                [WHToast toastMsg:@"当前环境：中国大陆开发环境"];
            }break;
            case 4:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = NO;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = NO;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = NO;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = NO;
                /// 测试环境
                TestEnviron = YES;
                /// 生产环境
                ProductEnviron = NO;
                [WHToast toastMsg:@"当前环境：测试环境"];
            }break;
            case 5:{
                /// 柬埔寨（主要）开发环境
                DevEnviron_Cambodia_Main = NO;
                /// 柬埔寨（次要）开发环境
                DevEnviron_Cambodia_Minor = NO;
                /// 柬埔寨Rally（次要）开发环境
                DevEnviron_Cambodia_Rally = NO;
                /// 中国大陆开发环境
                DevEnviron_China_Mainland = NO;
                /// 测试环境
                TestEnviron = NO;
                /// 生产环境
                ProductEnviron = YES;
                [WHToast toastMsg:@"当前环境：生产环境"];
            }break;

            default:
                break;
        }
    };
}

@end
