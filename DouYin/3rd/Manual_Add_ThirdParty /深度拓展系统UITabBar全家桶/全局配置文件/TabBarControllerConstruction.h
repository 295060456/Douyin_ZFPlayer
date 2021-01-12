//
//  TabBarControllerConstruction.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/11.
//

#import "TLTabBarAnimation.h"
#import "UITabBarItem+TLAnimation.h"
#import "DouYinAppDelegate.h"

/// 包装 viewController / 自定义样式UITabBarItem
/// @param viewController 被加工的VC
/// @param title 显示标题
/// @param imageSelected 选中状态的静态图
/// @param imageUnselected 未选中状态的静态图
/// @param humpOffsetY 凸起偏移量，传0就是不凸起
/// @param lottieName 只要不为空值则启用Lottie动画
/// @param tag tag值定位
static inline UIViewController *childViewController_customStyle(UIViewController *viewController,
                                                                NSString *title,
                                                                UIImage *imageSelected,
                                                                UIImage *imageUnselected,
                                                                CGFloat humpOffsetY,//Y轴凸起的偏移量 传0就是不凸起
                                                                NSString *lottieName,//有值则用Lottie动画
                                                                NSUInteger tag){
    TabBarControllerConfig *config = TabBarControllerConfig.new;
    config.vc = viewController;
    config.title = title;
    config.imageSelected = imageSelected;
    config.imageUnselected = imageUnselected;
    config.humpOffsetY = humpOffsetY;
    config.lottieName = lottieName;
    config.tag = tag;
    
    [[DouYinAppDelegate sharedInstance].tabBarVC.tabBarControllerConfigMutArr addObject:config];
    
//    setAnimation(viewController.tabBarItem, tag);//可选实现
    return viewController;
}
#pragma mark —— 创建动画函数
static inline TLBounceAnimation *bounceAnimation(){
    TLBounceAnimation *anm = TLBounceAnimation.new;
    anm.isPlayFireworksAnimation = YES;
    return anm;
}

static inline TLRotationAnimation *rotationAnimation(){
    TLRotationAnimation *anm = TLRotationAnimation.new;
    return anm;
}

static inline TLTransitionAniamtion *transitionAniamtion(){
    TLTransitionAniamtion *anm = TLTransitionAniamtion.new;
    anm.direction = 1; // 1~6
    anm.disableDeselectAnimation = NO;
    return anm;
}

static inline TLFumeAnimation *fumeAnimation(){
    TLFumeAnimation *anm = TLFumeAnimation.new;
    return anm;
}

static inline NSArray *imgs(){//静态轮播图
    NSMutableArray *temp = NSMutableArray.array;
    for (NSInteger i = 28 ; i <= 65; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Tools_000%zi", i];
        CGImageRef img = KIMG(imgName).CGImage;
        [temp addObject:(__bridge id _Nonnull)(img)];
    }return temp;
}

static inline TLFrameAnimation *frameAnimation(){
    TLFrameAnimation *anm = TLFrameAnimation.new;
    anm.images = imgs();
    anm.isPlayFireworksAnimation = YES;
    return anm;
}
#pragma mark —— 给UITabBarItem绑定动画
/// 给UITabBarItem绑定动画
static inline void setAnimation(UITabBarItem *item,
                  NSInteger index) {
     item.animation = @[
                       bounceAnimation(),
                       rotationAnimation(),
                       transitionAniamtion(),
                       fumeAnimation(),
                       frameAnimation()
                       ][index];
}
/*  系统样式UITabBarItem
 *  UITabBarSystemItemMore,
 *  UITabBarSystemItemFavorites,
 *  UITabBarSystemItemFeatured,
 *  UITabBarSystemItemTopRated,
 *  UITabBarSystemItemRecents,
 *  UITabBarSystemItemContacts,
 *  UITabBarSystemItemHistory,
 *  UITabBarSystemItemBookmarks,
 *  UITabBarSystemItemSearch,
 *  UITabBarSystemItemDownloads,
 *  UITabBarSystemItemMostRecent,
 *  UITabBarSystemItemMostViewed,
 */
static inline UIViewController *childViewController_SystemStyle(UIViewController *viewController,
                                                                UITabBarSystemItem systemItem,
                                                                NSUInteger tag){
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem
                                                                           tag:tag];
    setAnimation(viewController.tabBarItem, tag);//可选实现
    return viewController;
}
