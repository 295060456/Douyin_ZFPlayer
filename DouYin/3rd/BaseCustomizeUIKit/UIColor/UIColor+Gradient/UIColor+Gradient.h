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
                   targetViewRect:(CGRect)targetViewRect;

@end

NS_ASSUME_NONNULL_END

/**
 
 示例代码：
 
 -(void)drawRect:(CGRect)rect{
     [super drawRect:rect];
     
     self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了
     self.titleLabFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
     
     UILabel *label = [self valueForKey:@"titleLabel"];
     UIColor *cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[COLOR_RGB(247, 131, 97),COLOR_RGB(245, 75, 100)]]
                                        startPoint:CGPointZero
                                          endPoint:CGPointZero
                                            opaque:NO
                                    targetViewRect:label.frame];
     
     self.titleLabTextColor = cor;
 }
 
 */
