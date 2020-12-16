//
//  ZZCountingLabel.m
//  动画测试
//
//  Created by 周兴 on 2017/6/29.
//  Copyright © 2017年 周兴. All rights reserved.
//

#import "ZZCountingLabel.h"

@interface ZZCountingLabel ()

@property(nonatomic,strong)CADisplayLink *playLink;
@property(nonatomic,assign)NSInteger displayPerSecond;

@property(nonatomic,assign)CGFloat fromValue;
@property(nonatomic,assign)CGFloat toValue;

@property(nonatomic,assign)CGFloat increaseValue;
@property(nonatomic,assign)CGFloat perValue;

@end

@implementation ZZCountingLabel

-(instancetype)init {
    if (self = [super init]) {
        [self initValues];
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initValues];
    }return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initValues];
}

-(void)initValues {
    _duration = 2.0;
    _displayPerSecond = 30;
}

-(void)countingFrom:(CGFloat)fromValue
                  to:(CGFloat)toValue {
    [self countingFrom:fromValue
                    to:toValue
              duration:_duration];
}

-(void)countingFrom:(CGFloat)fromValue
                  to:(CGFloat)toValue
            duration:(CGFloat)duration {
    
    _fromValue = fromValue;
    _toValue = toValue;
    _duration = duration;
    
    _increaseValue = _fromValue;
    _perValue = (_toValue - _fromValue) / (_duration == 0 ? 1 : (_displayPerSecond * _duration));
     
    if (self.playLink) {
        [self.playLink invalidate];
        self.playLink = nil;
    }
    
    CADisplayLink *playLink = [CADisplayLink displayLinkWithTarget:self
                                                          selector:@selector(countingAction)];
    if (@available(iOS 10.0, *)) {
        playLink.preferredFramesPerSecond = _displayPerSecond;
    }else{
        playLink.frameInterval = 60 / (_displayPerSecond == 0 ? 1 : _displayPerSecond);
    }
    
    [playLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];//定时器只运行在NSDefaultRunLoopMode下，一旦RunLoop进入其他模式，这个定时器就不会工作
    [playLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];//界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
    self.playLink = playLink;
}

- (void)countingAction {
    _increaseValue += _perValue;
    
    if (_fromValue < _toValue) {
        if (_increaseValue >= _toValue) {
            [self stopDisplayLink];
        }
    } else {
        if (_increaseValue <= _toValue) {
            [self stopDisplayLink];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.text = [NSString isNullString:self.placeStr] ? [NSString stringWithFormat:@"%.0f%%",self->_increaseValue] : self.placeStr;
    });
}

-(void)stopDisplayLink {
    [self.playLink invalidate];
    self.playLink = nil;
    _increaseValue = _toValue;
}

-(void)setPlaceStr:(NSString *)placeStr{
    _placeStr = placeStr;
    self.text = _placeStr;
}

@end
