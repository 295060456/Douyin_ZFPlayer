//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)registerCollectionViewClass{
    
//    [self registerClass:DDUserDetailsCollectionReusableView.class
//        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//        withReuseIdentifier:NSStringFromClass(DDUserDetailsCollectionReusableView.class)];
//
//    [self registerClass:DDCollectionViewCell_Style1.class
//        forCellWithReuseIdentifier:NSStringFromClass(DDCollectionViewCell_Style1.class)];
//    [self registerClass:DDCollectionViewCell_Style2.class
//        forCellWithReuseIdentifier:NSStringFromClass(DDCollectionViewCell_Style2.class)];
//    [self registerClass:DDCollectionViewCell_Style3.class
//        forCellWithReuseIdentifier:NSStringFromClass(DDCollectionViewCell_Style3.class)];
//    [self registerClass:DDCollectionViewCell_Style4.class
//        forCellWithReuseIdentifier:NSStringFromClass(DDCollectionViewCell_Style4.class)];
//    [self registerClass:DDCollectionViewCell_Style5.class
//        forCellWithReuseIdentifier:NSStringFromClass(DDCollectionViewCell_Style5.class)];
    [self registerClass:UICollectionViewCell.class
        forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
}

@end
