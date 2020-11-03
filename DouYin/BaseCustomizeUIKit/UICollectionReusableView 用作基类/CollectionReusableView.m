//
//  CollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "CollectionReusableView.h"

@interface CollectionReusableView ()

@end

@implementation CollectionReusableView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    @weakify(self)
    if (self.collectionReusableViewBlock) {
        self.collectionReusableViewBlock(weak_self);
    }
}

-(void)actionBlockCollectionReusableView:(MKDataBlock _Nullable)collectionReusableViewBlock{
    self.collectionReusableViewBlock = collectionReusableViewBlock;
}
//由具体的子类进行覆写
+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}

@end
