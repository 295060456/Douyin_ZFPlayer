//
//  NSObject+AFNReachability.h
//  UBallLive
//
//  Created by Jobs on 2020/11/5.
//

#import <Foundation/Foundation.h>
#import "NotificationManager.h"
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AFNReachability)

+(void)AFNReachability:(MKIntegerBlock)statusBlock;

@end

NS_ASSUME_NONNULL_END
