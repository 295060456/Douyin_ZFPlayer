//
//  CollectionView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/*
    子类如果重写-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event，则将会被优先执行，从而忽略UICollectionViewDelegate方法
 *
 */
@interface BaseCollectionView : UICollectionView<BaseViewProtocol>

@property(nonatomic,copy)MKDataBlock baseCollectionViewBlock;
/*
    用于以此为基类的UICollectionView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseCollectionView:(MKDataBlock)baseCollectionViewBlock;

@end

NS_ASSUME_NONNULL_END
