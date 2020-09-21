//
//  LZBTabBarDelegate.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZBTabBar;

NS_ASSUME_NONNULL_BEGIN
#pragma mark - 自定义LZBTabBar
@protocol LZBTabBarDelegate <NSObject>
/**
 判断tabbbar是否被点击
 
 @param tabBar 自定义tabbar
 @param index 点击的tabbar的index
 @return 是否允许
 */
- (BOOL)lzb_tabBar:(LZBTabBar *)tabBar
shouldSelectItemAtIndex:(NSInteger)index;


/**
 点击tabbar的index
 
 @param tabBar 自定义tabbar
 @param index 点击的tabbar的index
 */
- (void)lzb_tabBar:(LZBTabBar *)tabBar
didSelectItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
