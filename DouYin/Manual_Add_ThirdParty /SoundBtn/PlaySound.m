//
//  PlaySound.m
//  JinXian Finance
//
//  Created by 刘赓 on 2017/6/8.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import "PlaySound.h"

#import <AudioToolbox/AudioToolbox.h>

@implementation PlaySound

+ (void)playSoundEffect:(NSString*)name
                   type:(NSString*)type{
    
    SystemSoundID soundFileObject;
    
    //得到音效文件的地址
    NSString *soundFilePath = [[NSBundle mainBundle]pathForResource:name ofType:type];
    
    //将地址字符串转换成url
    NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效id
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    
    //播放系统音效
    AudioServicesPlaySystemSound(soundFileObject);
}

@end
