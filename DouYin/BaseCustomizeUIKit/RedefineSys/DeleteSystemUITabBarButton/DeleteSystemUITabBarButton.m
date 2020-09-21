//
//  DeleteSystemUITabBarButton.m
//  JinXian Finance
//
//  Created by 刘赓 on 2017/6/7.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import "DeleteSystemUITabBarButton.h"

@implementation DeleteSystemUITabBarButton

+(void)deleteSystemUITabBarButton:(UITabBar *)tabBar{
    
    // 移除之前的4个UITabBarButton
    for (UIView *childView in tabBar.subviews) {
        
        if ([childView isKindOfClass:[UIControl class]]) {//UITabBarButton
            
            [childView removeFromSuperview];
        }
    }
    
}

@end
