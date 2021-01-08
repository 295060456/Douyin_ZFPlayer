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

static char *UIView_Gesture_longPressGRSEL = "UIView_Gesture_longPressGRSEL";
@dynamic longPressGRSEL;

static char *UIView_Gesture_tapGRSEL = "UIView_Gesture_tapGRSEL";
@dynamic tapGRSEL;

static char *UIView_Gesture_swipeGRSEL = "UIView_Gesture_swipeGRSEL";
@dynamic swipeGRSEL;

static char *UIView_Gesture_panGRSEL = "UIView_Gesture_panGRSEL";
@dynamic panGRSEL;

static char *UIView_Gesture_pinchGRSEL = "UIView_Gesture_pinchGRSEL";
@dynamic pinchGRSEL;

static char *UIView_Gesture_rotationGRSEL = "UIView_Gesture_rotationGRSEL";
@dynamic rotationGRSEL;

static char *UIView_Gesture_screenEdgePanGRSEL = "UIView_Gesture_screenEdgePanGRSEL";
@dynamic screenEdgePanGRSEL;

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

#pragma mark —— UIGestureRecognizerDelegate
// 是否接收一个手势触摸事件，默认为YES，返回NO为不接收
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
// 是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
// 是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// 这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// 这个方法返回YES，第一个和第二个互斥时，第二个会失效
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
// 手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
// 此方法在window对象在有触摸事件发生时，调用gesture recognizer的touchesBegan:withEvent:方法之前调用，如果返回NO,则gesture recognizer不会看到此触摸事件。(默认情况下为YES)
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch{
    return YES;
}
// 手指按压屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceivePress:(UIPress *)press{
    return YES;
}
// 在手势识别器:shouldReceiveTouch:或手势识别器:shouldReceivePress之前调用一次
// 返回NO以防止手势识别器看到此事件
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveEvent:(UIEvent *)event{
    return YES;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong,nullable)id target;
-(id)target{
    id target = objc_getAssociatedObject(self, UIView_Gesture_target);
    if (!target) {
        target = self;
        objc_setAssociatedObject(self,
                                 UIView_Gesture_target,
                                 target,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return target;
}

-(void)setTarget:(id)target{
    objc_setAssociatedObject(self,
                             UIView_Gesture_target,
                             target,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *longPressGRSEL;
-(NSString *)longPressGRSEL{
    NSString *LongPressGRSEL = objc_getAssociatedObject(self, UIView_Gesture_longPressGRSEL);
    if ([NSString isNullString:LongPressGRSEL]) {
        LongPressGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_longPressGRSEL,
                                 LongPressGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LongPressGRSEL;
}

-(void)setLongPressGRSEL:(NSString *)longPressGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_longPressGRSEL,
                             longPressGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *tapGRSEL;
-(NSString *)tapGRSEL{
    NSString *TapGRSEL = objc_getAssociatedObject(self, UIView_Gesture_tapGRSEL);
    if ([NSString isNullString:TapGRSEL]) {
        TapGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_tapGRSEL,
                                 TapGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TapGRSEL;
}

-(void)setTapGRSEL:(NSString *)tapGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_tapGRSEL,
                             tapGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *swipeGRSEL;//轻扫手势触发方法
-(NSString *)swipeGRSEL{
    NSString *SwipeGRSEL = objc_getAssociatedObject(self, UIView_Gesture_swipeGRSEL);
    if ([NSString isNullString:SwipeGRSEL]) {
        SwipeGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_swipeGRSEL,
                                 SwipeGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SwipeGRSEL;
}

-(void)setSwipeGRSEL:(NSString *)swipeGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRSEL,
                             swipeGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *panGRSEL;//平移手势触发方法
-(NSString *)panGRSEL{
    NSString *PanGRSEL = objc_getAssociatedObject(self, UIView_Gesture_panGRSEL);
    if ([NSString isNullString:PanGRSEL]) {
        PanGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_panGRSEL,
                                 PanGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PanGRSEL;
}

-(void)setPanGRSEL:(NSString *)panGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_panGRSEL,
                             panGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *pinchGRSEL;//捏合（缩放）手势触发方法
-(NSString *)pinchGRSEL{
    NSString *PinchGRSEL = objc_getAssociatedObject(self, UIView_Gesture_pinchGRSEL);
    if ([NSString isNullString:PinchGRSEL]) {
        PinchGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_pinchGRSEL,
                                 PinchGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PinchGRSEL;
}

-(void)setPinchGRSEL:(NSString *)pinchGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_pinchGRSEL,
                             pinchGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *rotationGRSEL;//旋转手势触发方法
-(NSString *)rotationGRSEL{
    NSString *RotationGRSEL = objc_getAssociatedObject(self, UIView_Gesture_rotationGRSEL);
    if ([NSString isNullString:RotationGRSEL]) {
        RotationGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_rotationGRSEL,
                                 RotationGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RotationGRSEL;
}

-(void)setRotationGRSEL:(NSString *)rotationGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotationGRSEL,
                             rotationGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *screenEdgePanGRSEL;//屏幕边缘平移触发方法
-(NSString *)screenEdgePanGRSEL{
    NSString *ScreenEdgePanGRSEL = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGRSEL);
    if ([NSString isNullString:ScreenEdgePanGRSEL]) {
        ScreenEdgePanGRSEL = @"defaultFunc";
        objc_setAssociatedObject(self,
                                 UIView_Gesture_screenEdgePanGRSEL,
                                 ScreenEdgePanGRSEL,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ScreenEdgePanGRSEL;
}

-(void)setScreenEdgePanGRSEL:(NSString *)screenEdgePanGRSEL{
    objc_setAssociatedObject(self,
                             UIView_Gesture_screenEdgePanGRSEL,
                             screenEdgePanGRSEL,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTapsRequired;//设置轻拍次数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTapsRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTapsRequired) unsignedIntegerValue];
}

-(void)setNumberOfTapsRequired:(NSUInteger)numberOfTapsRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTapsRequired,
                             [NSNumber numberWithInteger:numberOfTapsRequired],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTouchesRequired;//设置手指字数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTouchesRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTouchesRequired) unsignedIntegerValue];
}

-(void)setNumberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTouchesRequired,
                             [NSNumber numberWithUnsignedInteger:numberOfTouchesRequired],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSTimeInterval minimumPressDuration;//longPressGR最小长按时间【UILongPressGestureRecognizer】
-(NSTimeInterval)minimumPressDuration{
    return [objc_getAssociatedObject(self, UIView_Gesture_minimumPressDuration) doubleValue];
}

-(void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration{
    objc_setAssociatedObject(self,
                             UIView_Gesture_minimumPressDuration,
                             [NSNumber numberWithDouble:minimumPressDuration],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat allowableMovement;//【UILongPressGestureRecognizer】
-(CGFloat)allowableMovement{
    return [objc_getAssociatedObject(self, UIView_Gesture_allowableMovement) floatValue];
}

-(void)setAllowableMovement:(CGFloat)allowableMovement{
    objc_setAssociatedObject(self,
                             UIView_Gesture_allowableMovement,
                             [NSNumber numberWithFloat:allowableMovement],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)UISwipeGestureRecognizerDirection swipeGRDirection;//swipe手势清扫方向
-(UISwipeGestureRecognizerDirection)swipeGRDirection{
    return [objc_getAssociatedObject(self, UIView_Gesture_swipeGRDirection) unsignedIntegerValue];
}

-(void)setSwipeGRDirection:(UISwipeGestureRecognizerDirection)swipeGRDirection{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRDirection,
                             [NSNumber numberWithUnsignedInteger:swipeGRDirection],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)UIScrollTypeMask allowedScrollTypesMask;
-(UIScrollTypeMask)allowedScrollTypesMask{
    return [objc_getAssociatedObject(self, UIView_Gesture_swipeGRDirection) integerValue];
}

-(void)setAllowedScrollTypesMask:(UIScrollTypeMask)allowedScrollTypesMask{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRDirection,
                             [NSNumber numberWithInteger:allowedScrollTypesMask],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat scale;
-(CGFloat)scale{
    return [objc_getAssociatedObject(self, UIView_Gesture_scale) floatValue];
}

-(void)setScale:(CGFloat)scale{
    objc_setAssociatedObject(self,
                             UIView_Gesture_scale,
                             [NSNumber numberWithFloat:scale],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat rotate;
-(CGFloat)rotate{
    return [objc_getAssociatedObject(self, UIView_Gesture_rotate) floatValue];
}

-(void)setRotate:(CGFloat)rotate{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotate,
                             [NSNumber numberWithFloat:rotate],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按手势
-(UILongPressGestureRecognizer *)longPressGR{
    UILongPressGestureRecognizer *LongPressGR = objc_getAssociatedObject(self, UIView_Gesture_longPressGR);
    if (!LongPressGR) {
        LongPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self.target
                                                                    action:NSSelectorFromString(self.longPressGRSEL)];
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
        LongPressGR.delegate = self;
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
        TapGR = [[UITapGestureRecognizer alloc] initWithTarget:self.target
                                                        action:NSSelectorFromString(self.tapGRSEL)];
        
        if (self.numberOfTapsRequired != 0) {
            TapGR.numberOfTapsRequired = self.numberOfTapsRequired;//设置轻拍次数
        }
        
        if (self.numberOfTouchesRequired != 0) {
            TapGR.numberOfTouchesRequired = self.numberOfTouchesRequired;//设置手指字数
        }
        TapGR.delegate = self;
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
        SwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self.target
                                                            action:NSSelectorFromString(self.swipeGRSEL)];
        SwipeGR.delegate = self;
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
        PanGR = [[UIPanGestureRecognizer alloc] initWithTarget:self.target
                                                        action:NSSelectorFromString(self.panGRSEL)];
        PanGR.delegate = self;
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
        PinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self.target
                                                        action:NSSelectorFromString(self.pinchGRSEL)];
        PinchGR.delegate = self;
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
        RotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self.target
                                                                  action:NSSelectorFromString(self.rotationGRSEL)];
        RotationGR.delegate = self;
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
#pragma mark —— @property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgePanGR;//屏幕边缘平移 UIView_Gesture_screenEdgePanGR
-(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    UIScreenEdgePanGestureRecognizer *ScreenEdgePanGR = objc_getAssociatedObject(self, UIView_Gesture_rotationGR);
    if (!ScreenEdgePanGR) {
        ScreenEdgePanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.target
                                                                       action:NSSelectorFromString(self.screenEdgePanGRSEL)];
        ScreenEdgePanGR.delegate = self;
        [self addGestureRecognizer:ScreenEdgePanGR];
        objc_setAssociatedObject(self,
                                 UIView_Gesture_rotationGR,
                                 ScreenEdgePanGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ScreenEdgePanGR;
}

-(void)setScreenEdgePanGR:(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotationGR,
                             screenEdgePanGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)defaultFunc{
    NSLog(@"defaultFunc");
}

@end

