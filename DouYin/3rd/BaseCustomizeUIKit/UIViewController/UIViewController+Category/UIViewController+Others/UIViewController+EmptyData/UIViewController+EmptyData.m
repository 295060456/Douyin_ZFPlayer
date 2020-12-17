//
//  UIViewController+EmptyData.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "UIViewController+EmptyData.h"

@implementation UIViewController (EmptyData)

static char *UIViewController_EmptyData_tipsLab = "UIViewController_EmptyData_tipsLab";
@dynamic tipsLab;

-(void)ifEmptyData{

    BOOL (^checkSubviews)(void) = ^(){
        if (self.view.subviews.count == 1) {
            UIView *view = self.view.subviews[0];
            if (view == self.tipsLab) {
                return NO;
            }
        }return YES;
    };
    
    if (!self.view.subviews.count || checkSubviews()) {
        self.tipsLab.alpha = 1;
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UILabel *tipsLab;
-(UILabel *)tipsLab{
    UILabel *TipsLab = objc_getAssociatedObject(self, UIViewController_EmptyData_tipsLab);
    if (!TipsLab) {
        TipsLab = UILabel.new;
        TipsLab.text = @"暂无数据";
        TipsLab.textColor = self.view.backgroundColor == kBlueColor ? kRedColor : kBlueColor;// 防止某些VC在调试阶段，设置view.backgroundColor为随机色
        TipsLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        [TipsLab sizeToFit];
        [self.view addSubview:TipsLab];
        [TipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        
        objc_setAssociatedObject(self,
                                 UIViewController_EmptyData_tipsLab,
                                 TipsLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }return TipsLab;
}

-(void)setTipsLab:(UILabel *)tipsLab{
    objc_setAssociatedObject(self,
                             UIViewController_EmptyData_tipsLab,
                             tipsLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
