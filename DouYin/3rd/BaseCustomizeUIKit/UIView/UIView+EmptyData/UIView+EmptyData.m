//
//  UIView+EmptyData.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "UIView+EmptyData.h"

@implementation UIView (EmptyData)

static char *UIView_EmptyData_tipsLab = "UIView_EmptyData_tipsLab";
@dynamic tipsLab;

-(void)ifEmptyData{

    BOOL (^checkSubviews)(void) = ^(){
        if (self.subviews.count == 1) {
            UIView *view = self.subviews[0];
            if (view == self.tipsLab) {
                return YES;
            }
        }return NO;
    };
    
    if (!self.subviews.count || checkSubviews()) {
        self.tipsLab.alpha = 1;
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UILabel *tipsLab;
-(UILabel *)tipsLab{
    UILabel *TipsLab = objc_getAssociatedObject(self, UIView_EmptyData_tipsLab);
    if (!TipsLab) {
        TipsLab = UILabel.new;
        TipsLab.text = @"暂无数据";
        TipsLab.textColor = self.backgroundColor == kBlueColor ? kRedColor : kBlueColor;// 防止某些VC在调试阶段，设置view.backgroundColor为随机色
        TipsLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        [TipsLab sizeToFit];
        [self addSubview:TipsLab];
        [TipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        objc_setAssociatedObject(self,
                                 UIView_EmptyData_tipsLab,
                                 TipsLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }return TipsLab;
}

-(void)setTipsLab:(UILabel *)tipsLab{
    objc_setAssociatedObject(self,
                             UIView_EmptyData_tipsLab,
                             tipsLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
