#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Block)

/**
 *  button 添加点击事件
 */
- (void)addAction:(ButtonBlock)block;

/// 添加背景圖可以旋轉 Pi/2 的Button
- (void)addActionAutoImage:(ButtonBlock)block;

/**
 *  button 添加事件
 *  @param controlEvents 点击的方式
 */
- (void)addAction:(ButtonBlock)block
 forControlEvents:(UIControlEvents)controlEvents;

/// 添加背景圖可以旋轉 Pi 的Button
- (void)addActionAutoImageWithPI:(ButtonBlock)block;

@end
