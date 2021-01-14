//
//  UserDefaultManager.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import "UserDefaultManager.h"

@interface UserDefaultManager ()

@end

@implementation UserDefaultManager
//存数据【键值对类型】
+(void)saveValue:(id)value
          forKey:(NSString *)key{
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.key = key;
    userDefaultModel.obj = value;
    [UserDefaultManager storedData:userDefaultModel];
}
//存数据【对象类型】对象会转化为json字符串进行存储，因为没有被序列化所以直接存不进去
+(void)storedData:(UserDefaultModel *)userDefaultModel{
    if (![NSString isNullString:userDefaultModel.key]) {
        if (userDefaultModel.obj && ![userDefaultModel.obj isKindOfClass:NSNull.class]) {
            [[NSUserDefaults standardUserDefaults] setObject:[userDefaultModel.obj mj_JSONString]
                                                      forKey:userDefaultModel.key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
        
        if (userDefaultModel.booLValue) {
            [[NSUserDefaults standardUserDefaults] setBool:userDefaultModel.booLValue
                                                    forKey:userDefaultModel.key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return;
        }
    }
}
//取数据【在外层用mj_objectWithKeyValues进行解析】
+(id)fetchDataWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
//清数据
+(void)cleanDataWithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
