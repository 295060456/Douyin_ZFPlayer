//
//  JobsMagicTextField.m
//  BHBMagicFieldDemo
//
//  Created by Jobs on 2020/12/6.
//  Copyright © 2020 bihongbo. All rights reserved.
//

#import "JobsMagicTextField.h"

@interface JobsMagicTextField ()

@property(nonatomic,strong)UILabel *placeholderAnimationLbl;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation JobsMagicTextField

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init{
    if (self = [super init]) {
        self.placeholdAnimationable = YES;
        self.clipsToBounds = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeEditing)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:nil];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.placeholderAnimationLbl.alpha = 1;
        self.isOK = YES;
    }
}

-(void)changeEditing{
    if (!self.placeholdAnimationable) {
        if ([self.text isEqualToString:@""]) {
            self.placeholderAnimationLbl.hidden = NO;
        }else{
            self.placeholderAnimationLbl.hidden = YES;
        }
    }else{
        self.placeholderAnimationLbl.hidden = NO;
    }
}

- (BOOL)becomeFirstResponder{
    self.placeholder = @"";
    [self upAnimation];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    self.placeholder = self.placeholderAnimationLbl.text;
    [self restoreAnimation];
    return [super resignFirstResponder];
}

-(void)upAnimation{
    if (self.placeholdAnimationable) {
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = - self.moveDistance;
        @weakify(self)
        [UIView animateWithDuration:.25
                         animations:^{
            @strongify(self)
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.animationColor;
            self.placeholderAnimationLbl.font = self.animationFont;
        }];
    }
}

-(void)restoreAnimation{
    if (self.placeholdAnimationable) {
        if (self.text.length > 0 ||
            self.placeholderAnimationLbl.frame.origin.y == 0) {
            return ;
        }
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = 0;
        @weakify(self)
        [UIView animateWithDuration:.25
                         animations:^{
            @strongify(self)
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.placeholderColor;
            self.placeholderAnimationLbl.font = self.placeholderFont;
            self.placeholderAnimationLbl.attributedText = self.attributedPlaceholder;
        }];
    }
}

-(void)setText:(NSString *)text{
    [super setText:text];
    if (text.length > 0) {
        [self upAnimation];
    }else{
        [self restoreAnimation];
    }
}
#pragma mark —— lazyLoad
-(UILabel *)placeholderAnimationLbl{
    if (!_placeholderAnimationLbl) {
        _placeholderAnimationLbl = UILabel.new;
        _placeholderAnimationLbl.frame = CGRectMake(self.placeHolderOffset + self.leftViewOffsetX, self.y, self.width, self.height);
        _placeholderAnimationLbl.textColor = [UIColor blueColor];//[UIColor lightGrayColor];
        _placeholderAnimationLbl.textAlignment = NSTextAlignmentLeft;
        _placeholderAnimationLbl.text = self.placeholder;
        _placeholderAnimationLbl.attributedText = self.attributedPlaceholder;
        _placeholderAnimationLbl.font = self.font;
        [self addSubview:_placeholderAnimationLbl];
    }return _placeholderAnimationLbl;
}

-(UIColor *)animationColor{
    if (!_animationColor) {
        _animationColor = self.placeholderColor;
    }return _animationColor;
}

-(UIFont *)animationFont{
    if (!_animationFont) {
        _animationFont = self.placeholderFont;
    }return _animationFont;
}

-(UIFont *)placeholderFont{
    if (!_placeholderFont) {
        _placeholderFont = self.font;
    }return _placeholderFont;
}

-(CGFloat)moveDistance{
    if (_moveDistance == 0) {
        _moveDistance = self.frame.size.height / 2;
    }return _moveDistance;
}

@end
