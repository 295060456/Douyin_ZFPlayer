//
//  LZBTabBarVC.h
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "LZBTabBarVC.h"
#import "LZBTabBar.h"
#import "UIViewController+LZBTabBarVCItem.h"
#import "LZBTabBarItem.h"
#import "LZBTabBarDelegate.h"
#import "LZBTabBarVCDelegate.h"

@class LZBTabBarViewControllerDelegate;
/**
    用于自定义替换系统的 UITabBarController
 */
NS_ASSUME_NONNULL_BEGIN

@interface LZBTabBarVC : BaseVC

@property(nonatomic,weak)id<LZBTabBarVCDelegate> delegate;
@property(nonatomic,strong)UIViewController *selectedViewController;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,assign)BOOL isTop;//是否永远置于顶层 默认是永远
/**
 *  子控制数组
 */
@property(nonatomic,strong)NSArray <UIViewController *>*viewControllers;//NSMutableArray
/**
 *  当前选中的控制器
 */
@property(nonatomic,strong,readonly)UIViewController *lzb_selectedViewController;
/**
 当前选中的控制器,是否包含动画效果

 @param selectedViewController 选中按个控制器
 @param animation 动画效果
 */
- (void)setSelectedViewController:(UIViewController *)selectedViewController
                        animation:(BOOL)animation;
/**
 *  当前选中的控制器的索引
 */
@property(nonatomic,assign)NSUInteger selectedIndex;
/**
  当前选中的控制器索引,是否包含动画效果

 @param selectedIndex 选中索引
 @param animation 是否动画
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex
               animation:(BOOL)animation;
/**
    是否允许动画
 */
@property(nonatomic,assign)BOOL isShouldAnimation;
/**
 *  获得当前tabbar
 */
@property(nonatomic,strong)LZBTabBar *lzb_tabBar;
/**
 *   隐藏导航条
 */
@property(nonatomic,assign)BOOL lzb_tabBarHidden;
/**
    隐藏导航条，是否动画
 */
-(void)setLzb_tabBarHidden:(BOOL)lzb_tabBarHidden
                  animated:(BOOL)animation;

-(NSInteger)indexForTabBarViewControllerViewControllers:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END


