//
//  NSObject+Measure.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Measure)

/// 已知父控件和子控件的宽度或者高度，当父控件为X轴或者Y轴中心的时候，子控件的X 和 Y 是多少？
/// @param subview 子控件的宽 或者 高
/// @param superview 父控件的宽 或者 高
+(CGFloat)measureSubview:(CGFloat)subview
               superview:(CGFloat)superview;

@end

NS_ASSUME_NONNULL_END
