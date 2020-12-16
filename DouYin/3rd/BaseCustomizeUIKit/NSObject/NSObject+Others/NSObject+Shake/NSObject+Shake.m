//
//  NSObject+Shake.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Shake.h"

@implementation NSObject (Shake)

-(void)shake{
    
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];   // 设置播放时屏幕常亮
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
}

@end
