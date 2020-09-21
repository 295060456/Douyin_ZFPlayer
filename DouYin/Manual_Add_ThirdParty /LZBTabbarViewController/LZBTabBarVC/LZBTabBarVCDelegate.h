//
//  LZBTabBarViewControllerDelegate.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZBTabBarVC;

NS_ASSUME_NONNULL_BEGIN

@protocol LZBTabBarVCDelegate <NSObject>

@optional
/**
 是否点击控制器

 @param tabBarController tabbar控制器
 @param viewController   点击的那个控制器
 @return 是否允许
 */
- (BOOL)lzb_tabBarController:(LZBTabBarVC *_Null_unspecified)tabBarController
  shouldSelectViewController:(UIViewController *_Null_unspecified)viewController;
/**
 选择tabbar控制器
 
 @param tabBarController tabbar控制器
 @param viewController 点击的那个控制器
 */
- (void)lzb_tabBarController:(LZBTabBarVC *_Null_unspecified)tabBarController
     didSelectViewController:(UIViewController *_Null_unspecified)viewController;

@end

NS_ASSUME_NONNULL_END
