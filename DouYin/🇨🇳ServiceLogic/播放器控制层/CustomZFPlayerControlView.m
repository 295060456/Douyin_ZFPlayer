//
//  ZFPlayerControlView.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomZFPlayerControlView.h"

@interface CustomZFPlayerControlView ()

@property(nonatomic,copy)MKDataBlock CustomZFPlayerControlViewBlock;

@end

@implementation CustomZFPlayerControlView

-(void)actionCustomZFPlayerControlViewBlock:(MKDataBlock)CustomZFPlayerControlViewBlock{
    _CustomZFPlayerControlViewBlock = CustomZFPlayerControlViewBlock;
}

-(void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    if (self.CustomZFPlayerControlViewBlock) {
        self.CustomZFPlayerControlViewBlock(@1);
    }
}

-(void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl{
    
}

-(void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    
}

-(void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl
            panDirection:(ZFPanDirection)direction
             panLocation:(ZFPanLocation)location
            withVelocity:(CGPoint)velocity{
    
}

-(void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    
}

-(void)gesturePinched:(ZFPlayerGestureControl *)gestureControl
                scale:(float)scale{
    
}

@end
