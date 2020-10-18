//
//  TabBarItem.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import <UIKit/UIKit.h>
#import "TabBarControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN

#warning UITabBarItem 不是 UIView的子类，所以无法在其子类里面添加任何手势以及视图
@interface TabBarItem : UITabBarItem

-(instancetype)initWithConfig:(TabBarControllerConfig *)config;

@end

NS_ASSUME_NONNULL_END
