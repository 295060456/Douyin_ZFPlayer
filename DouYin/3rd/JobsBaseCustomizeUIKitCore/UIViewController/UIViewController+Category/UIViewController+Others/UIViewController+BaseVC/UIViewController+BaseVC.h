//
//  UIViewController+BaseVC.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BaseVC)<BaseViewControllerProtocol>

#pragma mark —— present
/// 简洁版强制present展现一个控制器页面【不需要正向传参】
-(void)comingToPresentVC:(UIViewController *)viewController;
/// 简洁版强制present展现一个控制器页面【需要正向传参】
-(void)comingToPresentVC:(UIViewController *)viewController
           requestParams:(id _Nullable)requestParams;
#pragma mark —— push
/// 简洁版强制展现一个控制器页面【不需要正向传参】
-(void)comingToPushVC:(UIViewController *)viewController;
/// 简洁版强制展现一个控制器页面【需要正向传参】
-(void)comingToPushVC:(UIViewController *)viewController
    requestParams:(id _Nullable)requestParams;
/// 强制推控制器，自定义是PUSH还是PRESENT展现控制器，如果自定义PUSH但是navigationController不存在，则换用PRESENT展现控制器
/// @param rootVC 从A控制器
/// @param toVC  推到B控制器
/// @param comingStyle 自定义展现的方式
/// @param presentationStyle  如果是PRESENT情况下的一个系统参数设定
/// @param requestParams  A控制器—>B控制器，正向传值
/// @param hidesBottomBarWhenPushed 跳转子页面的时候隐藏tabbar
/// @param animated  是否动画展现
/// @param successBlock 在推控制器之前，反向block(B控制器），以便对B控制器的一些自定义修改
+(instancetype)comingFromVC:(UIViewController *)rootVC
                       toVC:(UIViewController *)toVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
   hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
                   animated:(BOOL)animated
                    success:(nullable MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
