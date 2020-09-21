//
//  HistoryDataListTBV.m
//  My_BaseProj
//
//  Created by Administrator on 05/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "HistoryDataListTBV.h"

@interface HistoryDataListTBV ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
}

@property(nonatomic,strong)NSArray *dataArr;
//@property(nonatomic,copy)MKDataBlock block;
@property(nonatomic,copy)TwoDataBlock block2;
@property(nonatomic,strong)id trigger;

@end

@implementation HistoryDataListTBV

- (void)dealloc {
    
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+(instancetype)initWithRequestParams:(id)requestParams
                           triggerBy:(id __nonnull)trigger{
    HistoryDataListTBV *tbv = [[HistoryDataListTBV alloc]initWithFrame:CGRectZero
                                                                 style:UITableViewStylePlain];
    
    if ([requestParams isKindOfClass:[NSArray class]]) {
        tbv.dataArr = requestParams;
        tbv.trigger = trigger;
    } return tbv;
}

-(instancetype)initWithFrame:(CGRect)frame
                       style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame
                              style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }return self;
}

-(void)showSelectedData:(TwoDataBlock)block{
    self.block2 = block;
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HistoryDataListTBVCell cellHeightWithModel:NULL];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block2) {
        self.block2(self.dataArr[indexPath.row],self.trigger);
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDataListTBVCell *cell = [HistoryDataListTBVCell cellWith:tableView];
    [cell richElementsInCellWithModel:self.dataArr[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

////给cell添加动画
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //设置Cell的动画效果为3D效果
//    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//}


@end
