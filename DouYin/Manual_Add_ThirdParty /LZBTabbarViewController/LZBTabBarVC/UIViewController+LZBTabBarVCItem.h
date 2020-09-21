//
//  UIViewController+LZBTabBarViewControllerItem.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZBTabBarVC;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(LZBTabBarVCItem)

@property(nonatomic,strong)LZBTabBarItem *lzb_tabBarItem;
@property(nonatomic,strong)LZBTabBarVC *lzb_tabBarController;

@end

NS_ASSUME_NONNULL_END
