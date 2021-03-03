//
//  BaseModel.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property(nonatomic,strong)NSString *endRow;
@property(nonatomic,strong)NSString *hasNextPage;
@property(nonatomic,strong)NSString *hasPreviousPage;
@property(nonatomic,strong)NSString *isFirstPage;
@property(nonatomic,strong)NSString *isLastPage;

@property(nonatomic,strong)NSString *navigateFirstPage;
@property(nonatomic,strong)NSString *navigateLastPage;
@property(nonatomic,strong)NSString *navigatePages;
@property(nonatomic,strong)NSArray *navigatepageNums;

@property(nonatomic,strong)NSString *nextPage;
@property(nonatomic,strong)NSString *pageNum;
@property(nonatomic,strong)NSString *pageSize;
@property(nonatomic,strong)NSString *pages;
@property(nonatomic,strong)NSString *prePage;
@property(nonatomic,strong)NSString *size;
@property(nonatomic,strong)NSString *startRow;
@property(nonatomic,strong)NSString *total;

@end

NS_ASSUME_NONNULL_END
