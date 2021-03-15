//
//  UIView+Gesture.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>

@implementation UIView (Gesture)
// config
static char *UIView_Gesture_target = "UIView_Gesture_target";
@dynamic target;

static char *UIView_Gesture_callbackBlock = "UIView_Gesture_callbackBlock";
@dynamic callbackBlock;

static char *UIView_Gesture_numberOfTapsRequired = "UIView_Gesture_numberOfTapsRequired";
@dynamic numberOfTapsRequired;

static char *UIView_Gesture_numberOfTouchesRequired = "UIView_Gesture_numberOfTouchesRequired";
@dynamic numberOfTouchesRequired;

static char *UIView_Gesture_minimumPressDuration = "UIView_Gesture_minimumPressDuration";
@dynamic minimumPressDuration;

static char *UIView_Gesture_allowableMovement = "UIView_Gesture_allowableMovement";
@dynamic allowableMovement;

static char *UIView_Gesture_swipeGRDirection = "UIView_Gesture_swipeGRDirection";
@dynamic swipeGRDirection;

static char *UIView_Gesture_allowedScrollTypesMask = "UIView_Gesture_allowedScrollTypesMask";
@dynamic allowedScrollTypesMask;

static char *UIView_Gesture_scale = "UIView_Gesture_scale";
@dynamic scale;

static char *UIView_Gesture_rotate = "UIView_Gesture_rotate";
@dynamic rotate;
// UIGestureRecognizer
static char *UIView_Gesture_longPressGR = "UIView_Gesture_longPressGR";
@dynamic longPressGR;

static char *UIView_Gesture_tapGR = "UIView_Gesture_tapGR";
@dynamic tapGR;

static char *UIView_Gesture_swipeGR = "UIView_Gesture_swipeGR";
@dynamic swipeGR;

static char *UIView_Gesture_panGR = "UIView_Gesture_panGR";
@dynamic panGR;

static char *UIView_Gesture_pinchGR = "UIView_Gesture_pinchGR";
@dynamic pinchGR;

static char *UIView_Gesture_rotationGR = "UIView_Gesture_rotationGR";
@dynamic rotationGR;

static char *UIView_Gesture_screenEdgePanGR = "UIView_Gesture_screenEdgePanGR";
@dynamic screenEdgePanGR;

-(void)defaultFunc{
    NSLog(@"defaultFunc");
}

-(void)Dealloc{
    UILongPressGestureRecognizer *LongPressGR = objc_getAssociatedObject(self, UIView_Gesture_longPressGR);
    @weakify(self)
    if (LongPressGR) {
        [LongPressGR removeTarget:self.target
                           action:selectorBlocks(^(id _Nullable weakSelf,
                                                   id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   LongPressGR);
            }
        }, self.target)];
    }
    UITapGestureRecognizer *TapGR = objc_getAssociatedObject(self, UIView_Gesture_tapGR);
    if (TapGR) {
        [TapGR removeTarget:self.target
                     action:selectorBlocks(^(id _Nullable weakSelf,
                                             id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   TapGR);
            }
        }, self.target)];
    }
    UISwipeGestureRecognizer *SwipeGR = objc_getAssociatedObject(self, UIView_Gesture_swipeGR);
    if (SwipeGR) {
        [SwipeGR removeTarget:self.target
                       action:selectorBlocks(^(id _Nullable weakSelf,
                                               id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   SwipeGR);
            }
        }, self.target)];
    }
    UIPanGestureRecognizer *PanGR = objc_getAssociatedObject(self, UIView_Gesture_panGR);
    if (PanGR) {
        [PanGR removeTarget:self.target
                     action:selectorBlocks(^(id _Nullable weakSelf,
                                             id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   PanGR);
            }
        }, self.target)];
    }
    UIPinchGestureRecognizer *PinchGR = objc_getAssociatedObject(self, UIView_Gesture_pinchGR);
    if (PinchGR) {
        [PinchGR removeTarget:self.target
                       action:selectorBlocks(^(id _Nullable weakSelf,
                                               id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   PinchGR);
            }
        }, self.target)];
    }
    UIRotationGestureRecognizer *RotationGR = objc_getAssociatedObject(self, UIView_Gesture_rotationGR);
    if (RotationGR) {
        [RotationGR removeTarget:self.target
                          action:selectorBlocks(^(id _Nullable weakSelf,
                                                  id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   PinchGR);
            }
        }, self.target)];
    }
    UIScreenEdgePanGestureRecognizer *ScreenEdgePanGR = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGR);
    if (ScreenEdgePanGR) {
        [ScreenEdgePanGR removeTarget:self.target
                               action:selectorBlocks(^(id _Nullable weakSelf,
                                                       id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   PinchGR);
            }
        }, self.target)];
    }
}
#warning —— 本类不实现UIGestureRecognizerDelegate的原因说明:覆盖了UISCrollView 里面对应的方法
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong,nullable)id target;
-(id)target{
    id target = objc_getAssociatedObject(self, UIView_Gesture_target);
    if (!target) {
        target = self;
        objc_setAssociatedObject(self,
                                 UIView_Gesture_target,
                                 target,
                                 OBJC_ASSOCIATION_ASSIGN);
    }return target;
}

-(void)setTarget:(id)target{
    objc_setAssociatedObject(self,
                             UIView_Gesture_target,
                             target,
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)callback callbackBlock;//手势触发方法
-(ThreeDataBlock)callbackBlock{
    return objc_getAssociatedObject(self, UIView_Gesture_callbackBlock);
}

-(void)setCallbackBlock:(ThreeDataBlock)callbackBlock{
    objc_setAssociatedObject(self,
                             UIView_Gesture_callbackBlock,
                             callbackBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTapsRequired;//设置轻拍次数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTapsRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTapsRequired) unsignedIntegerValue];
}

-(void)setNumberOfTapsRequired:(NSUInteger)numberOfTapsRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTapsRequired,
                             [NSNumber numberWithInteger:numberOfTapsRequired],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTouchesRequired;//设置手指字数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTouchesRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTouchesRequired) unsignedIntegerValue];
}

-(void)setNumberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTouchesRequired,
                             [NSNumber numberWithUnsignedInteger:numberOfTouchesRequired],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSTimeInterval minimumPressDuration;//longPressGR最小长按时间【UILongPressGestureRecognizer】
-(NSTimeInterval)minimumPressDuration{
    return [objc_getAssociatedObject(self, UIView_Gesture_minimumPressDuration) doubleValue];
}

-(void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration{
    objc_setAssociatedObject(self,
                             UIView_Gesture_minimumPressDuration,
                             [NSNumber numberWithDouble:minimumPressDuration],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat allowableMovement;//【UILongPressGestureRecognizer】
-(CGFloat)allowableMovement{
    return [objc_getAssociatedObject(self, UIView_Gesture_allowableMovement) floatValue];
}

-(void)setAllowableMovement:(CGFloat)allowableMovement{
    objc_setAssociatedObject(self,
                             UIView_Gesture_allowableMovement,
                             [NSNumber numberWithFloat:allowableMovement],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)UISwipeGestureRecognizerDirection swipeGRDirection;//swipe手势清扫方向
-(UISwipeGestureRecognizerDirection)swipeGRDirection{
    return [objc_getAssociatedObject(self, UIView_Gesture_swipeGRDirection) unsignedIntegerValue];
}

-(void)setSwipeGRDirection:(UISwipeGestureRecognizerDirection)swipeGRDirection{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRDirection,
                             [NSNumber numberWithUnsignedInteger:swipeGRDirection],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)UIScrollTypeMask allowedScrollTypesMask;
-(UIScrollTypeMask)allowedScrollTypesMask{
    return [objc_getAssociatedObject(self, UIView_Gesture_allowedScrollTypesMask) integerValue];
}

-(void)setAllowedScrollTypesMask:(UIScrollTypeMask)allowedScrollTypesMask{
    objc_setAssociatedObject(self,
                             UIView_Gesture_allowedScrollTypesMask,
                             [NSNumber numberWithInteger:allowedScrollTypesMask],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat scale;
-(CGFloat)scale{
    return [objc_getAssociatedObject(self, UIView_Gesture_scale) floatValue];
}

-(void)setScale:(CGFloat)scale{
    objc_setAssociatedObject(self,
                             UIView_Gesture_scale,
                             [NSNumber numberWithFloat:scale],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat rotate;
-(CGFloat)rotate{
    return [objc_getAssociatedObject(self, UIView_Gesture_rotate) floatValue];
}

-(void)setRotate:(CGFloat)rotate{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotate,
                             [NSNumber numberWithFloat:rotate],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按手势
-(UILongPressGestureRecognizer *)longPressGR{
    UILongPressGestureRecognizer *LongPressGR = objc_getAssociatedObject(self, UIView_Gesture_longPressGR);
    if (!LongPressGR) {
        @weakify(self)
        LongPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self.target
                                                                    action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                            id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   LongPressGR);
            }
        }, self.target)];
        if (self.minimumPressDuration != 0) {
            LongPressGR.minimumPressDuration = self.minimumPressDuration;//longPressGR最小长按时间
        }
        
        if (self.numberOfTapsRequired != 0) {
            LongPressGR.numberOfTapsRequired = self.numberOfTapsRequired;//设置轻拍次数
        }
        
        if (self.numberOfTouchesRequired != 0) {
            LongPressGR.numberOfTouchesRequired = self.numberOfTouchesRequired;//设置手指字数
        }
        
        if (self.allowableMovement != 0) {
            LongPressGR.allowableMovement = self.allowableMovement;//??
        }
        LongPressGR.delegate = self.target;
        [self addGestureRecognizer:LongPressGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_longPressGR,
                                 LongPressGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LongPressGR;
}

-(void)setLongPressGR:(UILongPressGestureRecognizer *)longPressGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_longPressGR,
                             longPressGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UITapGestureRecognizer *tapGR;//点击手势
-(UITapGestureRecognizer *)tapGR{
    UITapGestureRecognizer *TapGR = objc_getAssociatedObject(self, UIView_Gesture_tapGR);
    if (!TapGR) {
        @weakify(self)
        TapGR = [[UITapGestureRecognizer alloc] initWithTarget:self.target
                                                        action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.tapGR);
            }
        }, self.target)];
        if (self.numberOfTapsRequired != 0) {
            TapGR.numberOfTapsRequired = self.numberOfTapsRequired;//设置轻拍次数
        }
        
        if (self.numberOfTouchesRequired != 0) {
            TapGR.numberOfTouchesRequired = self.numberOfTouchesRequired;//设置手指字数
        }
        TapGR.delegate = self.target;
        [self addGestureRecognizer:TapGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_tapGR,
                                 TapGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TapGR;
}

-(void)setTapGR:(UITapGestureRecognizer *)tapGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_tapGR,
                             tapGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UISwipeGestureRecognizer *swipeGR;//轻扫手势
-(UISwipeGestureRecognizer *)swipeGR{
    UISwipeGestureRecognizer *SwipeGR = objc_getAssociatedObject(self, UIView_Gesture_swipeGR);
    if (!SwipeGR) {
        @weakify(self)
        SwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target
                                                            action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                    id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.swipeGR);
            }
        }, self.target)];
        SwipeGR.delegate = self.target;
        SwipeGR.direction = self.swipeGRDirection;//清扫方向。如果多组可以用|来进行
        SwipeGR.numberOfTouchesRequired = self.numberOfTouchesRequired;
        [self addGestureRecognizer:SwipeGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_swipeGR,
                                 SwipeGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SwipeGR;
}

-(void)setSwipeGR:(UISwipeGestureRecognizer *)swipeGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGR,
                             swipeGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIPanGestureRecognizer *panGR;//平移手势
-(UIPanGestureRecognizer *)panGR{
    UIPanGestureRecognizer *PanGR = objc_getAssociatedObject(self, UIView_Gesture_panGR);
    if (!PanGR) {
        @weakify(self)
        PanGR = [[UIPanGestureRecognizer alloc] initWithTarget:self.target
                                                        action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.panGR);
            }
        }, self.target)];
        PanGR.delegate = self.target;
        if (@available(iOS 13.4, *)) {
            PanGR.allowedScrollTypesMask = self.allowedScrollTypesMask;
        }
        [self addGestureRecognizer:PanGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_panGR,
                                 PanGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PanGR;
}

-(void)setPanGR:(UIPanGestureRecognizer *)panGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_panGR,
                             panGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIPinchGestureRecognizer *pinchGR;//捏合（缩放）手势
-(UIPinchGestureRecognizer *)pinchGR{
    UIPinchGestureRecognizer *PinchGR = objc_getAssociatedObject(self, UIView_Gesture_pinchGR);
    if (!PinchGR) {
        @weakify(self)
        PinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self.target
                                                            action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                    id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.pinchGR);
            }
        }, self.target)];
        PinchGR.delegate = self.target;
        PinchGR.scale = self.scale;
        [self addGestureRecognizer:PinchGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_pinchGR,
                                 PinchGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PinchGR;
}

-(void)setPinchGR:(UIPinchGestureRecognizer *)pinchGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_pinchGR,
                             pinchGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIRotationGestureRecognizer *rotationGR;//旋转手势
-(UIRotationGestureRecognizer *)rotationGR{
    UIRotationGestureRecognizer *RotationGR = objc_getAssociatedObject(self, UIView_Gesture_rotationGR);
    if (!RotationGR) {
        @weakify(self)
        RotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self.target
                                                                  action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                          id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.rotationGR);
            }
        }, self.target)];
        RotationGR.delegate = self.target;
        RotationGR.rotation = self.rotate;
        [self addGestureRecognizer:RotationGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_rotationGR,
                                 RotationGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RotationGR;
}

-(void)setRotationGR:(UIRotationGestureRecognizer *)rotationGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotationGR,
                             rotationGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgePanGR;//屏幕边缘平移
-(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    UIScreenEdgePanGestureRecognizer *ScreenEdgePanGR = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGR);
    if (!ScreenEdgePanGR) {
        @weakify(self)
        ScreenEdgePanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.target
                                                                            action:selectorBlocks(^(id _Nullable weakSelf,
                                                                                                    id _Nullable arg) {
            @strongify(self)
            if (self.callbackBlock) {
                self.callbackBlock(weakSelf,
                                   arg,
                                   self.screenEdgePanGR);
            }
        }, self.target)];
        ScreenEdgePanGR.delegate = self.target;
        [self addGestureRecognizer:ScreenEdgePanGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_screenEdgePanGR,
                                 ScreenEdgePanGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ScreenEdgePanGR;
}

-(void)setScreenEdgePanGR:(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_screenEdgePanGR,
                             screenEdgePanGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

