//
//  BaseViewController.h
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import <UIKit/UIKit.h>
#import "UIView+EmptyData.h"
#import "UIViewController+NavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(nonatomic,assign)BOOL setupNavigationBarHidden;

@end

NS_ASSUME_NONNULL_END

/**
 *  要想隐藏系统的导航栏，这里有2个手段。一个是在UIViewController的基类，一个是在UIViewController的分类
 * 1、如果要在viewDidLoad实现隐藏系统的导航栏，则调用UIViewController基类的父类方法self.setupNavigationBarHidden = YES;
 * 2、如果要在viewWillAppear实现隐藏系统的导航栏，则调用UIViewController分类的方法self.isHiddenNavigationBar = YES;//禁用系统的导航栏
 */
