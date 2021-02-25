//
//  NSObject+SPAlertController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"
#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

//  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController

typedef enum : NSUInteger {
    NSObject_SPAlertControllerInitType_1 = 0,//alertControllerWithTitle/message/preferredStyle
    NSObject_SPAlertControllerInitType_2,//alertControllerWithTitle/message/preferredStyle/animationType
    NSObject_SPAlertControllerInitType_3,//alertControllerWithCustomAlertView/preferredStyle/animationType
    NSObject_SPAlertControllerInitType_4,//alertControllerWithCustomHeaderView/preferredStyle/animationType
    NSObject_SPAlertControllerInitType_5,//alertControllerWithCustomActionSequenceView/title/message/preferredStyle/animationType
} NSObject_SPAlertControllerInitType;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SPAlertController)

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
/// @param funcInWhere  执行方法的位置，它可以是VC、view、也可以是任意NSObject子类。当不传值的时候 funcInWhere == targetVC
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
                            alertActionTitleArr:(NSArray <NSString *>* _Nullable)alertActionTitleArr
                            alertActionStyleArr:(NSArray <NSNumber *>* _Nullable)alertActionStyleArr//SPAlertActionStyle
                              alertBtnActionArr:(NSArray <NSString *>* _Nullable)alertBtnActionArr
                                       targetVC:(UIViewController *)targetVC
                                    funcInWhere:(nullable id)funcInWhere
                                       animated:(BOOL)animated
                                   alertVCBlock:(nullable TwoDataBlock)alertVCBlock
                                completionBlock:(nullable NoResultBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

/**
 
 普通用法
 
 [NSObject SPAlertControllerWithType:NSObject_SPAlertControllerInitType_2
                               title:@"提示"
                             message:@"审核通过后可查看，是否删除"
                     customAlertView:nil
                    customHeaderView:nil
            customActionSequenceView:nil
                      preferredStyle:SPAlertControllerStyleAlert
                       animationType:SPAlertAnimationTypeDefault
                 alertActionTitleArr:@[@"取消",@"删除"]
                 alertActionStyleArr:@[@(SPAlertActionStyleDestructive),@(SPAlertActionStyleDefault)]
                   alertBtnActionArr:@[@"",@""]
                            targetVC:self
                         funcInWhere:self
                            animated:YES
                        alertVCBlock:^(SPAlertController *data,
                                       NSMutableArray <SPAlertAction *>*data2) {
     
     SPAlertAction *action1 = (SPAlertAction *)data2[0];
     SPAlertAction *action2 = (SPAlertAction *)data2[1];
     
     action1.titleColor = RGBSAMECOLOR(75);
     action1.titleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];

     action2.titleColor = RGBSAMECOLOR(75);
     action2.titleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
     
 } completionBlock:nil];

 
 */

/**
    富文本的用法
 {
     
     NSMutableArray *tempDataMutArr = NSMutableArray.array;
     RichLabelDataStringsModel *title_1_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_2_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_3_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_4_Model = RichLabelDataStringsModel.new;
     RichLabelDataStringsModel *title_5_Model = RichLabelDataStringsModel.new;
     {
         title_1_Model.dataString = @"您当前的金币数为:";
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(0, title_1_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = kBlackColor;
         richLabelTextCorModel.range = NSMakeRange(0, title_1_Model.dataString.length);
         
         title_1_Model.richLabelFontModel = richLabelFontModel;
         title_1_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {
         title_2_Model.dataString = myCoinTipsModel.value.stringValue;
         
         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
         
         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = RGBCOLOR(255, 163, 163);
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length, title_2_Model.dataString.length);
         
         title_2_Model.richLabelFontModel = richLabelFontModel;
         title_2_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {
         title_3_Model.dataString = @"个，可兑换的余额为:";

         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length, title_3_Model.dataString.length);

         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = kBlackColor;
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length, title_3_Model.dataString.length);

         title_3_Model.richLabelFontModel = richLabelFontModel;
         title_3_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {
         title_4_Model.dataString = myCoinTipsModel.key;

         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length, title_4_Model.dataString.length);

         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = RGBCOLOR(255, 163, 163);
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length, title_4_Model.dataString.length);

         title_4_Model.richLabelFontModel = richLabelFontModel;
         title_4_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     {
         title_5_Model.dataString = @"元，确认兑换吗？";

         RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
         richLabelFontModel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
         richLabelFontModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length + title_4_Model.dataString.length, title_5_Model.dataString.length);

         RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
         richLabelTextCorModel.cor = kBlackColor;
         richLabelTextCorModel.range = NSMakeRange(title_1_Model.dataString.length + title_2_Model.dataString.length + title_3_Model.dataString.length + title_4_Model.dataString.length, title_5_Model.dataString.length);

         title_5_Model.richLabelFontModel = richLabelFontModel;
         title_5_Model.richLabelTextCorModel = richLabelTextCorModel;
     }
     
     [tempDataMutArr addObject:title_1_Model];
     [tempDataMutArr addObject:title_2_Model];
     [tempDataMutArr addObject:title_3_Model];
     [tempDataMutArr addObject:title_4_Model];
     [tempDataMutArr addObject:title_5_Model];
     
     [NSObject SPAlertControllerWithType:NSObject_SPAlertControllerInitType_2
                                   title:@"兑换余额"
                                 message:@""
                         customAlertView:nil
                        customHeaderView:nil
                customActionSequenceView:nil
                          preferredStyle:SPAlertControllerStyleAlert
                           animationType:SPAlertAnimationTypeDefault
                     alertActionTitleArr:@[@"取消",@"确定"]
                     alertActionStyleArr:@[@(SPAlertActionStyleDestructive),@(SPAlertActionStyleDefault)]
                       alertBtnActionArr:@[@"",@"sure"]
                                targetVC:[NSObject getCurrentViewController]
                             funcInWhere:self
                                animated:YES
                            alertVCBlock:^(SPAlertController *data,
                                           NSMutableArray <SPAlertAction *>*data2) {
         
         data.attributedMessage = [NSObject makeRichTextWithDataConfigMutArr:tempDataMutArr];
         
         for (SPAlertAction *alertAction in data2) {
             alertAction.titleColor = RGBSAMECOLOR(75);
             alertAction.titleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
         }
         
     } completionBlock:nil];
 }
 
 */

/**
  自定义View，用属性进行承接，消失的时候调取：
 [self.alertController dismissViewControllerAnimated:YES completion:nil];
 
 self.alertController = [NSObject SPAlertControllerWithType:NSObject_SPAlertControllerInitType_3
                                                      title:nil
                                                    message:nil
                                            customAlertView:self.updateView
                                           customHeaderView:nil
                                   customActionSequenceView:nil
                                             preferredStyle:SPAlertControllerStyleAlert
                                              animationType:SPAlertAnimationTypeDefault
                                        alertActionTitleArr:nil
                                        alertActionStyleArr:nil
                                          alertBtnActionArr:nil
                                                   targetVC:self
                                                funcInWhere:self
                                                   animated:YES
                                               alertVCBlock:nil
                                            completionBlock:nil];
 
 */
