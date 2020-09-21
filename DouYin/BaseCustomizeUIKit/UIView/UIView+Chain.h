//
//  UIView+Chain.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/11.
//  Copyright © 2020 Jobs. All rights reserved.
//
///iOS 子视图超出父视图不响应解决办法
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Chain)

@property(nonatomic,assign)BOOL ableRespose;

@end

NS_ASSUME_NONNULL_END

/**
使用的时候将需要作用的View的ableRespose设置为YES即可
*/
