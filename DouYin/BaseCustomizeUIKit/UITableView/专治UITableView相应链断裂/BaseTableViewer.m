//
//  BaseTableViewer.m
//  Feidegou
//
//  Created by Kite on 2019/10/31.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "BaseTableViewer.h"

@interface BaseTableViewer (){
    
}

@property(nonatomic,copy)MKDataBlock block;

@end


@implementation BaseTableViewer

-(void)actionBlock:(MKDataBlock)block{
    self.block = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    NSLog(@"");
    if (self.block) {
//        self.block();
    }
}

- (UIView *)hitTest:(CGPoint)point
          withEvent:(UIEvent *)event {
    static UIEvent *e = nil;
    if (e != nil && e == event) {
        e = nil;
        return [super hitTest:point withEvent:event];
    }
    e = event;
    if (event.type == UIEventTypeTouches) {
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        if (touch.phase == UITouchPhaseBegan) {
            NSLog(@"Touches began");
        }else if(touch.phase == UITouchPhaseEnded){
            NSLog(@"Touches Ended");
        }else if(touch.phase == UITouchPhaseCancelled){
            NSLog(@"Touches Cancelled");
        }else if (touch.phase == UITouchPhaseMoved){
            NSLog(@"Touches Moved");
        }
    }return [super hitTest:point withEvent:event];
}

@end
