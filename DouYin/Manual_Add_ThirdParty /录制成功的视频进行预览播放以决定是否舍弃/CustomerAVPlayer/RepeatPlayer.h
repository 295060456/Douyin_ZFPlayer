//
//  RepeatPlayer.h
//  ReatPlayerDemo
//
//  Created by Shouqiang Wei on 15/12/16.
//  Copyright © 2015年 教练助理. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RepeatPlayer : NSObject

@property(nonatomic,assign)float playerVolume;
@property(nonatomic,assign)BOOL autoPlay;

+(instancetype)showInView:(UIView *)containerView
                      src:(NSURL *)src;

-(instancetype)initWithSrc:(NSURL *)src;

-(void)showInView:(UIView *) containerView;
//播放
-(void)play;

-(void)pause;

@end
