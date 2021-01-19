//
//  KFZShopCatoryFlowLayput.m
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import "KFZShopCatoryFlowLayput.h"

/**
    自定义section背景view 注意继承于UICollectionReusableView
    有点内部类的味道，你品、你细品
 */
@interface KFZShopCatorySectionWhiteBgView : UICollectionReusableView

@end

@implementation KFZShopCatorySectionWhiteBgView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@"");
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.backgroundColor = kWhiteColor;
    //加阴影立体效果
    [UIView makeTargetShadowview:self
                       superView:nil
                 shadowDirection:ShadowDirection_rightDown
               shadowWithOffsetX:5
                         offsetY:5
                    cornerRadius:8
                    shadowOffset:DefaultSize
                   shadowOpacity:1
                layerShadowColor:DefaultObj
               layerShadowRadius:DefaultValue];
}

@end

//下面是自定义的layout
@interface KFZShopCatoryFlowLayput  ()
//存放新的layouttAttributes
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end

@implementation KFZShopCatoryFlowLayput

- (void)prepareLayout{
    [super prepareLayout];
    
    NSInteger sections = self.collectionView.numberOfSections;
    if (sections == 0) {//没有内容直接返回
        return;
    }
    
    if (self.affectedSectionsMutArr.count == 0) {
        return;
    }
    
    id<UICollectionViewDelegateFlowLayout> delegate  = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
    
    //1.初始化 注册背景view类
    [self registerClass:[KFZShopCatorySectionWhiteBgView class] forDecorationViewOfKind:@"KFZShopCatorySectionWhiteBgView"];
    [self.decorationViewAttrs removeAllObjects];
    
    for (NSInteger section = 0; section < sections; section++) {
       NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems > 0) {
            UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                      inSection:section]];
            UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1)
                                                                                                                     inSection:section]];
            
            UIEdgeInsets sectionInset = self.sectionInset;
            if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                UIEdgeInsets inset = [delegate collectionView:self.collectionView
                                                       layout:self
                                       insetForSectionAtIndex:section];
                if (!UIEdgeInsetsEqualToEdgeInsets(inset, sectionInset)) {
                    sectionInset = inset;
                }
            }
            
            CGSize sectionHeaderSize;
            if ([delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
                
                sectionHeaderSize = [delegate collectionView:self.collectionView
                                                      layout:self
                             referenceSizeForHeaderInSection:section];
            }
            
            if (section == 0) {
                sectionHeaderSize.height = 0;
            }
            
            CGRect sectionFrame = CGRectUnion(firstAttr.frame, lastAttr.frame);
            
            sectionFrame.origin.y += self.offsetY;
            sectionFrame.size.height += self.offsetHeight;
            sectionFrame.origin.x += self.offsetX;
            sectionFrame.size.width += self.offsetWidth;
            
            for (NSNumber *affectedIdx in self.affectedSectionsMutArr) {
                if (affectedIdx.integerValue == section) {
                    //2. 定义
                    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"KFZShopCatorySectionWhiteBgView"
                                                                                                                         withIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                                                          inSection:section]];
                    attr.frame = sectionFrame;
                    attr.zIndex = -1;
                    [self.decorationViewAttrs addObject:attr];
                }else{
                    continue;
                }
            }
        }else{
            continue ;
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray * attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }return [attrs copy];
}
#pragma mark —— lazyLoad
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = NSMutableArray.array;
    }return _decorationViewAttrs;
}

-(NSMutableArray<NSNumber *> *)affectedSectionsMutArr{
    if (!_affectedSectionsMutArr) {
        _affectedSectionsMutArr = NSMutableArray.array;
    }return _affectedSectionsMutArr;
}

-(CGFloat)offsetX{
    if (_offsetX == 0) {
        _offsetX = -15;
    }return _offsetX;
}

-(CGFloat)offsetY{
    if (_offsetY == 0) {
        _offsetY = -7;
    }return _offsetY;
}

-(CGFloat)offsetWidth{
    if (_offsetWidth == 0) {
        _offsetWidth = 30;
    }return _offsetWidth;
}

-(CGFloat)offsetHeight{
    if (_offsetHeight == 0) {
        _offsetHeight = 15;
    }return _offsetHeight;
}

@end
