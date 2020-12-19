//
//  UIViewController+BackBtn.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BackBtn.h"

@implementation UIViewController (BackBtn)

static char *BaseVC_BackBtn_backBtnCategory = "BaseVC_BackBtn_backBtnCategory";
@dynamic backBtnCategory;

#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *_Nullable)sender{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
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

        [BackBtnCategory setTitle:@"返回"
                         forState:UIControlStateNormal];
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


@end
