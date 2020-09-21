//
//  ZYTextField.h
//  gt
//
//  Created by Administrator on 09/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTextField.h"
#import "HistoryDataListTBV.h"
#import "HistoryDataListTBVCell.h"

/*
 *  1、空串过滤、重复字符串过滤(NSSet过滤)
 *  2、HistoryDataListTBV 加载到父视图上
 *  3、Plist存取
 *  4、文本框失去焦点时,手动强制HistoryDataListTBV置空
 *  5、每次都会刷新dataMutArr,以保持dataMutArr为最新数据,进行显示
 *  6、存plist数据用mutSet过滤过的数据
 *  7、支持在多个输入框进行存取的时候,对每一个plist进行命名单独存放
 */

typedef NS_ENUM(NSUInteger,isStoreHistoryInfo){
    isStoreHistoryInfo_NO = 0 ,
    isStoreHistoryInfo_YES  ,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZYTextField_01 : CJTextField

@property(nonatomic,strong)HistoryDataListTBV *historyDataListTBV;
@property(nonatomic,strong)MJRefreshAutoGifFooter *tableViewFooter;
@property(nonatomic,strong)MJRefreshGifHeader *tableViewHeader;
@property(nonatomic,strong)NSMutableArray *dataMutArr;

- (instancetype)initWithFrame:(CGRect)frame
                 documentName:(NSString *)docName
           isStoreHistoryInfo:(isStoreHistoryInfo)isStoreHistoryInfo;
-(NSString *)getPlistPath;//存取路径
-(void)store:(NSString *)str;//存方法

@end

NS_ASSUME_NONNULL_END

