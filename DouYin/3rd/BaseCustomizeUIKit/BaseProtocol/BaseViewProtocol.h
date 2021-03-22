//
//  BaseViewProtocol.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewProtocol <NSObject>

@optional

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

@end

NS_ASSUME_NONNULL_END
