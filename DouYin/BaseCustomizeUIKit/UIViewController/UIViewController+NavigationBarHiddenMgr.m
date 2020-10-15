//
//  UIViewController+NavigationBarHiddenMgr.m
//  UBallLive
//
//  Created by Jobs on 2020/10/13.
//

#import "UIViewController+NavigationBarHiddenMgr.h"

@implementation UIViewController (NavigationBarHiddenMgr)

#pragma mark —— UINavigationControllerDelegate
- (void)navigationController:(UINavigationController*)navigationController
      willShowViewController:(UIViewController*)viewController
                    animated:(BOOL)animated {
    NSLog(@"self = %@",self);
    if(viewController == self){
        NSLog(@"SELF = %@",self);
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        
        //系统相册继承自 UINavigationController 这个不能隐藏 所有就直接return
        if ([navigationController isKindOfClass:UIImagePickerController.class]) {
            return;
        }
        
        //不在本页时，显示真正的navbar
        [navigationController setNavigationBarHidden:NO animated:YES];
        //当不显示本页时，要么就push到下一页，要么就被pop了，那么就将delegate设置为nil，防止出现BAD ACCESS
        //之前将这段代码放在viewDidDisappear和dealloc中，这两种情况可能已经被pop了，self.navigationController为nil，这里采用手动持有navigationController的引用来解决
        if(navigationController.delegate == self){
            //如果delegate是自己才设置为nil，因为viewWillAppear调用的比此方法较早，其他controller如果设置了delegate就可能会被误伤
            navigationController.delegate = nil;
        }
    }
}

@end
