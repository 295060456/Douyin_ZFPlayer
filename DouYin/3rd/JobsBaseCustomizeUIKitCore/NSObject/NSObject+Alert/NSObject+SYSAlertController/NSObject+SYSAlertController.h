//
//  NSObject+SYSAlertController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

#import "WHToast+DDToast.h"

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
/// 配置文件
@interface SYSAlertControllerConfig : NSObject

@property(nonatomic,strong,nullable)NSString *title;// 标题，没有可传nil，如果传空字符@“”会多处一行空白
@property(nonatomic,strong,nullable)NSString *message;// 副标题，没有可传nil，如果传空字符@“”会多处一行空白
@property(nonatomic,assign)BOOL isSeparateStyle;// 如果为YES 那么有实质性进展的键位在右侧，否则在左侧
@property(nonatomic,strong,nullable)UIViewController *targetVC;// 作用域,alertBtnActionArr在targetVC的m文件去找对应的方法，没有则向外抛出崩溃
@property(nonatomic,strong,nullable)id funcInWhere;// // 执行方法的位置，它可以是VC、view、也可以是任意NSObject子类。当不传值的时候 funcInWhere == targetVC
@property(nonatomic,assign)BOOL animated; // 是否开启动画效果
@property(nonatomic,strong,nullable)UIControl *sender;
// 核心参数
@property(nonatomic,strong,nullable)NSArray <NSString*>*btnTitleArr;// 按钮名称的数组
@property(nonatomic,strong,nullable)NSArray <NSString*>*alertBtnActionArr;// 与btnTitleArr相对的按钮的触发事件，如果带形参，则只写方法名，形参的传递在具体的调用类里面实现。取消方法直接传@“”，方法内部做默认处理
@property(nonatomic,strong,nullable)NSArray *parametersArr;// @【所有的参数形成数据束，一个方法对应一个数据束的形式，包装成方法的第一个参数】

@end

@interface NSObject (SYSAlertController)
/// 屏幕正中央的Alert
/// @param config 配置文件
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSAlertViewConfig:(nonnull SYSAlertControllerConfig *)config
                 alertVCBlock:(nullable MKDataBlock)alertVCBlock
              completionBlock:(nullable NoResultBlock)completionBlock;
/// 屏幕下部出现的Alert
/// @param config 配置文件
/// @param alertVCBlock 返回这个UIAlertController *
/// @param completionBlock 结束完成以后的block
+(void)showSYSActionSheetConfig:(nonnull SYSAlertControllerConfig *)config
                   alertVCBlock:(nullable MKDataBlock)alertVCBlock
                completionBlock:(nullable NoResultBlock)completionBlock;

+(void)showLoginAlertViewWithTargetVC:(UIViewController *)targetVC;

@end

NS_ASSUME_NONNULL_END

/** 使用示例
 
{
 
 SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
 config.title = @"是否取消对其关注？";
 config.isSeparateStyle = NO;
 config.btnTitleArr = @[@"确定",@"取消"];
 config.alertBtnActionArr = @[@"unfollow:",@""];
 config.parametersArr = @[@{@"btn":btn,
                            @"plazaCommunityListModel":plazaCommunityListModel},@""];
 config.targetVC = NSObject.getCurrentViewController;
 config.funcInWhere = self;
 config.animated = YES;
 
 [NSObject showSYSAlertViewConfig:config
                     alertVCBlock:nil
                  completionBlock:nil];
 }
 
 {
 
 SYSAlertControllerConfig *config = SYSAlertControllerConfig.new;
 config.isSeparateStyle = YES;
 config.btnTitleArr = @[@"保存图片",@"取消"];
 config.alertBtnActionArr = @[@"savePic",@""];
 config.targetVC = self.saveImageModel.photoBrowser;
 config.funcInWhere = self;
 config.animated = YES;
 
 [NSObject showSYSActionSheetConfig:config
                       alertVCBlock:nil
                    completionBlock:nil];
 }
 
 
 
 **/
