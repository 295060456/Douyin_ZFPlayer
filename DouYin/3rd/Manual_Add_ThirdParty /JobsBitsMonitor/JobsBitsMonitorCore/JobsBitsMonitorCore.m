//
//  JobsBitsMonitorCore.m
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "JobsBitsMonitorCore.h"

NSString* const GSDownloadNetworkSpeedNotificationKey = @"GSDownloadNetworkSpeedNotificationKey";
NSString* const GSUploadNetworkSpeedNotificationKey = @"GSUploadNetworkSpeedNotificationKey";
NSString* const GSUploadAndDownloadNetworkSpeedNotificationKey = @"GSUploadAndDownloadNetworkSpeedNotificationKey";

@interface JobsBitsMonitorCore (){
    
    //总网速
    uint32_t _iBytes;
    uint32_t _oBytes;
    uint32_t _allFlow;

    //wifi网速
    uint32_t _wifiIBytes;
    uint32_t _wifiOBytes;
    uint32_t _wifiFlow;

    //3G网速
    uint32_t _wwanIBytes;
    uint32_t _wwanOBytes;
    uint32_t _wwanFlow;
}

@property(nonatomic,copy)NSString *downloadNetworkSpeed;
@property(nonatomic,copy)NSString *uploadNetworkSpeed;

@end

@implementation JobsBitsMonitorCore

static JobsBitsMonitorCore *static_bitsMonitorCore = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_bitsMonitorCore) {
            static_bitsMonitorCore = JobsBitsMonitorCore.new;
        }
    }return static_bitsMonitorCore;
}

-(instancetype)init{
    if (self = [super init]) {
        static_bitsMonitorCore = self;
        _iBytes = _oBytes = _allFlow = _wifiIBytes = _wifiOBytes = _wifiFlow = _wwanIBytes = _wwanOBytes = _wwanFlow = 0;
        
    }return self;
}
// 手动启动开启，可以对bitsMonitorRunMode进行赋值操作，也可以外界直接调用start方法开始
-(void)setBitsMonitorRunMode:(BitsMonitorRunMode)bitsMonitorRunMode{
    _bitsMonitorRunMode = bitsMonitorRunMode;
    switch (_bitsMonitorRunMode) {
        case BitsMonitorAutoRun:{
            [self autoMakeTimer];
        }break;
        case BitsMonitorManualRun:{
            [self start];
        }break;
        default:
            break;
    }
}

-(void)autoMakeTimer{
    //启动方式——2 定时器启动 系统自动添加到RunLoop
    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}
//【手动】开始监听
-(void)start{
    //启动方式——1 定时器启动 手动添加定时器到RunLoop
    [NSTimerManager nsTimeStart:self.nsTimerManager
                    withRunLoop:nil];
}
//【手动】停止监听
-(void)stop{
    [self.nsTimerManager nsTimeDestroy];
}
//【手动】暂停监听
-(void)pause{
    [NSTimerManager nsTimePause:self.nsTimerManager];
}
//【手动】暂停以后继续监听
-(void)continues{
    [NSTimerManager nsTimecontinue:self.nsTimerManager];
}

-(void)bitsSpeedMonitor{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return;
    }
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    uint32_t allFlow = 0;
    uint32_t wifiIBytes = 0;
    uint32_t wifiOBytes = 0;
    uint32_t wifiFlow = 0;
    uint32_t wwanIBytes = 0;
    uint32_t wwanOBytes = 0;
    uint32_t wwanFlow = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        // network
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data* if_data = (struct if_data*)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            allFlow = iBytes + oBytes;
        }
        // wifi
        if (!strcmp(ifa->ifa_name, "en0")) {
            struct if_data* if_data = (struct if_data*)ifa->ifa_data;
            wifiIBytes += if_data->ifi_ibytes;
            wifiOBytes += if_data->ifi_obytes;
            wifiFlow = wifiIBytes + wifiOBytes;
        }
        
        // 3G or gprs
        if (!strcmp(ifa->ifa_name, "pdp_ip0")) {
            struct if_data* if_data = (struct if_data*)ifa->ifa_data;
            wwanIBytes += if_data->ifi_ibytes;
            wwanOBytes += if_data->ifi_obytes;
            wwanFlow = wwanIBytes + wwanOBytes;
        }
    }
    freeifaddrs(ifa_list);
    if (_iBytes != 0) {
        self.downloadNetworkSpeed = [[self stringWithbytes:iBytes - _iBytes] stringByAppendingString:@"/s"];
        [[NSNotificationCenter defaultCenter] postNotificationName:GSDownloadNetworkSpeedNotificationKey
                                                            object:self.downloadNetworkSpeed];
        NSLog(@"self.downloadNetworkSpeed : %@",self.downloadNetworkSpeed);
    }
    _iBytes = iBytes;
    if (_oBytes != 0) {
        self.uploadNetworkSpeed = [[self stringWithbytes:oBytes - _oBytes] stringByAppendingString:@"/s"];
        [[NSNotificationCenter defaultCenter] postNotificationName:GSUploadNetworkSpeedNotificationKey
                                                            object:self.uploadNetworkSpeed];
        NSLog(@"self.uploadNetworkSpeed  :%@",self.uploadNetworkSpeed);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                        object:[NSString stringWithFormat:@"↑%@ / ↓%@",[NSString ensureNonnullString:self.uploadNetworkSpeed ReplaceStr:@"0b/s"],[NSString ensureNonnullString:self.downloadNetworkSpeed ReplaceStr:@"0b/s"]]];
    _oBytes = oBytes;
}
//格式化数据输出
-(NSString*)stringWithbytes:(int)bytes{
    if (bytes < 1024){// B
//        return [NSString stringWithFormat:@"%dB", bytes];
        return @"0KB";
    }else if (bytes >= 1024 && bytes < 1024 * 1024){// KB
        return [NSString stringWithFormat:@"%.fKB", (double)bytes / 1024];
    }else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024){// MB
        return [NSString stringWithFormat:@"%.1fMB", (double)bytes / (1024 * 1024)];
    }else{// GB
        return [NSString stringWithFormat:@"%.1fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}
#pragma mark —— lazyLoad
-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        // 顺时针:每一个时间间隔为 1 秒
        _nsTimerManager.timerStyle = TimerStyle_clockwise;
        _nsTimerManager.timeInterval = 1;
        @weakify(self)
        [_nsTimerManager actionNSTimerManagerRunningBlock:^(id data) {
            @strongify(self)
            NSLog(@"你好");
            [self bitsSpeedMonitor];
        }];
        [_nsTimerManager actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager;
}

@end
