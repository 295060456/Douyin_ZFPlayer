//
//  BaseVC+BackBtn.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+BackBtn.h"
#import <objc/runtime.h>

@implementation BaseVC (BackBtn)

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

-(void)backComingStyle:(ComingStyle)ComingStyle
             withEvent:(UIButton *_Nullable)sender{
    switch (ComingStyle) {
        case ComingStyle_PUSH:{
            [self backBtnClickEvent:sender];
        }break;
        case ComingStyle_PRESENT:{
            [self dismissViewControllerAnimated:YES
                                     completion:nil];
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
        [BackBtnCategory setTitleColor:kWhiteColor
                              forState:UIControlStateNormal];
        [BackBtnCategory setTitle:@"返回"
                         forState:UIControlStateNormal];
        [BackBtnCategory setImage:KBuddleIMG(@"Others", nil, @"back_white")
                         forState:UIControlStateNormal];
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
