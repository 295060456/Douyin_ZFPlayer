//
//  TabbarVC.h
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "LoadingImage.h"
#import <Lottie/Lottie.h>

#import "NSObject+Sound.h"
#import "NSObject+Extras.h"

#import "UITabBar+Ex.h"
#import "TabBarItem.h"
#import "UIView+Measure.h"
#import "CustomTabBar.h"
#import "PPBadgeView.h"
#import "SuspendBtn.h"

#import "TabBarControllerConfig.h"

/*
 * 1、如果用系统的 UITabBarController —— UITabBar 当关联VC ＞ 6 个的时候，最后一个会变成more按钮，其余的VC会在more按钮里面形成一个TableView来进行展现
 * 2、如果希望下方是可以滑动的效果，只能用UIView系列来实现，这里推崇第三方工具库 pod 'JXCategoryView'  # https://github.com/pujiaxin33/JXCategoryView A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)
 */

/// 此类仅仅对系统给出的 UITabBarController —— UITabBar做最大程度上的增加功能，并且解耦
@interface TabbarVC : UITabBarController

@property(nonatomic,strong)CustomTabBar *myTabBar;//myTabBar.humpOffsetY 凸起的高度自定义，默认值30  offsetHeight
@property(nonatomic,assign)NSInteger firstUI_selectedIndex;//初始显示第一个
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childMutArr;//子控制器
@property(nonatomic,assign)BOOL isOpenScrollTabbar;//是否开启手势横向滚动子VC联动Tabbar切换，默认开启
@property(nonatomic,strong)NSMutableArray <TabBarControllerConfig *>*tabBarControllerConfigMutArr;
@property(nonatomic,strong)SuspendBtn *suspendBtn;//单个VC里面的旋转按钮,当在旋转的时候不能被拖动

/// 包装 viewController / 自定义样式UITabBarItem
/// @param viewController 被加工的VC
/// @param title 显示标题
/// @param imageSelected 选中状态的静态图
/// @param imageUnselected 未选中状态的静态图
/// @param humpOffsetY 凸起偏移量，传0就是不凸起
/// @param lottieName 只要不为空值则启用Lottie动画
/// @param tag tag值定位
UIViewController *childViewController_customStyle(UIViewController *viewController,
                                                  NSString *title,
                                                  UIImage *imageSelected,
                                                  UIImage *imageUnselected,
                                                  CGFloat humpOffsetY,//Y轴凸起的偏移量 传0就是不凸起
                                                  NSString *lottieName,//有值则用Lottie动画
                                                  NSUInteger tag);

UIViewController *childViewController_SystemStyle(UIViewController *viewController,
                                                  UITabBarSystemItem systemItem,
                                                  NSUInteger tag);

@end
