//
//  UICollectionView+RegisterClass.h
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import <UIKit/UIKit.h>

//#import "UBLSearchCollectionReusableView.h"
//#import "UBLHotCollectionReusableView.h"
//#import "UBLAllCollectionReusableView.h"
//
//#import "UBLVideoCollectionViewCell@Style1.h"
//#import "UBLVideoCollectionViewCell@Style2.h"
//#import "UBLVideoCollectionViewCell@Style3.h"
//#import "UBLVideoCollectionViewCell@Style4.h"
//#import "UBLVideoCollectionViewCell@Style5.h"
//#import "UBLVideoCollectionViewCell@Style6.h"
//#import "UBLVideoCollectionViewCell@Style7.h"
//#import "UBLVideoCollectionViewCell@Style8.h"
//#import "UBLVideoCollectionViewCell@Style9.h"
//#import "UBLVideoCollectionViewCell@Style10.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (RegisterClass)
//注册的时候不开辟内存，只有当用字符串进行取值的时候才开辟内存
-(void)registerCollectionViewClass;

@end

NS_ASSUME_NONNULL_END
