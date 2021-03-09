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

/*
     常用的解析方法:

     1、NSMutableArray *tags = [VideoTagModel mj_objectArrayWithKeyValuesArray:model.data]; //【对待data是数组】
     2、DDMyVipModel *myVipModel = [DDMyVipModel mj_objectWithKeyValues:data]; //【对待data是数组】
 */

/**
     例子：如果遇到【总数据Data】里面是数组,数组里面各种模型数组互相嵌套,如下所示👇

     Data = {
         msg = "success";
         data = (
             {
                 notes = "至尊永久卡，可传辈";
                 vipLevel = 4;
                 originalPrice = 29900;
                 price = 5000;
                 sid = "1";
                 seniorDetail = (
                     {
                         name = "动态优先审核";
                         icon = "";
                         code = "isDynamicCheck";
                     }
                 );
                 duration = 0;
                 name = "永久卡【限时2折】";
                 icon = "";
             }
         );
         code = 200;
     }

     设立model的时候需要把外层的 msg、code、data 一起解析

     具体的model为

     @interface DDMyVipModel : NSObject

     @property(nonatomic,copy)NSString *msg;
     @property(nonatomic,strong)NSArray <DDMyVipListModel *>*data;
     @property(nonatomic,copy)NSString *code;

     @end

     具体代码为：[DDMyVipModel mj_objectWithKeyValues:Data];

 **/
