//
//  TabBarControllerConfig.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBarControllerConfig : NSObject

@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,strong)NSString *title;//显示标题
@property(nonatomic,strong)UIImage *imageSelected; //选中状态的静态图
@property(nonatomic,strong)UIImage *imageUnselected;//未选中状态的静态图
@property(nonatomic,assign)CGFloat humpOffsetY;//Y轴凸起的偏移量 传0就是不凸起
@property(nonatomic,strong)NSString *lottieName;//有值则启用Lottie动画
@property(nonatomic,assign)NSUInteger tag;

@end

NS_ASSUME_NONNULL_END
