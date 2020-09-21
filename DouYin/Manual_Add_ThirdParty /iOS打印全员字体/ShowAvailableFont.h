//
//  ShowAvailableFont.h
//  Shooting
//
//  Created by Jobs on 2020/8/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowAvailableFont : NSObject

+(ShowAvailableFont *)sharedInstance;
-(void)getAvailableFont;

@end

NS_ASSUME_NONNULL_END
