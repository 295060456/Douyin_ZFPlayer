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

@property(nonatomic,strong)NSMutableArray *operationEnvironMutArr;

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
                                                       titleArray:self.operationEnvironMutArr];
    @weakify(self)
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        @strongify(self)
        NSLog(@"action----->%ld",(long)menuRow);
        networkingEnvir = menuRow;
        if (menuRow + 1 <= self.operationEnvironMutArr.count) {
            [WHToast toastMsg:[@"当前环境" stringByAppendingString:self.operationEnvironMutArr[menuRow]]];
        }else{
            [WHToast toastErrMsg:@"切换环境出现错误"];
        }
    };
}
#pragma mark —— lazyLoad
-(NSMutableArray *)operationEnvironMutArr{
    if (!_operationEnvironMutArr) {
        _operationEnvironMutArr = NSMutableArray.array;
        [_operationEnvironMutArr addObject:@"开发环境_01"];
        [_operationEnvironMutArr addObject:@"开发环境_02"];
        [_operationEnvironMutArr addObject:@"开发环境_03"];
        [_operationEnvironMutArr addObject:@"开发环境_04"];
        [_operationEnvironMutArr addObject:@"测试环境"];
        [_operationEnvironMutArr addObject:@"UAT环境"];
        [_operationEnvironMutArr addObject:@"生产环境"];
    }return _operationEnvironMutArr;
}

@end
