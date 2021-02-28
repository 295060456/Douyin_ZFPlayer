//
//  BaseTableViewer.m
//  Feidegou
//
//  Created by Kite on 2019/10/31.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()

@property(nonatomic,copy)MKDataBlock baseTableViewBlock;

@end

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
/*
    用于以此为基类的BaseTableView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseTableView:(MKDataBlock _Nullable)baseTableViewBlock{
    self.baseTableViewBlock = baseTableViewBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    NSLog(@"");
    if (self.baseTableViewBlock) {
//        self.baseTableViewBlock();
    }
}
/// 专治UITableView相应链断裂【核心代码】
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
