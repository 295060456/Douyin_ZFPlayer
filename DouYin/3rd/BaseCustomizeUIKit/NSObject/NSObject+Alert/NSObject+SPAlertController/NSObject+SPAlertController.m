//
//  NSObject+SPAlertController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+SPAlertController.h"

@implementation SPAlertControllerConfig

@end

@implementation NSObject (SPAlertController)
/// 自定义的Alert
/// @param config 配置文件
/// @param alertVCBlock alertVCBlock
/// @param completionBlock completionBlock
+(SPAlertController *)showSPAlertControllerConfig:(SPAlertControllerConfig *)config
                                     alertVCBlock:(nullable TwoDataBlock)alertVCBlock
                                  completionBlock:(nullable NoResultBlock)completionBlock{
    SPAlertController *vc = nil;
    switch (config.SPAlertControllerInitType) {
        case NSObject_SPAlertControllerInitType_1:{
            // 示例1:actionSheet的默认动画样式(从底部弹出，有取消按钮)
            // 示例2:actionSheet的默认动画(从底部弹出,无取消按钮)
            // 示例8:actionSheet 模拟多分区样式
            // 示例13:alert 水平排列2个以上的按钮(默认超过2个按钮是垂直排列)
            vc = [SPAlertController alertControllerWithTitle:config.title
                                                     message:config.message
                                              preferredStyle:config.preferredStyle];
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
            vc = [SPAlertController alertControllerWithTitle:config.title
                                                     message:config.message
                                              preferredStyle:config.preferredStyle
                                               animationType:config.animationType];
        }break;
        case NSObject_SPAlertControllerInitType_3:{
            // 示例20:自定义整个对话框(actionSheet样式从底部弹出)
            // 示例21:自定义整个对话框(actionSheet样式从右边弹出)
            // 示例22:自定义整个对话框(actionSheet样式从左边弹出)
            // 示例23:自定义整个对话框(actionSheet样式从顶部弹出)
            // 示例24:自定义整个对话框(pickerView)
            // 示例27:自定义整个对话框(全屏)
            vc = [SPAlertController alertControllerWithCustomAlertView:config.customAlertView
                                                        preferredStyle:config.preferredStyle
                                                         animationType:config.animationType];
        }break;
        case NSObject_SPAlertControllerInitType_4:{
            // 示例18:自定义头部(xib)
            // 示例19:自定义整个对话框(alert样式)
            vc = [SPAlertController alertControllerWithCustomHeaderView:config.customHeaderView
                                                         preferredStyle:config.preferredStyle
                                                          animationType:config.animationType];
        }break;
        case NSObject_SPAlertControllerInitType_5:{
            // 示例25:自定义action部分
            vc = [SPAlertController alertControllerWithCustomActionSequenceView:config.customActionSequenceView
                                                                          title:config.title
                                                                        message:config.message
                                                                 preferredStyle:config.preferredStyle
                                                                  animationType:config.animationType];
        }break;
        default:
            [WHToast toastErrMsg:@"参数配置错误，请检查"];
            return nil;
            break;
    }
    
    NSMutableArray <SPAlertAction *>*mutArr = NSMutableArray.array;
    
    if (config.alertBtnActionArr.count == config.alertActionTitleArr.count &&
        config.alertActionStyleArr.count == config.alertBtnActionArr.count &&
        config.alertActionTitleArr.count == config.alertActionStyleArr.count) {
//        @weakify(config);
        for (int i = 0; i < config.alertBtnActionArr.count; i++) {
            SPAlertAction *action = [SPAlertAction actionWithTitle:config.alertActionTitleArr[i]
                                                             style:config.alertActionStyleArr[i].integerValue
                                                           handler:^(SPAlertAction * _Nonnull action) {
//                @strongify(config);
                if (!config.funcInWhere) {
                    config.funcInWhere = config.targetVC;
                }
                NSLog(@"DDD = %ld",action._index);
                // 核心方法:截取最后2个字符，如果是“：”则进行参数拼接
                NSString *methodName = config.alertBtnActionArr[i];
                if ([NSString isNullString:methodName]) {
                    if (alertVCBlock) {
                        alertVCBlock(vc,mutArr);
                    }return;
                }
                NSMutableArray *parameters = NSMutableArray.array;
                if (config.parametersArr.count) {
                    if ([[methodName substringFromIndex:methodName.length - 1] isEqualToString:@":"]) {
                        [parameters addObject:action];
                    }
                }
                
                [NSObject methodName:config.alertBtnActionArr[i]
                              target:config.funcInWhere
                         paramarrays:parameters];
            }];
            
            action._index = i;//做记号
            NSLog(@"DDD = %ld",action._index);
            [vc addAction:action];
            [mutArr addObject:action];
        }
        
        if (alertVCBlock) {
            alertVCBlock(vc,mutArr);
        }
    }else{
        [WHToast toastErrMsg:@"参数配置错误，请检查"];
        return nil;
    }
    
    [config.targetVC presentViewController:vc
                                  animated:config.animated
                                completion:completionBlock];
    return vc;
}

@end
