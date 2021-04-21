//
//  KFZShopCatoryFlowLayput.h
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import <UIKit/UIKit.h>
#import "UIView+Extras.h"

NS_ASSUME_NONNULL_BEGIN

@interface KFZShopCatoryFlowLayput : UICollectionViewFlowLayout

@property(nonatomic,strong)NSMutableArray <NSNumber *>*affectedSectionsMutArr;//受影响的section组
@property(nonatomic,assign)CGFloat offsetX;
@property(nonatomic,assign)CGFloat offsetY;
@property(nonatomic,assign)CGFloat offsetWidth;
@property(nonatomic,assign)CGFloat offsetHeight;

@end

NS_ASSUME_NONNULL_END
