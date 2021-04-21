//
//  UIViewController+BackBtn.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BackBtn.h"
#import <objc/runtime.h>

@implementation UIViewController (BackBtn)

static char *BaseVC_BackBtn_backBtnCategory = "BaseVC_BackBtn_backBtnCategory";
@dynamic backBtnCategory;

static char *BaseVC_BackBtn_backBtnCategoryItem = "BaseVC_BackBtn_backBtnCategoryItem";
@dynamic backBtnCategoryItem;

static char *BaseVC_BackBtn_backBtnTitle = "BaseVC_BackBtn_backBtnTitle";
@dynamic backBtnTitle;

#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *_Nullable)sender{
    switch (self.pushOrPresent) {
        case ComingStyle_PRESENT:{
            [self dismissViewControllerAnimated:YES
                                     completion:nil];
        }break;
        case ComingStyle_PUSH:{
            if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissViewControllerAnimated:YES
                                         completion:nil];
            }
        }break;
            
        default:
            break;
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)BackBtn *backBtnCategory;
-(UIButton *)backBtnCategory{
    UIButton *BackBtnCategory = objc_getAssociatedObject(self, BaseVC_BackBtn_backBtnCategory);
    if (!BackBtnCategory) {
        BackBtnCategory = UIButton.new;
        [BackBtnCategory layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                         imageTitleSpace:8];
        if (!self.backBtnTitle) {
            [BackBtnCategory setTitle:@"返回"
                             forState:UIControlStateNormal];
        }
        NSString *imageName = self.gk_backStyle == GKNavigationBarBackStyleBlack ? @"btn_back_black" : @"btn_back_white";
        UIImage *backImage = KBuddleIMG(nil,
                                        @"Frameworks/GKNavigationBar.framework/GKNavigationBar",
                                        nil,
                                        imageName);
        [BackBtnCategory setImage:backImage
                         forState:UIControlStateNormal];
        
        if (self.gk_backStyle == GKNavigationBarBackStyleBlack) {
            [BackBtnCategory setTitleColor:kBlackColor
                                  forState:UIControlStateNormal];
        }else{
            [BackBtnCategory setTitleColor:kWhiteColor
                                  forState:UIControlStateNormal];
        }
        
        @weakify(self)
        [[BackBtnCategory rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self backBtnClickEvent:x];
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_BackBtn_backBtnCategory,
                                 BackBtnCategory,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackBtnCategory;
}

-(void)setBackBtnCategory:(UIButton *)backBtnCategory{
    objc_setAssociatedObject(self,
                             BaseVC_BackBtn_backBtnCategory,
                             backBtnCategory,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIBarButtonItem *backBtnCategoryItem;
-(void)setBackBtnCategoryItem:(UIBarButtonItem *)backBtnCategoryItem{
    objc_setAssociatedObject(self,
                             BaseVC_BackBtn_backBtnCategoryItem,
                             backBtnCategoryItem,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIBarButtonItem *)backBtnCategoryItem{
    UIBarButtonItem *BackBtnCategoryItem = objc_getAssociatedObject(self, BaseVC_BackBtn_backBtnCategoryItem);
    if (!BackBtnCategoryItem) {
        BackBtnCategoryItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
        objc_setAssociatedObject(self,
                                 BaseVC_BackBtn_backBtnCategoryItem,
                                 BackBtnCategoryItem,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackBtnCategoryItem;
}
#pragma mark —— @property(nonatomic,strong)NSString *backBtnTitle;
-(void)setBackBtnTitle:(NSString *)backBtnTitle{
    objc_setAssociatedObject(self,
                             BaseVC_BackBtn_backBtnTitle,
                             backBtnTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)backBtnTitle{
    NSString *BackBtnTitle = objc_getAssociatedObject(self, BaseVC_BackBtn_backBtnTitle);
    return BackBtnTitle;
}


@end
