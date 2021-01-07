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
    NSObject_SPAlertControllerInitType_6,//alertControllerWithTitle/message/preferredStyle/animationType
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
/// @param funcVC  对应方法的VC。一般情况下targetVC ==  funcVC，所以可以不用填写，但是某些特殊情况targetVC 不等于 funcVC，就要单独提出来做
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
                                 alertBtnAction:(NSArray <NSString *>*)alertBtnActionArr
                                       targetVC:(UIViewController *)targetVC
                                         funcVC:(nullable UIViewController *)funcVC
                                       animated:(BOOL)animated
                                   alertVCBlock:(nullable TwoDataBlock)alertVCBlock
                                completionBlock:(nullable NoResultBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END


