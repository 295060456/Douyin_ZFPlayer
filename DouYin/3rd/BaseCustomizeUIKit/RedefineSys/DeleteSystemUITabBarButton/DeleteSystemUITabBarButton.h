//
//  DeleteSystemUITabBarButton.h
//  JinXian Finance
//
//  Created by 刘赓 on 2017/6/7.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteSystemUITabBarButton : NSObject

/**
 * 移除 系统自带的 UITabBarButton
 */
+(void)deleteSystemUITabBarButton:(UITabBar *)tabBar;

@end

NS_ASSUME_NONNULL_END
