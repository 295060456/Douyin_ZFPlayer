//
//  NSObject+SYSAlertController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"
/*
* 使用说明
*  btnTitleArr（按钮标题） 和 alertBtnAction（按钮触发的方法），原则上一一对应，可以接受null，如果没有实质性的触发（仅仅希望点击以后使弹框消失，可以传空 @[@""]，从而调用defaultFunc进行占位，否则引发野指针错误）

 isSeparateStyle 的含义
 在一般的模式（呈现在屏幕正中央） ：如果为YES 那么有实质性进展的键位在右侧，否则在左侧
 在sheet模式：是否分组显示（标题 + 副标题）（取消）
 
*  targetVC，你不能要求每一个触发的点都是VC，也可以是View，所以将上个版本的集成在VC里面的弹框摘出来，但是推弹框出现需要调用系统方法presentViewController，所以这里必须手动传一个标的VC
*  message、title 你不想要就传nil，传@"" 系统会为你留位置,从而造成界面问题（空一坨出来）

*  showLoginAlertViewWithTargetVC 是一种登录样式
*/

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SYSAlertController)
/// 屏幕正中央的Alert
/// @param title 标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param message  副标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param isSeparateStyle  如果为YES 那么有实质性进展的键位在右侧，否则在左侧
/// @param btnTitleArr 按钮名称的数组
/// @param alertBtnActionArr  与btnTitleArr相对的按钮的触发事件，如果带形参，则只写方法名，形参的传递在具体的调用类里面实现。取消方法直接传@“”，方法内部做默认处理
/// @param targetVC 作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
/// @param funcVC 对应方法的VC。一般情况下targetVC ==  funcVC，所以可以不用填写，但是某些特殊情况targetVC 不等于 funcVC，就要单独提出来做
/// @param animated 动画效果
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSAlertViewTitle:(nullable NSString *)title
                     message:(nullable NSString *)message
             isSeparateStyle:(BOOL)isSeparateStyle
                 btnTitleArr:(NSArray <NSString*>*)btnTitleArr
              alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
                    targetVC:(UIViewController *)targetVC
                      funcVC:(nullable UIViewController *)funcVC
                    animated:(BOOL)animated
                alertVCBlock:(nullable MKDataBlock)alertVCBlock
             completionBlock:(nullable NoResultBlock)completionBlock;
/// 屏幕下部出现的Alert
/// @param title 标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param message 副标题，没有可传nil，如果传空字符@“”会多处一行空白
/// @param isSeparateStyle 是否分隔显示
/// @param btnTitleArr 按钮名称的数组
/// @param alertBtnActionArr 与btnTitleArr相对的按钮的触发事件，如果带形参，则只写方法名，形参的传递在具体的调用类里面实现。取消方法直接传@“”，方法内部做默认处理
/// @param targetVC 作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
/// @param funcVC 对应方法的VC。一般情况下targetVC ==  funcVC，所以可以不用填写，但是某些特殊情况targetVC 不等于 funcVC，就要单独提出来做
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
                        funcVC:(nullable UIViewController *)funcVC
                        sender:(nullable UIControl *)sender
                      animated:(BOOL)animated
                  alertVCBlock:(nullable MKDataBlock)alertVCBlock
               completionBlock:(nullable NoResultBlock)completionBlock;

+(void)showLoginAlertViewWithTargetVC:(UIViewController *)targetVC;

-(void)defaultFunc;

@end

NS_ASSUME_NONNULL_END
