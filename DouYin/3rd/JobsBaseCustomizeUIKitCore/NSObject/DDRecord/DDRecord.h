//
//  DDMutableArray.h
//  DouDong-II
//
//  Created by Jobs on 2021/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 簇类不建议继承 
@interface DDRecord : NSObject

@property(nonatomic,strong)NSMutableArray *recordMutArr;
@property(nonatomic,strong)NSMutableDictionary *recordMutDic;
@property(nonatomic,strong)NSMutableSet *recordMutSet;
@property(nonatomic,strong)NSMutableString *recordMutString;
@property(nonatomic,strong)NSMutableData *recordMutData;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
