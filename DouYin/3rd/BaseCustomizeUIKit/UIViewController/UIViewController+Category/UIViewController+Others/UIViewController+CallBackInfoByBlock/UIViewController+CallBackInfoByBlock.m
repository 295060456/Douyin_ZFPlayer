//
//  UIViewController+CallBackInfoByBlock.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import "UIViewController+CallBackInfoByBlock.h"

@implementation UIViewController (CallBackInfoByBlock)

static char *UIViewController_CallBackInfoByBlock = "UIViewController_CallBackInfoByBlock";
@dynamic viewControllerBlock;

-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock{
    self.viewControllerBlock = viewControllerBlock;
}
#pragma mark —— -(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock;
-(MKDataBlock)viewControllerBlock{
    return objc_getAssociatedObject(self, UIViewController_CallBackInfoByBlock);
}

-(void)setViewControllerBlock:(MKDataBlock)viewControllerBlock{
    objc_setAssociatedObject(self,
                             UIViewController_CallBackInfoByBlock,
                             viewControllerBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
