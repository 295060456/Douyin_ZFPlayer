//
//  NSObject+AFNReachability.m
//  UBallLive
//
//  Created by Jobs on 2020/11/5.
//

#import "NSObject+AFNReachability.h"

@implementation NSObject (AFNReachability)

+(void)AFNReachability{
    //2.监听网络状态的改变
    /*
     AFNetworkReachabilityStatusUnknown          = 未知
     AFNetworkReachabilityStatusNotReachable     = 没有网络
     AFNetworkReachabilityStatusReachableViaWWAN = 3G
     AFNetworkReachabilityStatusReachableViaWiFi = WIFI
     */
    
    AFNetworkReachabilityManager *networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //如果没有请求完成就检测网络
    [networkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                    object:@(AFNetworkReachabilityStatusUnknown)];
            }break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"3G网络");//不是WiFi的网络都会识别成3G网络.比如2G/3G/4G网络
                [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                    object:@(AFNetworkReachabilityStatusReachableViaWWAN)];
            }break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WIFI网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                    object:@(AFNetworkReachabilityStatusReachableViaWiFi)];
            } break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"没有网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                    object:@(AFNetworkReachabilityStatusNotReachable)];
            }break;
            default:{
                NSLog(@"没有网络");
                [[NSNotificationCenter defaultCenter] postNotificationName:MKAFNReachability
                                                                    object:@(AFNetworkReachabilityStatusNotReachable)];
            }break;
        }}];
    [networkReachabilityManager startMonitoring];
}

@end
