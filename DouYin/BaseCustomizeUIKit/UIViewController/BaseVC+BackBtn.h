//
//  BaseVC+BackBtn.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (BackBtn)

#pragma mark —— BaseVC+BackBtn
@property(nonatomic,strong)UIButton *backBtnCategory;
#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *_Nullable)sender;
-(void)backComingStyle:(ComingStyle)ComingStyle
             withEvent:(UIButton *_Nullable)sender;

@end

NS_ASSUME_NONNULL_END
