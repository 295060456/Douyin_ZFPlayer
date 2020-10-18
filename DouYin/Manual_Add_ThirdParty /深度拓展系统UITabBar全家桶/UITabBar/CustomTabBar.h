//
//  CustomTabBar.h
//  HitTesting
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 flowyears. All rights reserved.
//

#import <UIKit/UIKit.h>

// 超过 6 个 系统会变成更多，过不了审核
@interface CustomTabBar : UITabBar

@property(nonatomic,strong)UIColor *__nullable bgColor;
@property(nonatomic,assign)CGFloat offsetHeight;
@property(nonatomic,assign)BOOL isTranslucent;//是否取消tabBar的透明效果

//只有在init方法传值才管用，在layoutSubviews以及drawRect均不起作用，其中在layoutSubviews还会发生循环引用，内存暴涨
- (instancetype __nullable)initWithBgImg:(UIImage *__nullable)bgImg;


@end
