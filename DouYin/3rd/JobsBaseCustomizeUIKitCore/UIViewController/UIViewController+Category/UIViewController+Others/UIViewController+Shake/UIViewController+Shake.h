//
//  UIViewController+Shake.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Shake)

@property(nonatomic,copy)MKDataBlock UIViewControllerShakeBeganBlock;
@property(nonatomic,copy)MKDataBlock UIViewControllerShakeCancelBlock;
@property(nonatomic,copy)MKDataBlock UIViewControllerShakeEndBlock;
@property(nonatomic,strong)CMMotionManager *motionManager;

-(void)invokeWhenViewDidLoadUsingSysFunc;
-(void)invokeWhenViewDidAppearUsingCMMotionManager;
-(void)VC_ShakeBegan:(MKDataBlock)UIViewControllerShakeBeganBlock;
-(void)VC_ShakeCancel:(MKDataBlock)UIViewControllerShakeCancelBlock;
-(void)VC_ShakeEnd:(MKDataBlock)UIViewControllerShakeEndBlock;

@end

NS_ASSUME_NONNULL_END
