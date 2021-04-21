//
//  BaseTableViewer.h
//  Feidegou
//
//  Created by Kite on 2019/10/31.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView
/*
    用于以此为基类的BaseTableView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseTableView:(MKDataBlock _Nullable)baseTableViewBlock;

@end

NS_ASSUME_NONNULL_END
