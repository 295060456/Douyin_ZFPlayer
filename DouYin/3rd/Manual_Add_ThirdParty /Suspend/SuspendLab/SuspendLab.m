//
//  SuspendLab.m
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SuspendLab.h"

@interface SuspendLab ()

@end

@implementation SuspendLab

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = self.backgroundColor ? :kBlackColor;
        self.text = [NSString ensureNonnullString:self.text
                                       ReplaceStr:@"暂无数据"];
        self.textAlignment = NSTextAlignmentCenter;
        [UIView cornerCutToCircleWithView:self
                          andCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.panRcognize.enabled = self.isAllowDrag;
    self.userInteractionEnabled = self.isAllowDrag;
}

-(void)actionSuspendViewBlock:(MKDataBlock _Nullable)suspendLabBlock{
    self.suspendLabBlock = suspendLabBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.suspendLabBlock) {
        self.suspendLabBlock(@1);
    }
}

@end
