//
//  NSObject+SPAlertController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+SPAlertController.h"

@implementation NSObject (SPAlertController)

/// 自定义的Alert
/// @param SPAlertControllerInitType 初始化模式
/// @param title 标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param message 副标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param customAlertView 允许传入自定义的View
/// @param customHeaderView 允许传入自定义的HeaderView
/// @param customActionSequenceView 允许传入自定义的customActionSequenceView
/// @param preferredStyle 从单侧弹出(顶/左/底/右)  还是  从中间弹出
/// @param animationType 动画模式
/// @param alertActionTitleArr 按钮名
/// @param alertActionStyleArr 按钮Style
/// @param alertBtnActionArr 按钮触发方法
/// @param targetVC  作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
/// @param funcInWhere   执行方法的位置，它可以是VC、view、也可以是任意NSObject子类。当不传值的时候 funcInWhere == targetVC
/// @param animated 是否动效present
/// @param alertVCBlock alertVCBlock
/// @param completionBlock completionBlock
+(SPAlertController *)SPAlertControllerWithType:(NSObject_SPAlertControllerInitType)SPAlertControllerInitType
                                          title:(NSString *_Nullable)title
                                        message:(NSString *_Nullable)message
                                customAlertView:(UIView *_Nullable)customAlertView
                               customHeaderView:(UIView *_Nullable)customHeaderView
                       customActionSequenceView:(UIView *_Nullable)customActionSequenceView
                                 preferredStyle:(SPAlertControllerStyle)preferredStyle
                                  animationType:(SPAlertAnimationType)animationType
                            alertActionTitleArr:(NSArray <NSString *>*)alertActionTitleArr
                            alertActionStyleArr:(NSArray <NSNumber *>*)alertActionStyleArr//SPAlertActionStyle
                              alertBtnActionArr:(NSArray <NSString *>*)alertBtnActionArr
                                       targetVC:(UIViewController *)targetVC
                                    funcInWhere:(nullable id)funcInWhere
                                       animated:(BOOL)animated
                                   alertVCBlock:(nullable TwoDataBlock)alertVCBlock
                                completionBlock:(nullable NoResultBlock)completionBlock{
    SPAlertController *vc = nil;
    switch (SPAlertControllerInitType) {
        case NSObject_SPAlertControllerInitType_1:{
            // 示例1:actionSheet的默认动画样式(从底部弹出，有取消按钮)
            // 示例2:actionSheet的默认动画(从底部弹出,无取消按钮)
            // 示例8:actionSheet 模拟多分区样式
            // 示例13:alert 水平排列2个以上的按钮(默认超过2个按钮是垂直排列)
            vc = [SPAlertController alertControllerWithTitle:title
                                                     message:message
                                              preferredStyle:preferredStyle];
        }break;
        case NSObject_SPAlertControllerInitType_2:{
            // 示例3:actionSheet从顶部弹出(无标题)
            // 示例4:actionSheet从顶部弹出(有标题)
            // 示例5:actionSheet 水平排列（有取消按钮）
            // 示例6:actionSheet 水平排列（无取消按钮）
            // 示例7:actionSheet action上有图标
            // 示例9:alert 默认动画(收缩动画)
            // 示例10:alert 发散动画
            // 示例11:alert渐变动画
            // 示例12:alert 垂直排列2个按钮（2个按钮默认是水平排列）
            // 示例14:alert 设置头部图标
            // 示例15:alert 含有文本输入框
            // 示例16:富文本(action设置富文本)
            // 示例17:富文本(头部设置富文本)
            // 示例26:插入一个组件
            // 示例28:当按钮过多时
            vc = [SPAlertController alertControllerWithTitle:title
                                                     message:message
                                              preferredStyle:preferredStyle
                                               animationType:animationType];
        }break;
        case NSObject_SPAlertControllerInitType_3:{
            // 示例20:自定义整个对话框(actionSheet样式从底部弹出)
            // 示例21:自定义整个对话框(actionSheet样式从右边弹出)
            // 示例22:自定义整个对话框(actionSheet样式从左边弹出)
            // 示例23:自定义整个对话框(actionSheet样式从顶部弹出)
            // 示例24:自定义整个对话框(pickerView)
            // 示例27:自定义整个对话框(全屏)
            vc = [SPAlertController alertControllerWithCustomAlertView:customAlertView
                                                        preferredStyle:preferredStyle
                                                         animationType:animationType];
        }break;
        case NSObject_SPAlertControllerInitType_4:{
            // 示例18:自定义头部(xib)
            // 示例19:自定义整个对话框(alert样式)
            vc = [SPAlertController alertControllerWithCustomHeaderView:customHeaderView
                                                         preferredStyle:preferredStyle
                                                          animationType:animationType];
        }break;
        case NSObject_SPAlertControllerInitType_5:{
            // 示例25:自定义action部分
            vc = [SPAlertController alertControllerWithCustomActionSequenceView:customActionSequenceView
                                                                          title:title
                                                                        message:message
                                                                 preferredStyle:preferredStyle
                                                                  animationType:animationType];
        }break;
        default:
            return nil;
            break;
    }
    
    NSMutableArray <SPAlertAction *>*mutArr = NSMutableArray.array;
    
    @weakify(targetVC)
    @weakify(funcInWhere)
    for (int i = 0; i < alertBtnActionArr.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:alertActionTitleArr[i]
                                                         style:alertActionStyleArr[i].integerValue
                                                       handler:^(SPAlertAction * _Nonnull action) {
            @strongify(targetVC)
            @strongify(funcInWhere)
            if (!funcInWhere) {
                funcInWhere = targetVC;
            }

            SuppressWarcPerformSelectorLeaksWarning([funcInWhere performSelector:NSSelectorFromString([NSString ensureNonnullString:alertBtnActionArr[i]
                                                                                                                         ReplaceStr:@"defaultFunc"])
                                                                      withObject:Nil]);
            
        }];
        [vc addAction:action];
        [mutArr addObject:action];
    }
    
    if (alertVCBlock) {
        alertVCBlock(vc,mutArr);
    }

    [targetVC presentViewController:vc
                           animated:animated
                         completion:completionBlock];
    return vc;
}

-(void)defaultFunc{
    NSLog(@"defaultFunc self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

@end
