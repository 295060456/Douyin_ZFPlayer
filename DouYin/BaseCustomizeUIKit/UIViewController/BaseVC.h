//
//  BaseVC.h
//  gtp
//
//  Created by GT on 2019/1/8.
//  Copyright © 2019 GT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

typedef enum : NSUInteger {
    ComingStyle_PUSH = 0,
    ComingStyle_PRESENT
} ComingStyle;

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController
<
UIGestureRecognizerDelegate
,UINavigationControllerDelegate
>

#pragma mark ——RACSignal
@property(nonatomic,strong)RACSignal *reqSignal;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,assign)ComingStyle pushOrPresent;

@property(nonatomic,assign)BOOL isRequestFinish;//数据请求是否完毕 !!!
@property(nonatomic,copy)void (^ReachableViaWWANNetWorking)(void);//3G网络
@property(nonatomic,copy)void (^ReachableViaWiFiNetWorking)(void);//WiFi
@property(nonatomic,copy)void (^UnknownNetWorking)(void);//未知网络
@property(nonatomic,copy)void (^NotReachableNetWorking)(void);//无任何网络连接
@property(nonatomic,copy)void (^ReachableNetWorking)(void);//有网络

#pragma mark —— Sys_LifeCycle
-(void)VCwillComingBlock:(MKDataBlock)block;//即将进来
-(void)VCdidComingBlock:(MKDataBlock)block;//已经进来
-(void)VCwillBackBlock:(MKDataBlock)block;//即将出去
-(void)VCdidBackBlock:(MKDataBlock)block;//已经出去
#pragma mark —— Sys.
-(void)locateTabBar:(NSInteger)index;
///设置状态栏背景颜色
-(void)setStatusBarBackgroundColor:(UIColor *)color;
#pragma mark —— Others
@property(nonatomic,copy)MKDataBlock didBackBlock;

/// 强制推控制器，自定义是PUSH还是PRESENT展现控制器，如果自定义PUSH但是navigationController不存在，则换用PRESENT展现控制器
/// @param rootVC 从A控制器
/// @param toVC 推到B控制器
/// @param comingStyle 自定义展现的方式
/// @param presentationStyle 如果是PRESENT情况下的一个系统参数设定
/// @param requestParams A控制器—>B控制器，正向传值
/// @param successBlock 在推控制器之前，反向block(B控制器），以便对B控制器的一些自定义修改
/// @param animated 是否动画展现
+(instancetype)comingFromVC:(UIViewController *)rootVC
                       toVC:(BaseVC *)toVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
                    success:(MKDataBlock)successBlock
                   animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
