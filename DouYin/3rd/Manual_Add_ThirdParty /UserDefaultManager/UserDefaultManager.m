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
//存数据
+(void)storedData:(UserDefaultModel *)userDefaultModel{
    if (![NSString isNullString:userDefaultModel.key]) {
        if (userDefaultModel.obj && ![userDefaultModel.obj isKindOfClass:NSNull.class]) {
            [[NSUserDefaults standardUserDefaults] setObject:userDefaultModel.obj
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
//取数据
+(id)fetchDataWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
//清数据
+(void)cleanDataWithKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
