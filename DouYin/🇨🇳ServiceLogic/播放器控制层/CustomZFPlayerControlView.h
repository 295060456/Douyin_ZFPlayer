//
//  ZFPlayerControlView.h
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///播放器的控制层
@interface CustomZFPlayerControlView : ZFPlayerControlView <ZFPlayerMediaControl>

-(void)actionCustomZFPlayerControlViewBlock:(MKDataBlock)CustomZFPlayerControlViewBlock;

@end

NS_ASSUME_NONNULL_END
