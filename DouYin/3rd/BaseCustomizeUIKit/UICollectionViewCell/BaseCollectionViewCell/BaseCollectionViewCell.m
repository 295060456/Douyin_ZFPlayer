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
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(id _Nullable)model{}

@end
