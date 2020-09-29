//
//  LGiOSBtn.m
//  My_BaseProj
//
//  Created by hello on 2019/7/4.
//  Copyright © 2019 Corp. All rights reserved.
//

#import "LGiOSBtn.h"
#import "UIView+Chain.h"

@interface LGiOSBtn ()

// 遮盖，在抖动时出现
@property(nonatomic,strong)UIView *coverView;

@property(nonatomic,strong)UITapGestureRecognizer *coverViewTap;
@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@property(nonatomic,strong)UITapGestureRecognizer *iconBtnTap;
@property(nonatomic,strong)CAKeyframeAnimation *anim;

@end

@implementation LGiOSBtn

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:KIMG(@"加号")
              forState:UIControlStateNormal];
        [self addLongPressGestureRecognizer];
        self.iconBtn.hidden = YES;
    }return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self setImage:KIMG(@"加号")
              forState:UIControlStateNormal];
        [self addLongPressGestureRecognizer];
        self.iconBtn.hidden = YES;
    }return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setImage:KIMG(@"加号")
              forState:UIControlStateNormal];
        [self addLongPressGestureRecognizer];
        self.iconBtn.hidden = YES;
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 调整位置
    self.imageView.mj_x = 0;
    self.imageView.mj_y = 0;
    self.imageView.mj_w = self.mj_w;
    self.imageView.mj_h = self.mj_w;

    self.titleLabel.mj_x = 0;
    self.titleLabel.mj_w = self.mj_w;
    if (self.mj_w >= self.mj_h) {
        self.titleLabel.mj_h = 20;
        self.titleLabel.mj_y = self.mj_h - self.titleLabel.mj_h;
    } else {
        self.titleLabel.mj_y = self.imageView.mj_h;
        self.titleLabel.mj_h = self.mj_h - self.titleLabel.mj_y;
    }

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self bringSubviewToFront:_iconBtn];
}
// 添加长按手势
- (void)addLongPressGestureRecognizer {
    [self addGestureRecognizer:self.longPress];
}
// 是否执行动画
- (void)setShaking:(BOOL)shaking {
    if (shaking) {
        [self.layer addAnimation:self.anim
                          forKey:@"shake"];
        self.coverView.hidden = NO;
        self.iconBtn.hidden = NO;
    } else {
        [self.layer removeAllAnimations];
        self.coverView.hidden = YES;
        self.iconBtn.hidden = YES;
    }
}

- (void)longClick {
    if (![self.imageView.image isEqual:KIMG(@"加号")]) {
        if (self.shaking) return;
        self.shaking = YES;
    }
}
// 点击右上角按钮
- (void)iconClick{
    // 设计一个代理，为了在自己被删除后做一些事情(例如，对页面进行布局)
    if ([self.delegate respondsToSelector:@selector(deleteButtonRemoveSelf:)]) {
        [self.delegate deleteButtonRemoveSelf:self];
    }
}

- (void)coverClick {
    self.shaking = NO;
}
#pragma mark —— lazyLoad
- (UIImageView *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[UIImageView alloc] initWithImage:KIMG(@"del_Photo")];
        _iconBtn.userInteractionEnabled = YES;
        _iconBtn.ableRespose = YES;
        [_iconBtn addGestureRecognizer:self.iconBtnTap];
        [self addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(20), SCALING_RATIO(20)));
            make.top.equalTo(self).offset(-SCALING_RATIO(20) / 2);
            make.right.equalTo(self).offset(SCALING_RATIO(20) / 2);
        }];
    }return _iconBtn;
}
/// 抖动动画
-(CAKeyframeAnimation *)anim{
    if (!_anim) {
    #define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
        _anim = CAKeyframeAnimation.animation;
        _anim.keyPath = @"transform.rotation";
        _anim.values = @[@(Angle2Radian(-5)),
                        @(Angle2Radian(5)),
                        @(Angle2Radian(-5))];
        _anim.duration = 0.25;
        // 动画次数设置为最大
        _anim.repeatCount = MAXFLOAT;
        // 保持动画执行完毕后的状态
        _anim.removedOnCompletion = NO;
        _anim.fillMode = kCAFillModeForwards;
    }return _anim;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = UIView.new;
        _coverView.backgroundColor = kClearColor;
        _coverView.hidden = YES;
        [_coverView addGestureRecognizer:self.coverViewTap];
        [self addSubview:_coverView];
        _coverView.frame = self.bounds;
    }return _coverView;
}

-(UITapGestureRecognizer *)coverViewTap{
    if (!_coverViewTap) {
        _coverViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(coverClick)];
    }return _coverViewTap;
}

-(UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(longClick)];
    }return _longPress;
}

-(UITapGestureRecognizer *)iconBtnTap{
    if (!_iconBtnTap) {
        _iconBtnTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(iconClick)];
    }return _iconBtnTap;
}

@end
