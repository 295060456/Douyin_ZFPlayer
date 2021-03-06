//
//  UIView+BackgroundImage.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/22.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "UIView+BackgroundImage.h"
#import <objc/runtime.h>

@implementation UIView (BackgroundImage)

static char *UIView_BackgroundImage_backgroundImageView = "UIView_BackgroundImage_backgroundImageView";
@dynamic backgroundImageView;

-(UIImageView *)backgroundImageView{
    UIImageView *BackgroundImageView = objc_getAssociatedObject(self, UIView_BackgroundImage_backgroundImageView);
    if (!BackgroundImageView) {
        BackgroundImageView = UIImageView.new;
        [self addSubview:BackgroundImageView];
        [BackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        objc_setAssociatedObject(self,
                                 UIView_BackgroundImage_backgroundImageView,
                                 BackgroundImageView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackgroundImageView;
}

-(void)setBackgroundImageView:(UIImageView *)backgroundImageView{
    objc_setAssociatedObject(self,
                             UIView_BackgroundImage_backgroundImageView,
                             backgroundImageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
