//
//  JobsBitsMonitorSuspendLab.m
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "JobsBitsMonitorSuspendLab.h"
#import "DefineStructure.h"

extern NetworkingEnvir networkingEnvir;

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
            self.numberOfTouchesRequired = 1;
            self.numberOfTapsRequired = 1;
            self.tapGR.enabled = YES;
            
//            @weakify(self)
            self.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
//                @strongify(self)
                [weakSelf showMenu];
            };
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
                networkingEnvir = DevEnviron_Cambodia_Main;
                [WHToast toastMsg:@"当前环境：柬埔寨（主要）开发环境"];
            }break;
            case 1:{
                /// 柬埔寨（次要）开发环境
                networkingEnvir = DevEnviron_Cambodia_Minor;
                [WHToast toastMsg:@"当前环境：柬埔寨（次要）开发环境"];
            }break;
            case 2:{
                /// 柬埔寨Rally（次要）开发环境
                networkingEnvir = DevEnviron_Cambodia_Rally;
                [WHToast toastMsg:@"当前环境：柬埔寨Rally（次要）开发环境"];
            }break;
            case 3:{
                /// 中国大陆开发环境
                networkingEnvir = DevEnviron_China_Mainland;
                [WHToast toastMsg:@"当前环境：中国大陆开发环境"];
            }break;
            case 4:{
                /// 测试环境
                networkingEnvir = TestEnviron;
                [WHToast toastMsg:@"当前环境：测试环境"];
            }break;
            case 5:{
                /// 生产环境
                networkingEnvir = ProductEnviron;
                [WHToast toastMsg:@"当前环境：生产环境"];
            }break;

            default:
                break;
        }
    };
}


@end
