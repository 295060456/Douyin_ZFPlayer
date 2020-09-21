//
//  LZBTabBar.h
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBTabBarDelegate.h"
#import "LZBTabBarItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LZBTabBarStyleType_sysNormal = 0,//系统默认样式，平的
    LZBTabBarStyleType_middleItemUp//最中间的按钮凸起中间(前提条件是存在奇数个item)
} LZBTabBarStyleType;

@interface LZBTabBar : UIView

@property(nonatomic,strong)NSMutableArray <NSString *>*lottieJsonNameStrMutArr;

@property(nonatomic,assign)LZBTabBarStyleType tabBarStyleType;

/**
 *  自定义tabbar的delegate
 */
@property(nonatomic,weak)id<LZBTabBarDelegate> delegate;
/**
 *  TabBar设置按钮数组items
 */
@property(nonatomic,strong)NSArray <LZBTabBarItem *>*lzbTabBarItemsArr;
/**
 *  TabBar设置当前选中的item
 */
@property(nonatomic,strong)LZBTabBarItem *currentSelectItem;
/**
 *  TabBar设置当前选中的item,animation动画
 */
- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem
                   animation:(BOOL)animation;
/**
 * TabBar顶部分割线
 */
@property(nonatomic,strong)UIView *topLine;
/**
 * TabBar背景View
 */
@property(nonatomic,strong)UIView *backgroundView;

@end



NS_ASSUME_NONNULL_END



