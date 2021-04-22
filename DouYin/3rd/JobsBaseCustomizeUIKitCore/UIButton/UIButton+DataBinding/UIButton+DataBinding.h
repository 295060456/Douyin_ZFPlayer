//
//  UIButton+DataBinding.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * UIButton 的具体子类 的数据绑定
 * 应用场景：一些view上的block的回调，直接将view的数据模型绑定在button上，回调直接回调这个button
 * 因为是预防view上可能会存在多个button，而外层需要对button进行判断定位到底是哪个button
 */
@interface UIButton (DataBinding)

@property(nonatomic,strong)id requestParams;

@end

NS_ASSUME_NONNULL_END
