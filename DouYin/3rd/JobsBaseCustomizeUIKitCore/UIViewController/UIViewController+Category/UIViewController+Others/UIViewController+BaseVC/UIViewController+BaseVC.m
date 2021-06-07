//
//  UIViewController+BaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BaseVC.h"
#import <objc/runtime.h>

@implementation UIViewController (BaseVC)

static char *UIViewController_BaseVC_requestParams = "UIViewController_BaseVC_requestParams";
static char *UIViewController_BaseVC_pushOrPresent = "UIViewController_BaseVC_pushOrPresent";
static char *UIViewController_BaseVC_rootVC = "UIViewController_BaseVC_rootVC";

@dynamic requestParams;
@dynamic pushOrPresent;
@dynamic rootVC;
#pragma mark —— present
/// 简洁版强制present展现一个控制器页面【不需要正向传参】
-(void)comingToPresentVC:(UIViewController *)viewController{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/// 简洁版强制present展现一个控制器页面【需要正向传参】
-(void)comingToPresentVC:(UIViewController *)viewController
    requestParams:(id _Nullable)requestParams{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIModalPresentationFullScreen
                     requestParams:requestParams
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
#pragma mark —— push
/// 简洁版强制push展现一个控制器页面【不需要正向传参】
-(void)comingToPushVC:(UIViewController *)viewController{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/// 简洁版强制push展现一个控制器页面【需要正向传参】
-(void)comingToPushVC:(UIViewController *)viewController
    requestParams:(id _Nullable)requestParams{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationFullScreen
                     requestParams:requestParams
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
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
                    success:(nullable MKDataBlock)successBlock{
    if (toVC) {
        toVC.requestParams = requestParams;
        toVC.rootVC = rootVC;
        @weakify(rootVC)
        switch (comingStyle) {
            case ComingStyle_PUSH:{
                if (rootVC.navigationController) {
                    toVC.pushOrPresent = ComingStyle_PUSH;
                    if (successBlock) {
                        successBlock(toVC);
                    }
                    toVC.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;//下面有黑条
                    [weak_rootVC.navigationController pushViewController:toVC
                                                                animated:animated];
                }else{
                    toVC.pushOrPresent = ComingStyle_PRESENT;
                    //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                    toVC.modalPresentationStyle = presentationStyle;
                    if (successBlock) {
                        successBlock(toVC);
                    }
                    [weak_rootVC presentViewController:toVC
                                              animated:animated
                                            completion:^{}];
                }
            }break;
            case ComingStyle_PRESENT:{
                toVC.pushOrPresent = ComingStyle_PRESENT;
                //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                toVC.modalPresentationStyle = presentationStyle;
                if (successBlock) {
                    successBlock(toVC);
                }
                [weak_rootVC presentViewController:toVC
                                          animated:animated
                                        completion:^{}];
            }break;
            default:
                NSLog(@"错误的推进方式");
                break;
        }return toVC;
    }else{
        return nil;// 为了防止多次推VC
    }
}
#pragma mark —— @property(nonatomic,strong)id requestParams;
-(id)requestParams{
    id RequestParams = objc_getAssociatedObject(self, UIViewController_BaseVC_requestParams);
    return RequestParams;
}

-(void)setRequestParams:(id)requestParams{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_requestParams,
                             requestParams,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)ComingStyle pushOrPresent;
-(ComingStyle)pushOrPresent{
    return [objc_getAssociatedObject(self, UIViewController_BaseVC_pushOrPresent) integerValue];
}

-(void)setPushOrPresent:(ComingStyle)pushOrPresent{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_pushOrPresent,
                             [NSNumber numberWithInteger:pushOrPresent],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIViewController *rootVC;
-(UIViewController *)rootVC{
    return objc_getAssociatedObject(self, UIViewController_BaseVC_rootVC);;
}

-(void)setRootVC:(UIViewController *)rootVC{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_rootVC,
                             rootVC,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
