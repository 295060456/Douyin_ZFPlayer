//
//  UserDefaultManager.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import <Foundation/Foundation.h>
#import "UserDefaultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultManager : NSObject

+(void)storedData:(UserDefaultModel *)userDefaultModel;//存数据
+(id)fetchDataWithKey:(NSString *)key;//取数据
+(void)cleanDataWithKey:(NSString *)key;//清数据

@end

NS_ASSUME_NONNULL_END
