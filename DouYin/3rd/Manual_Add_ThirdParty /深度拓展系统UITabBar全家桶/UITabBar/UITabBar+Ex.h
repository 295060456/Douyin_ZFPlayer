//
//  UITabBar+Ex.h
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Ex)

-(void)addLottieImage:(NSUInteger)index
              offsetY:(CGFloat)offsetY
           lottieName:(NSString *)lottieName;
-(void)animationLottieImage:(NSInteger)index;

@end
