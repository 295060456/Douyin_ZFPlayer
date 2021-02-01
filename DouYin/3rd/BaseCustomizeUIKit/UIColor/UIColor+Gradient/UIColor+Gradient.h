//
//  UIColor+Gradient.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/1.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 渐变色
@interface UIColor (Gradient)

+(UIColor *)gradientCorDataMutArr:(NSMutableArray <UIColor *>*_Nullable)CorDataMutArr
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                           opaque:(BOOL)opaque
                  withTargetLabel:(UILabel *_Nonnull)targetLabel;

@end

NS_ASSUME_NONNULL_END
