//
//  CollectionView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionView : UICollectionView

//具体由子类进行复写【数据定UI】
-(void)richElementsInViewWithModel:(id _Nullable)model;
//具体由子类进行复写【数据Frame】
+(CGRect)viewFrameWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
