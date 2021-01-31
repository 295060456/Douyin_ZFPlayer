//
//  JobsBitsMonitorSuspendLab.h
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "SuspendLab.h"

#if __has_include(<ZWPullMenuView/ZWPullMenuView.h>)
#import <ZWPullMenuView/ZWPullMenuView.h>
#else
#import "ZWPullMenuView.h"
#endif

#import "JobsBitsMonitorCore.h"
#import "WHToast+DDToast.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsBitsMonitorSuspendLab : SuspendLab

@end

NS_ASSUME_NONNULL_END
