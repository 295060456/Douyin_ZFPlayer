//
//  UIButton+ImageTitleSpacing.h
//  Intelligent_Fire
//
//  Created by 高磊 on 2016/12/19.
//  Copyright © 2016年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, GLButtonEdgeInsetsStyle) {
    GLButtonEdgeInsetsStyleTop, // image在上，label在下
    GLButtonEdgeInsetsStyleLeft, // image在左，label在右
    GLButtonEdgeInsetsStyleBottom, // image在下，label在上
    GLButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *  这一句一定要放在有frame以后执行，否则界面错乱
 *  在设置完title以后写
 *  在title竖排模式情况下，frame一定要装得下整行字
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

/*
 *

 -(void)setIsSelected:(BOOL)isSelected{
 _isSelected = isSelected;
 self.mkZanView.selected = _isSelected;
 if (self.mkZanView.selected) {
     //特别重要，花了老子半个小时，mmp.只要改变选择状态都要进行刷新 走这一句
     [self.mkZanView setTitle:self.ZanNumStr forState:UIControlStateSelected];
 }
 [self.mkZanView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                    imageTitleSpace:5];
}

 *
 */
