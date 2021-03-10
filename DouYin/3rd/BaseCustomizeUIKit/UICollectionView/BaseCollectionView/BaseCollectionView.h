//
//  CollectionView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
    子类如果重写-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event，则将会被优先执行，从而忽略UICollectionViewDelegate方法
 *
 */
@interface BaseCollectionView : UICollectionView

@property(nonatomic,copy)MKDataBlock baseCollectionViewBlock;

//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定宽】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewWidthWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model;
//具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model;
//具体由子类进行复写【数据Frame】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGRect)viewFrameWithModel:(id _Nullable)model;
/*
    用于以此为基类的UICollectionView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseCollectionView:(MKDataBlock)baseCollectionViewBlock;

@end

NS_ASSUME_NONNULL_END
