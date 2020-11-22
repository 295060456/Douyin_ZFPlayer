//
//  CollectionReusableView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SectionHeader,
    SectionFooter,
} UICollectionElementKind;

@interface CollectionReusableView : UICollectionReusableView

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)MKDataBlock collectionReusableViewBlock;
@property(nonatomic,assign)BOOL selected;

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model;//由具体的子类进行覆写
-(void)richElementsInCellWithModel:(id _Nullable)model;//由具体的子类进行覆写
-(void)actionBlockCollectionReusableView:(MKDataBlock _Nullable)collectionReusableViewBlock;

@end

NS_ASSUME_NONNULL_END
