//
//  HistoryDataListTBV.h
//  My_BaseProj
//
//  Created by Administrator on 05/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryDataListTBVCell.h"
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryDataListTBV : UITableView

+(instancetype)initWithRequestParams:(id)requestParams
                           triggerBy:(id __nonnull)trigger;
-(void)showSelectedData:(TwoDataBlock)block;//点击的内容、触发点

@end

NS_ASSUME_NONNULL_END
