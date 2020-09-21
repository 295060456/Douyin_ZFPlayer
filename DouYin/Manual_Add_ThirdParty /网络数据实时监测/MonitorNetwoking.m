//
//  MonitorNetwoking.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#import "MonitorNetwoking.h"

@interface MonitorNetwoking ()

@property(nonatomic,assign)long long int lastBytes;
@property(nonatomic,assign)BOOL isFirstRate;

@end

@implementation MonitorNetwoking

static MonitorNetwoking *monitorNetwoking = nil;
+(MonitorNetwoking *)sharedInstance{
    @synchronized(self){
        if (!monitorNetwoking) {
            monitorNetwoking = MonitorNetwoking.new;
        }
    }return monitorNetwoking;
}

-(instancetype)init{
    if (self = [super init]) {
        monitorNetwoking = self;
        self.lastBytes = 0;
    }return self;
}

-(void)getInternetface{
    long long int rate;
    long long int currentBytes = [self getInterfaceBytes];
    if(self.lastBytes) {
        //用上当前的下行总流量减去上一秒的下行流量达到下行速录
        rate = currentBytes - self.lastBytes;
    }else{
        self.isFirstRate = NO;
    }
    //保存上一秒的下行总流量
    self.lastBytes= [self getInterfaceBytes];
    //格式化一下
    NSString*rateStr = [self formatNetWork:rate];
    NSLog(@"当前网速%@",rateStr);
    _rateLabel.text = rateStr;
//    NSLog(@"hehe:%lld",hehe/1024/1024);
}

-(long long)getInterfaceBytes{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1){
        return 0;
    }
    uint32_t iBytes = 0;//下行
    uint32_t oBytes = 0;//上行
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next){
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2)){
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
//    NSLog(@"\n[getInterfaceBytes-Total]%d,%d",iBytes,oBytes);
    return iBytes;
}

-(NSString *)formatNetWork:(long long int)rate{
    if(rate < 1024) {
        return [NSString stringWithFormat:@"%lldB/秒", rate];
    }else if(rate >= 1024 && rate < 1024 * 1024) {
        return [NSString stringWithFormat:@"%.1fKB/秒", (double)rate / 1024];
    }else if(rate >= 1024 * 1024 && rate <1024 * 1024 * 1024){
        return [NSString stringWithFormat:@"%.2fMB/秒", (double)rate / (1024 * 1024)];
    }else{
        return @"10Kb/秒";
    };
}

-(SuspendLab *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = SuspendLab.new;
    }return _rateLabel;
}

@end
