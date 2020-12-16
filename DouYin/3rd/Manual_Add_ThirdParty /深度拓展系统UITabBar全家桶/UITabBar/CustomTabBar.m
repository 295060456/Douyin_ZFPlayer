//
//  CustomTabBar.m
//  HitTesting
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 flowyears. All rights reserved.
//

#import "CustomTabBar.h"
#import "LoadingImage.h"

@interface CustomTabBar ()

@end

@implementation CustomTabBar

- (instancetype __nullable)initWithBgImg:(UIImage *__nullable)bgImg{
    if (self = [super init]) {
        self.clipsToBounds = NO;//超出视图部分显示
        if (!bgImg) {
            bgImg = KIMG(@"gradualColor");
        }
        [self setBackgroundImage:bgImg];
    }return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setBarTintColor:self.bgColor];//这样写才能达到效果。
    self.barStyle = UIBarStyleBlack;
    self.translucent = self.isTranslucent;// 这句表示取消tabBar的透明效果。
}

//-(UIView *)hitTest:(CGPoint)point
//         withEvent:(UIEvent *)event{
//    
//}
#pragma mark —— LazyLoad
-(UIColor *)bgColor{
    if (!_bgColor) {
        _bgColor = [UIColor yellowColor];
    }return _bgColor;
}

@end
