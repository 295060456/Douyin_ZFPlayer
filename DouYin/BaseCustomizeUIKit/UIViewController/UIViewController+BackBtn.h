//
//  UIViewController+BackBtn.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BackBtn)

#pragma mark —— BaseVC+BackBtn
@property(nonatomic,strong)UIButton *backBtnCategory;
#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
