//
//  suspendBtn.m
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SuspendBtn.h"
#import "UIView+SuspendView.h"

@interface SuspendBtn ()

@end

@implementation SuspendBtn

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = self.backgroundColor ? :kBlackColor;
        [self addTarget:self
                 action:@selector(addEvent:)
       forControlEvents:UIControlEventTouchUpInside];
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    self.panRcognize.enabled = self.isAllowDrag;
}

-(void)addEvent:(UIButton *)sender{
    NSLog(@"12345678");
}


@end
