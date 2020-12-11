//
//  UIViewController+NavigationBar.h
//  UBallLive
//
//  Created by Jobs on 2020/10/21.
//

#import <UIKit/UIKit.h>
#import "NavigationBar.h"

NS_ASSUME_NONNULL_BEGIN
// 自定义 NavigationBar
@interface UIViewController (NavigationBar)

@property(nonatomic,strong)NavigationBar *navigationBar;
@property(nonatomic,strong)UIBarButtonItem *leftBarButtonItem_back;
@property(nonatomic,strong)UINavigationItem *navItem;
@property(nonatomic,strong)UIColor *bgCor;
@property(nonatomic,strong)UIImage *backgroundImage;
@property(nonatomic,assign)CGFloat navigationBarHeight;
@property(nonatomic,assign)BOOL isHiddenNavigationBar;
@property(nonatomic,assign)BOOL isBarTranslucent;
@property(nonatomic,strong)UIColor *tintColor;
@property(nonatomic,strong)UIColor *barTintColor;
@property(nonatomic,strong)NSString *title;

//titleTextAttributes
@property(nonatomic,strong)NSShadow *shadow;
@property(nonatomic,strong)UIColor *shadowCor;
@property(nonatomic,strong)UIColor *foregroundColorAttributeNameCor;
@property(nonatomic,strong)UIFont *fontAttributeName;

@end

NS_ASSUME_NONNULL_END
