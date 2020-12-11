//
//  URLManagerModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//建立此类的目的：防止外层调用funcName的时候因为手滑出错不易检查，导致崩溃
@interface URLManagerModel : NSObject

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *funcName;
@property(nonatomic,strong)NSNumber *pageSize;//每页数据容量
@property(nonatomic,strong)NSNumber *currentPageNum;//当前页码

@end

NS_ASSUME_NONNULL_END
