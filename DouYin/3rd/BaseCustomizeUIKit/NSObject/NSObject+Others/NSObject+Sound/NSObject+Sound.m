//
//  NSObject+Sound.m
//  Feidegou
//
//  Created by Kite on 2019/12/2.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//
#import "NSObject+Sound.h"

@implementation NSObject (Sound)
/**
 播放自定义本地声音
 
 @param fileName 文件名 包含后缀
 */
+ (void)playSoundWithFileName:(NSString *)fileName{
    SystemSoundID soundID;
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , &soundID);
    if (errorCode != 0) {
        NSLog(@"create sound failed");
    }else{
        AudioServicesPlaySystemSound(soundID);
    }
}

+ (void)playSoundEffect:(NSString*)name
                   type:(NSString*)type{
    SystemSoundID soundFileObject;
    //得到音效文件的地址
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:name
                                                              ofType:type];
    
    //将地址字符串转换成url
    NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
    //生成系统音效id
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    //播放系统音效
    AudioServicesPlaySystemSound(soundFileObject);
}

@end
