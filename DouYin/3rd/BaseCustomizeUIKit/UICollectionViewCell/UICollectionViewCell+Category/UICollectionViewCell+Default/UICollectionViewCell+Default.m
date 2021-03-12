//
//  UICollectionViewCell+Default.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/11.
//

#import "UICollectionViewCell+Default.h"

@implementation UICollectionViewCell (Default)

+(instancetype)defaultCellWithCollectionView:(nonnull UICollectionView *)collectionView
                                forIndexPath:(nonnull NSIndexPath *)indexPath{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class)
                                                        forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerClass:self.class
           forCellWithReuseIdentifier:ReuseIdentifier];
        [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class)
                                                  forIndexPath:indexPath];
    }return cell;
}

@end
