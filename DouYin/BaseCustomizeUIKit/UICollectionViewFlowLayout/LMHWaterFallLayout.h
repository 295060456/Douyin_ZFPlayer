//
//  LMHWaterFallLayout.h
//  WateFallLayoutTest
//
//  Created by 刘梦桦 on 2017/5/18.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMHWaterFallLayout;

@protocol  LMHWaterFallLayoutDeleaget<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout
  heightForItemAtIndexPath:(NSUInteger)indexPath
                 itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout;
/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout;
/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout;
/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout;


@end

@interface LMHWaterFallLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic,weak)id<LMHWaterFallLayoutDeleaget> delegate;

@end
