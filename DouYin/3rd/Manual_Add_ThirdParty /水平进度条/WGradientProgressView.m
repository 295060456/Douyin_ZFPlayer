//
//  WGradientProgressLab.m
//  Shooting
//
//  Created by Jobs on 2020/9/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "WGradientProgressView.h"

@interface WGradientProgressView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation WGradientProgressView

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (self.img) {
            self.imgV.alpha = 1;
        }
        self.titleLab.alpha = 1;
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.textColor = self.titleColor;
        _titleLab.font = self.titleFont;
        [_titleLab sizeToFit];
        if (self.img) {
            [self.imgV addSubview:_titleLab];
        }else{
            [self addSubview:_titleLab];
        }
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }return _titleLab;
}

-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = UIImageView.new;
        _imgV.image = self.img;
        [self addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _imgV;
}

-(UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:6.5
                                       weight:UIFontWeightRegular];
    }return _titleFont;
}

-(UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = kRedColor;
    }return _titleColor;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = _titleStr;
//    [self.titleLab sizeToFit];
}

@end
