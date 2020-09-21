//
//  BaseVC+AFNReachability.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+AFNReachability.h"
#import <objc/runtime.h>

@implementation BaseVC (AFNReachability)

static char *BaseVC_AFNReachability_afNetworkReachabilityManager = "BaseVC_AFNReachability_afNetworkReachabilityManager";
@dynamic afNetworkReachabilityManager;

- (void)AFNReachability {
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown          = 未知
     AFNetworkReachabilityStatusNotReachable     = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    @weakify(self)
    if (!self.isRequestFinish) {
        //如果没有请求完成就检测网络
        [self.afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @strongify(self)
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未知网络");
                    if (self.UnknownNetWorking) {
                        self.UnknownNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G网络");//不是WiFi的网络都会识别成3G网络.比如2G/3G/4G网络
                    if (self.ReachableViaWWANNetWorking) {
                        self.ReachableViaWWANNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WIFI网络");
                    if (self.ReachableViaWiFiNetWorking) {
                        self.ReachableViaWiFiNetWorking();
                    }
                    if (self.ReachableNetWorking) {
                        self.ReachableNetWorking();
                    }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"没有网络");
                    if (self.NotReachableNetWorking) {
                        self.NotReachableNetWorking();
                    }
                    break;
                default:
                    break;
            }}];
    }
    [self.afNetworkReachabilityManager startMonitoring];
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)AFNetworkReachabilityManager *afNetworkReachabilityManager;
-(AFNetworkReachabilityManager *)afNetworkReachabilityManager{
    AFNetworkReachabilityManager *aFNetworkReachabilityManager = objc_getAssociatedObject(self, BaseVC_AFNReachability_afNetworkReachabilityManager);
    if (!aFNetworkReachabilityManager) {
        aFNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
        objc_setAssociatedObject(self,
                                 BaseVC_AFNReachability_afNetworkReachabilityManager,
                                 aFNetworkReachabilityManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return aFNetworkReachabilityManager;
}

-(void)setAfNetworkReachabilityManager:(AFNetworkReachabilityManager *)afNetworkReachabilityManager{
    objc_setAssociatedObject(self,
                             BaseVC_AFNReachability_afNetworkReachabilityManager,
                             afNetworkReachabilityManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
