//
//  NavigationViewController.h
//  ShengAi
//
//  Created by 刘赓 on 2018/10/29.
//  Copyright © 2018年 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationVC : UINavigationController
<
UINavigationControllerDelegate
>

@property(nonatomic,strong)UIButton *editBtn;

+(UINavigationController *)rootNavigationController;

-(void)setupEditBtn:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
