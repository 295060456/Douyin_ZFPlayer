//
//  HQTextField.m
//  HQTextFieldDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQTextField.h"

@interface HQTextField ()

@property(nonatomic,strong)CAShapeLayer *warnLayer;
@property(nonatomic,strong)CABasicAnimation *opacityAnimation;

@end

@implementation HQTextField

#pragma mark -- 警示框
- (void)showWarn {
    // 透明度变化
    [self.layer addSublayer:self.warnLayer];
    // 2秒后移除动画
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(2.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
        // 移除动画
        @strongify(self)
        [self.warnLayer removeFromSuperlayer];
    });
}

#pragma mark -- 改变光标起始位置
// 控制placeHolder的位置，左右缩20，但是光标位置不变
/*
 - (CGRect)placeholderRectForBounds:(CGRect)bounds
 {
 CGRect inset = CGRectMake(bounds.origin.x+100, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
 return inset;
 }
 */
// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 10,
                              bounds.origin.y,
                              bounds.size.width - 25,
                              bounds.size.height);//更好理解些
    return inset;
}
// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 10,
                              bounds.origin.y,
                              bounds.size.width - 25,
                              bounds.size.height);//更好理解些
    return inset;
}

#pragma mark —— lazyLoad
-(CAShapeLayer *)warnLayer{
    if (!_warnLayer) {
        _warnLayer = [CAShapeLayer layer];// 设置layer相关属性
        _warnLayer.frame = self.bounds;// 大小和文本框一致
        _warnLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.warnLayer.bounds
                                                     cornerRadius:0].CGPath;// 画线 非圆角
        _warnLayer.lineWidth = 6. / [[UIScreen mainScreen] scale];// 线宽
        _warnLayer.lineDashPattern = nil;// 设置为实线
        _warnLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明色
        _warnLayer.strokeColor = [UIColor redColor].CGColor;// 边框颜色为红色
        [_warnLayer addAnimation:self.opacityAnimation
                          forKey:@"opacity"];
    }return _warnLayer;
}

-(CABasicAnimation *)opacityAnimation{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        _opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
        _opacityAnimation.repeatCount = 5;
        _opacityAnimation.repeatDuration = 2;
        _opacityAnimation.autoreverses = YES;
    }return _opacityAnimation;
}


@end
