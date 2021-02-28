//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "BaseCollectionViewCell.h"
#import "UICollectionViewCell+ShakeAnimation.h"

@interface BaseCollectionViewCell ()

@end

@implementation BaseCollectionViewCell

+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self richElementsInCellWithModel:nil];
    }return self;
}
//由具体的子类进行覆写
+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//由具体的子类进行覆写
-(void)richElementsInCellWithModel:(id _Nullable)model{}

@end
