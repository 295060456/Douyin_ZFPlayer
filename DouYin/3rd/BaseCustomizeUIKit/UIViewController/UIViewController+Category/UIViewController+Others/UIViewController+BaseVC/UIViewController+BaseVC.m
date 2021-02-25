//
//  UIViewController+BaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BaseVC.h"

@implementation UIViewController (BaseVC)

static char *UIViewController_BaseVC_requestParams = "UIViewController_BaseVC_requestParams";
static char *UIViewController_BaseVC_pushOrPresent = "UIViewController_BaseVC_pushOrPresent";

@dynamic requestParams;
@dynamic pushOrPresent;

+(instancetype)comingFromVC:(UIViewController *)rootVC
                       toVC:(UIViewController *)toVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
   hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
                   animated:(BOOL)animated
                    success:(nullable MKDataBlock)successBlock{
    toVC.requestParams = requestParams;
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
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
