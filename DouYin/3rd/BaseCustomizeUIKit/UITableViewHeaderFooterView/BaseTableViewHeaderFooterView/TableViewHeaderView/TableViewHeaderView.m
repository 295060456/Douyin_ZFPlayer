//
//  ViewForTableViewHeader.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "TableViewHeaderView.h"

@interface TableViewHeaderView ()

@property(nonatomic,copy)MKDataBlock _Nullable tableViewHeaderViewBlock;

@end

@implementation TableViewHeaderView

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
    if (self.tableViewHeaderViewBlock) {
        self.tableViewHeaderViewBlock(@1);
    }
}
/*
    用于以此为基类的TableViewHeaderView的子类的所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockTableViewHeaderView:(MKDataBlock _Nullable)tableViewHeaderViewBlock{
    self.tableViewHeaderViewBlock = tableViewHeaderViewBlock;
}

@end
