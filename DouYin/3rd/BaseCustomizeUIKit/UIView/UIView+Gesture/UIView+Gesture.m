//
//  UIView+Gesture.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "UIView+Gesture.h"

@implementation UIView (Gesture)
// config
static char *UIView_Gesture_target = "UIView_Gesture_target";
@dynamic target;

static char *UIView_Gesture_longPressGRSEL = "UIView_Gesture_longPressGRSEL";
@dynamic longPressGRSEL;

static char *UIView_Gesture_tapGRSEL = "UIView_Gesture_tapGRSEL";
@dynamic tapGRSEL;

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
// UIGestureRecognizer
static char *UIView_Gesture_longPressGR = "UIView_Gesture_longPressGR";
@dynamic longPressGR;

static char *UIView_Gesture_tapGR = "UIView_Gesture_tapGR";
@dynamic tapGR;

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

-(void)defaultFunc{
    NSLog(@"defaultFunc");
}

@end

