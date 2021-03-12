//
//  NSObject+Extras.h
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

#if __has_include(<GKPhotoBrowser/GKPhotoBrowser.h>)
#import <GKPhotoBrowser/GKPhotoBrowser.h>
#else
#import "GKPhotoBrowser.h"
#endif

#if __has_include(<TABAnimated/TABAnimated.h>)
#import <TABAnimated/TABAnimated.h>
#else
#import "TABAnimated.h"
#endif

#if __has_include(<YYImage/YYImage.h>)
#import <YYImage/YYImage.h>
#else
#import "YYImage.h"
#endif

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif
/**
 @param weakSelf 方便使用，用来打破循环引用。使用时需要改成实际类型，否则没有代码提示.
 @param arg 事件默认传递的对象，比如`NSNotification`，`UIButton`。
 */
typedef void (^callback)(id _Nullable weakSelf, id _Nullable arg);

@interface NSObject (Extras)

@property(nonatomic,strong,nullable)NSIndexPath * _indexPath;//CollectionView、TableView等的序列号
@property(nonatomic,assign)NSInteger _currentPage;//网路请求分页数据的时候的当前页码

///震动特效反馈
+(void)feedbackGenerator;
/*
 * 检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
 * 作用范围:在sceneDidEnterBackground（iOS 13及其以上版本有效） && applicationDidEnterBackground（iOS 13以下版本有效）
 * 调试是否进入后台，要断开于Xcode的连接，否则屏幕常亮
 */
+(BOOL)didUserPressLockButton;
/// iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch;
/// 打印请求体
+(void)printRequestMessage:(NSURLSessionDataTask *_Nullable)task;
/// 保存图片
+(void)savePic:(GKPhotoBrowser *_Nullable)browser;
/// 获取当前 UIViewController
+(UIViewController *_Nonnull)getCurrentViewController;
/// 用block来代替selector
SEL _Nullable selectorBlocks(callback _Nonnull ,id _Nullable target);
/// 获取当前设备可用内存
+(double)availableMemory;
/// 获取当前任务所占用内存
+(double)usedMemory;
/// 加入键盘通知的监听者
-(void)keyboard;
/// 停止刷新
-(void)endRefreshing:(UIScrollView *_Nonnull)targetScrollView;
/// 转换为NSData
+(NSData *_Nullable)transformToData:(id _Nullable)object;

@end
/**
 通知的写法：示例代码
 
 接受通知：
         @weakify(self)
         [NSNotificationCenter.defaultCenter addObserver:self
                                                selector:selectorBlocks(^(id  _Nullable weakSelf,
                                                                          id  _Nullable arg) {
             NSNotification *notification = (NSNotification *)arg;
             NSNumber *b = notification.object;
             NSLog(@"SSS = %d",b.boolValue);
             @strongify(self)
             self.imageView.hidden = !b.boolValue;
             self.imageView.hidden = self.selectedIndex != 4;
             self.imageView.alpha = b.boolValue;
         }, self)
                                                    name:@"点击开拍提示"
                                                  object:nil];
 
 发通知：[NSNotificationCenter.defaultCenter postNotificationName:@"点击开拍提示" object:@(NO)];
 
 */
