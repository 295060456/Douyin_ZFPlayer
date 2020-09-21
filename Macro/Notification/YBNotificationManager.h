//
//  YBNotificationManager.h
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kUserAssert;
FOUNDATION_EXTERN NSString *const kNotify_IsBackExchangeRefresh;

FOUNDATION_EXTERN NSString *const KLockMaxNotifaction;
FOUNDATION_EXTERN NSString *const KLockWillShowNotifaction;
FOUNDATION_EXTERN NSString *const KLoginSuccessNotifaction;
FOUNDATION_EXTERN NSString *const KRegisSuccessNotifaction;
FOUNDATION_EXTERN NSString *const KLoginOutNotifaction;
FOUNDATION_EXTERN NSString *const MKAFNReachability;
FOUNDATION_EXTERN NSString *const MKRecordStartNotification;

NS_ASSUME_NONNULL_BEGIN

@interface YBNotificationManager : NSObject

@end

NS_ASSUME_NONNULL_END
