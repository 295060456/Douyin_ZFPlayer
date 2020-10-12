//
//  SuspendView.m
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SuspendView.h"

@interface SuspendView ()

@end

@implementation SuspendView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = self.backgroundColor ? :kBlackColor;
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    self.panRcognize.enabled = self.isAllowDrag;
}

-(void)actionSuspendViewBlock:(MKDataBlock)suspendViewBlock{
    self.suspendViewBlock = suspendViewBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.suspendViewBlock) {
        self.suspendViewBlock(@1);
    }
}

@end
