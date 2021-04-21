//
//  UIView+EmptyData.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "UIView+EmptyData.h"
#import "NSString+Extras.h"
#import <objc/runtime.h>

@implementation UIView (EmptyData)

static char *UIView_EmptyData_tipsLab = "UIView_EmptyData_tipsLab";
@dynamic tipsLab;

static char *UIView_EmptyData_tipsTitle = "UIView_EmptyData_tipsTitle";
@dynamic tipsTitle;

-(void)ifEmptyData{
#ifdef DEBUG
    //光板返回YES，有其他控件返回NO
    BOOL (^checkSubviews)(void) = ^(){
        if (self.subviews.count) {// 有控件
            if ([self.subviews[0] isEqual:self.tipsLab]) {
                return YES;//除了self.tipsLab就没有了，光板
            }else{
                return NO;//有其他控件
            }
        }return YES;//光板
    };
    
    if (checkSubviews()) {
        self.tipsLab.alpha = 1;
    }else{
        self.tipsLab.alpha = 0;
    }
#endif
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UILabel *tipsLab;
-(UILabel *)tipsLab{
    UILabel *TipsLab = objc_getAssociatedObject(self, UIView_EmptyData_tipsLab);
    if (!TipsLab) {
        TipsLab = UILabel.new;
        TipsLab.text = self.tipsTitle;
        TipsLab.numberOfLines = 0;
        TipsLab.textAlignment = NSTextAlignmentCenter;
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
#pragma mark —— @property(nonatomic,strong)NSString *tipsTitle;
-(NSString *)tipsTitle{
    NSString *TipsTitle = objc_getAssociatedObject(self, UIView_EmptyData_tipsTitle);
    if ([NSString isNullString:TipsTitle]) {
        TipsTitle = @"快来将我填满吧";
        objc_setAssociatedObject(self,
                                 UIView_EmptyData_tipsTitle,
                                 TipsTitle,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TipsTitle;
}

-(void)setTipsTitle:(NSString *)tipsTitle{
    objc_setAssociatedObject(self,
                             UIView_EmptyData_tipsTitle,
                             tipsTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
