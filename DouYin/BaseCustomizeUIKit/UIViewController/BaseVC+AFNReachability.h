//
//  BaseVC+AFNReachability.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (AFNReachability)

#pragma mark —— BaseVC+AFNReachability
@property(nonatomic,strong)AFNetworkReachabilityManager *afNetworkReachabilityManager;

-(void)AFNReachability;

@end

NS_ASSUME_NONNULL_END
