//
//  UserDefaultManager.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import <Foundation/Foundation.h>
#import "UserDefaultModel.h"

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

NS_ASSUME_NONNULL_BEGIN
/// 本类只管理NSUserDefault数据的存储
@interface UserDefaultManager : NSObject
//存数据【键值对类型】
+(void)saveValue:(id)value
          forKey:(NSString *)key;
+(void)storedData:(UserDefaultModel *)userDefaultModel;//存数据【对象类型】对象会转化为json字符串进行存储，因为没有被序列化所以直接存不进去
+(id)fetchDataWithKey:(NSString *)key;//取数据【在外层用mj_objectWithKeyValues进行解析】
+(void)cleanDataWithKey:(NSString *)key;//清数据

@end

NS_ASSUME_NONNULL_END
