//
//  UIViewController+LZBTabBarViewControllerItem.m
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIViewController+LZBTabBarVCItem.h"
#import <objc/runtime.h>

static const void *LZBTabBarVCItemKey = @"LZBTabBarVCItemKey";

@implementation UIViewController (LZBTabBarVCItem)

- (void)setLzb_tabBarController:(LZBTabBarVC *)lzb_tabBarController{
   objc_setAssociatedObject(self,
                            LZBTabBarVCItemKey,
                            lzb_tabBarController,
                            OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LZBTabBarVC *)lzb_tabBarController{
    LZBTabBarVC *tabBarVC = objc_getAssociatedObject(self, LZBTabBarVCItemKey);
    if(!tabBarVC && self.parentViewController)
        tabBarVC = self.parentViewController.lzb_tabBarController;
    return tabBarVC;
}

- (void)setLzb_tabBarItem:(LZBTabBarItem *)lzb_tabBarItem{
    LZBTabBarVC *tabBarViewController = self.lzb_tabBarController;
    if(tabBarViewController == nil) return;
    LZBTabBar *tabBar = tabBarViewController.lzb_tabBar;
    //当前这个控制器在tabbar的索引
    NSInteger index = [tabBarViewController indexForTabBarViewControllerViewControllers:self];
    if(index < 0 ||
       index >= tabBarViewController.lzb_tabBar.lzbTabBarItemsArr.count) return;
    //替换
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar lzbTabBarItemsArr]];
    [tabBarItems replaceObjectAtIndex:index
                           withObject:lzb_tabBarItem];
    [tabBar setLzbTabBarItemsArr:tabBarItems];
}

- (LZBTabBarItem *)lzb_tabBarItem{
    LZBTabBarVC *tabBarController = [self lzb_tabBarController];
    NSInteger index = [tabBarController indexForTabBarViewControllerViewControllers:self];
    if(index < 0 ||
       index >= tabBarController.lzb_tabBar.lzbTabBarItemsArr.count) return nil;
    return [tabBarController.lzb_tabBar.lzbTabBarItemsArr objectAtIndex:index];
}



@end

