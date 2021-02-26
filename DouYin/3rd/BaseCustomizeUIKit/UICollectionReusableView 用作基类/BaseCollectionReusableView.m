//
//  CollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "BaseCollectionReusableView.h"

@interface BaseCollectionReusableView ()

@end

@implementation BaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self richElementsInViewWithModel:nil];
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
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
//由具体的子类进行覆写
-(void)richElementsInViewWithModel:(id _Nullable)model{
    
}

@end
