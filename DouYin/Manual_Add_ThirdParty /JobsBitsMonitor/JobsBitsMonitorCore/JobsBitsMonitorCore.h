//
//  JobsBitsMonitorCore.h
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import <Foundation/Foundation.h>

#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "NSTimerManager.h"

typedef enum : NSUInteger {
    BitsMonitorAutoRun = 0,// 自启动模式
    BitsMonitorManualRun = 1//手动启动模式
} BitsMonitorRunMode;


NS_ASSUME_NONNULL_BEGIN

extern NSString *const GSDownloadNetworkSpeedNotificationKey;// 下载通知的key
extern NSString *const GSUploadNetworkSpeedNotificationKey;// 上传通知的key
extern NSString *const GSUploadAndDownloadNetworkSpeedNotificationKey;// 上传和下载 通知的key

@interface JobsBitsMonitorCore : NSObject

@property(nonatomic,copy,readonly)NSString *downloadNetworkSpeed;
@property(nonatomic,copy,readonly)NSString *uploadNetworkSpeed;
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,assign)BitsMonitorRunMode bitsMonitorRunMode;// 默认自启动模式

+(instancetype)sharedInstance;
-(void)start;//【手动】开始监听
-(void)stop;//【手动】停止监听
-(void)pause;//【手动】暂停监听
-(void)continues;//【手动】暂停以后继续监听

@end

NS_ASSUME_NONNULL_END
