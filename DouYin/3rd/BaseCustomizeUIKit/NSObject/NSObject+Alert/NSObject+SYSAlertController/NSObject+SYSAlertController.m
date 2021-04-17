//
//  NSObject+SYSAlertController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+SYSAlertController.h"

@implementation SYSAlertControllerConfig

@end

@implementation NSObject (SYSAlertController)
/// 屏幕正中央的Alert
/// @param config 配置文件
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSAlertViewConfig:(nonnull SYSAlertControllerConfig *)config
                 alertVCBlock:(nullable MKDataBlock)alertVCBlock
              completionBlock:(nullable NoResultBlock)completionBlock{
//    @weakify(config)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:config.title
                                                                             message:config.message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    if(config.alertBtnActionArr.count == config.btnTitleArr.count){
        for (int i = 0; i < config.alertBtnActionArr.count; i++) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:config.btnTitleArr[i]
                                                               style:config.isSeparateStyle ? (i == config.alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
//                @strongify(config)
                if (!config.funcInWhere) {
                    config.funcInWhere = config.targetVC;
                }

                // 核心方法:截取最后2个字符，如果是“：”则进行参数拼接
                NSString *methodName = config.alertBtnActionArr[i];
                if ([NSString isNullString:methodName]) {
                    if (alertVCBlock) {
                        alertVCBlock(alertController);
                    }return;
                }
                NSMutableArray *parameters = nil;
                if (config.parametersArr.count) {
                    parameters = config.parametersArr[i];
                    if ([[methodName substringFromIndex:methodName.length - 1] isEqualToString:@":"]) {
                        [parameters addObject:action];
                    }
                }
                
                [NSObject methodName:config.alertBtnActionArr[i]
                              target:config.funcInWhere
                         paramarrays:parameters];
            }];
            [alertController addAction:okAction];
        }
    }else{
        [WHToast toastMsg:@"参数配置错误，请检查"];
    }
    if (alertVCBlock) {
        alertVCBlock(alertController);
    }
    [config.targetVC presentViewController:alertController
                                  animated:config.animated
                                completion:completionBlock];
}
/// 屏幕下部出现的Alert
/// @param config 配置文件
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSActionSheetConfig:(nonnull SYSAlertControllerConfig *)config
                   alertVCBlock:(nullable MKDataBlock)alertVCBlock
                completionBlock:(nullable NoResultBlock)completionBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:config.title
                                                                             message:config.message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (config.alertBtnActionArr.count == config.btnTitleArr.count) {
//        @weakify(config)
        for (int i = 0; i < config.alertBtnActionArr.count; i++) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:config.btnTitleArr[i]
                                                               style:config.isSeparateStyle ? (i == config.alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
//                @strongify(config)
                if (!config.funcInWhere) {
                    config.funcInWhere = config.targetVC;
                }

                // 核心方法:截取最后2个字符，如果是“：”则进行参数拼接
                NSString *methodName = config.alertBtnActionArr[i];
                if ([NSString isNullString:methodName]) {
                    if (alertVCBlock) {
                        alertVCBlock(alertController);
                    }return;
                }
                NSMutableArray *parameters = nil;
                if (config.parametersArr.count) {
                    parameters = config.parametersArr[i];
                    if ([[methodName substringFromIndex:methodName.length - 1] isEqualToString:@":"]) {
                        [parameters addObject:action];
                    }
                }
                
                [NSObject methodName:config.alertBtnActionArr[i]
                              target:config.funcInWhere
                         paramarrays:parameters];
            }];
            [alertController addAction:okAction];
        }
    }else{
        [WHToast toastMsg:@"参数配置错误，请检查"];
    }

    if (alertVCBlock) {
        alertVCBlock(alertController);
    }
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover){
        popover.sourceView = config.sender;
        popover.sourceRect = config.sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [config.targetVC presentViewController:alertController
                                  animated:config.animated
                                completion:completionBlock];
}

+(void)showLoginAlertViewWithTargetVC:(UIViewController *)targetVC{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login"
                                                                             message:@"Enter Your Account Info Below"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self)
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        @strongify(self)
        textField.placeholder = @"username";
        [textField addTarget:self
                      action:@selector(alertUserAccountInfoDidChange:targetVC:)
            forControlEvents:UIControlEventEditingChanged];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        @strongify(self)
        textField.placeholder = @"password";
        textField.secureTextEntry = YES;
        [textField addTarget:self
                      action:@selector(alertUserAccountInfoDidChange:targetVC:)
            forControlEvents:UIControlEventEditingChanged];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"Cancel Action");
                                                         }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"Login"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            UITextField *userName = alertController.textFields.firstObject;
                                                            UITextField *password = alertController.textFields.lastObject;
                                                            // 输出用户名 密码到控制台
                                                            NSLog(@"username is %@, password is %@",userName.text,password.text);
                                                        }];
    loginAction.enabled = NO;// 禁用Login按钮
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    [targetVC presentViewController:alertController
                           animated:YES
                         completion:nil];
}
//???
+(void)alertUserAccountInfoDidChange:(UITextField *)sender
                            targetVC:(UIViewController *)targetVC{
    UIAlertController *alertController = (UIAlertController *)targetVC.presentedViewController;
    if (alertController){
        NSString *userName = alertController.textFields.firstObject.text;
        NSString *password = alertController.textFields.lastObject.text;
        UIAlertAction *loginAction = alertController.actions.lastObject;
        if (userName.length > 3 &&
            password.length > 6)
            // 用户名大于3位，密码大于6位时，启用Login按钮。
            loginAction.enabled = YES;
        else
            // 用户名小于等于3位，密码小于等于6位，禁用Login按钮。
            loginAction.enabled = NO;
    }
}

@end
