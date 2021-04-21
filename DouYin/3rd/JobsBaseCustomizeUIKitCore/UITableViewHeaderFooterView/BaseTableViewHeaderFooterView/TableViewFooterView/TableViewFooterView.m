//
//  ViewForTableViewFooter.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "TableViewFooterView.h"

@interface TableViewFooterView ()

@property(nonatomic,copy)MKDataBlock _Nullable tableViewFooterViewBlock;

@end

@implementation TableViewFooterView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)heightWithModel:(id _Nullable)model{
    return 0.0f;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.tableViewFooterViewBlock) {
        self.tableViewFooterViewBlock(@1);
    }
}
/*
    用于以此为基类的actionBlockTableViewFooterView的子类的所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockTableViewFooterView:(MKDataBlock _Nullable)tableViewFooterViewBlock{
    self.tableViewFooterViewBlock = tableViewFooterViewBlock;
}

@end
