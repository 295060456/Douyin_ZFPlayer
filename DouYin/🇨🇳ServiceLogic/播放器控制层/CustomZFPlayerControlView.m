//
//  ZFPlayerControlView.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomZFPlayerControlView.h"

@interface CustomZFPlayerControlView ()

@property(nonatomic,copy)TwoDataBlock CustomZFPlayerControlViewBlock;

@end

@implementation CustomZFPlayerControlView

-(void)actionCustomZFPlayerControlViewBlock:(TwoDataBlock)CustomZFPlayerControlViewBlock{
    _CustomZFPlayerControlViewBlock = CustomZFPlayerControlViewBlock;
}

-(void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    if (self.CustomZFPlayerControlViewBlock) {
        self.CustomZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@1);
    }
}

-(void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl{
    
}
//走一次
-(void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    
//    //UITableViewCell自动滚动到顶部
//    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                     atScrollPosition:UITableViewScrollPositionTop
//                             animated:YES];

}
//走多次
-(void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl
            panDirection:(ZFPanDirection)direction
             panLocation:(ZFPanLocation)location
            withVelocity:(CGPoint)velocity{

}
//走一次
-(void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    if (self.CustomZFPlayerControlViewBlock) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
        self.CustomZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@(gestureControl.panMovingDirection));
    }
}

-(void)gesturePinched:(ZFPlayerGestureControl *)gestureControl
                scale:(float)scale{
    
}

@end
