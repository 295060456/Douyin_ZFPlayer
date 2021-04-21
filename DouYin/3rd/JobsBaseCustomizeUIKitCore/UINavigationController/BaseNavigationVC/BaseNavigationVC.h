//
//  NavigationViewController.h
//  ShengAi
//
//  Created by 刘赓 on 2018/10/29.
//  Copyright © 2018年 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationVC : UINavigationController<UINavigationControllerDelegate>

-(void)setupBarButtonItem:(UIViewController * __nonnull)vc
                    title:(NSString * __nullable)title
                 selector:(SEL __nonnull)selector;
/*
    用于以此为基类的UINavigationController的具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseNavigationVC:(MKDataBlock)baseNavigationVCBlock;

//+(UINavigationController *)rootNavigationController;

@end

NS_ASSUME_NONNULL_END
