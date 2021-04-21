//
//  UICollectionViewCell+ShakeAnimation.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (ShakeAnimation)

-(void)beginShake;// 实现cell抖动方法
-(void)stopShake;// 实现cell停止抖动方法

@end

NS_ASSUME_NONNULL_END
