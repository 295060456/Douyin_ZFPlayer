//
//  UICollectionViewCell+Default.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 
    因为在协议方法：
    - (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                    cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
    里面返回的UICollectionViewCell具体子类是需要在系统进行注册的，而不能直接返回 UICollectionViewCell.new;否则会崩
 
    那么现在就可以运用此类直接返回，示例代码：
    return [UICollectionViewCell defaultCellWithCollectionView:collectionView
                                               forIndexPath:indexPath];

 */

@interface UICollectionViewCell (Default)

+(instancetype)defaultCellWithCollectionView:(nonnull UICollectionView *)collectionView
                                forIndexPath:(nonnull NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
