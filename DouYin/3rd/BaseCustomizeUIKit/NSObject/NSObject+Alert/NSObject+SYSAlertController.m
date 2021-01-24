//
//  NSObject+SYSAlertController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+SYSAlertController.h"

@implementation NSObject (SYSAlertController)
/// 屏幕正中央的Alert
/// @param title 标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param message  副标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param isSeparateStyle  如果为YES 那么有实质性进展的键位在右侧，否则在左侧
/// @param btnTitleArr 按钮名称的数组
/// @param alertBtnActionArr  与btnTitleArr相对的按钮的触发事件，如果带形参，则只写方法名，形参的传递在具体的调用类里面实现。取消方法直接传@“”，方法内部做默认处理
/// @param targetVC 作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
/// @param funcInWhere  执行方法的位置，它可以是VC、view、也可以是任意NSObject子类。当不传值的时候 funcInWhere == targetVC
/// @param animated 动画效果
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSAlertViewTitle:(nullable NSString *)title
                     message:(nullable NSString *)message
             isSeparateStyle:(BOOL)isSeparateStyle
                 btnTitleArr:(NSArray <NSString*>*)btnTitleArr
              alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
                    targetVC:(UIViewController *)targetVC
                 funcInWhere:(nullable id)funcInWhere
                    animated:(BOOL)animated
                alertVCBlock:(nullable MKDataBlock)alertVCBlock
             completionBlock:(nullable NoResultBlock)completionBlock{
    @weakify(targetVC)
    @weakify(funcInWhere)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < alertBtnActionArr.count; i++) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitleArr[i]
                                                           style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            @strongify(targetVC)
            @strongify(funcInWhere)
            if (!funcInWhere) {
                funcInWhere = targetVC;
            }
            SuppressWarcPerformSelectorLeaksWarning([funcInWhere performSelector:NSSelectorFromString([NSString ensureNonnullString:alertBtnActionArr[i]
                                                                                                                         ReplaceStr:@"defaultFunc"])
                                                                      withObject:nil]);
            
        }];
        [alertController addAction:okAction];
    }
    if (alertVCBlock) {
        alertVCBlock(alertController);
    }
    [targetVC presentViewController:alertController
                           animated:animated
                         completion:completionBlock];
}
/// 屏幕下部出现的Alert
/// @param title 标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param message 副标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param isSeparateStyle 是否分隔显示
/// @param btnTitleArr 按钮名称的数组
/// @param alertBtnActionArr 与btnTitleArr相对的按钮的触发事件，如果带形参，则只写方法名，形参的传递在具体的调用类里面实现。取消方法直接传@“”，方法内部做默认处理
/// @param targetVC 作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
/// @param funcInWhere  执行方法的位置，它可以是VC、view、也可以是任意NSObject子类。当不传值的时候 funcInWhere == targetVC
/// @param sender sender
/// @param animated 动画效果
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSActionSheetTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
               isSeparateStyle:(BOOL)isSeparateStyle
                   btnTitleArr:(nonnull NSArray <NSString*>*)btnTitleArr
                alertBtnAction:(nonnull NSArray <NSString*>*)alertBtnActionArr
                      targetVC:(nonnull UIViewController *)targetVC
                   funcInWhere:(nullable id)funcInWhere
                        sender:(nullable UIControl *)sender
                      animated:(BOOL)animated
                  alertVCBlock:(nullable MKDataBlock)alertVCBlock
               completionBlock:(nullable NoResultBlock)completionBlock{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(targetVC)
    @weakify(funcInWhere)
    for (int i = 0; i < alertBtnActionArr.count; i++) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitleArr[i]
                                                           style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            @strongify(targetVC)
            @strongify(funcInWhere)
            if (!funcInWhere) {
                funcInWhere = targetVC;
            }
            SuppressWarcPerformSelectorLeaksWarning([funcInWhere performSelector:NSSelectorFromString([NSString ensureNonnullString:alertBtnActionArr[i]
                                                                                                                         ReplaceStr:@"defaultFunc"])
                                                                      withObject:Nil]);
        }];
        [alertController addAction:okAction];
    }
    if (alertVCBlock) {
        alertVCBlock(alertController);
    }
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover){
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [targetVC presentViewController:alertController
                           animated:animated
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
    loginAction.enabled = NO;   // 禁用Login按钮
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

-(void)defaultFunc{
    NSLog(@"defaultFunc self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

@end
