//
//  ViewForTableViewFooter.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewFooterView : UITableViewHeaderFooterView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)heightWithModel:(id _Nullable)model;
/*
    用于以此为基类的actionBlockTableViewFooterView的子类的所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockTableViewFooterView:(MKDataBlock _Nullable)tableViewFooterViewBlock;

@end

NS_ASSUME_NONNULL_END
