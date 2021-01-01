//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "CollectionViewCell.h"
#import "UICollectionViewCell+ShakeAnimation.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell
//由具体的子类进行覆写
+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//由具体的子类进行覆写
-(void)richElementsInCellWithModel:(id _Nullable)model{}

@end
