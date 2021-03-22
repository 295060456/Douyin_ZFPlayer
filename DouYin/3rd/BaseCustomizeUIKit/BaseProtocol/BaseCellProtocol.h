//
//  BaseCellProtocol.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseCellProtocol <NSObject>

@required
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath;

@optional
@property(nonatomic,strong)NSIndexPath *idxPath;
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
