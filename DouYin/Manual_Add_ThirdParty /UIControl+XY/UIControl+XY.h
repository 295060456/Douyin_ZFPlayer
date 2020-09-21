//
//  UIControl+XY.h
//  JinXian Finance
//
//  Created by 刘赓 on 2017/7/17.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
http://www.jianshu.com/p/a830d0a57378
 */

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (XY)

@property(nonatomic,assign)NSTimeInterval uxy_acceptEventInterval;//可以用这个给重复点击加间隔

@end

NS_ASSUME_NONNULL_END
