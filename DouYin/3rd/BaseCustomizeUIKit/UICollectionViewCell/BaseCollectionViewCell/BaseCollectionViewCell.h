//
//  CollectionViewCell.h
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath *idxPath;

+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath;
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
