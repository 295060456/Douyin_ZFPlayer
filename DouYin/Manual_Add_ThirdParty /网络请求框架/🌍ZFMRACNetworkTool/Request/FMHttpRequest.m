//
//  FMHttpRequest.m
//  ZFMRACNetwork
//
//  Created by todriver02 on 2018/7/31.
//  Copyright © 2018年 zhufaming. All rights reserved.
//

#import "FMHttpRequest.h"

@implementation ExtendsParameters

+ (instancetype)extendsParameters{
    return self.new;
}

- (instancetype)init{
    if (self = [super init]) {
    }return self;
}

- (NSString *)version{
    static NSString *version = nil;
    if (!version) version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    return (version.length > 0) ? version:@"";
}

- (NSString *)token {
    // token 自己的逻辑
    return @"";
}
//设备ID 自行逻辑获取
- (NSString *)deviceid{
    static NSString *deviceidStr = nil;
    return deviceidStr.length > 0 ? deviceidStr:@"";
}

- (NSString *)platform{
    return @"iOS";
}

- (NSString *)channel{
    return @"AppStore";
}

- (NSString *)t{
    return [NSString stringWithFormat:@"%.f", [NSDate date].timeIntervalSince1970];
}

@end

@implementation FMHttpRequest

+(instancetype)urlParametersWithMethod:(NSString *)method
                                  path:(NSString *)path
                            parameters:(NSDictionary *)parameters{
    return [[self alloc] initUrlParametersWithMethod:method
                                                path:path
                                          parameters:parameters];
}

-(instancetype)initUrlParametersWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters{
    if (self = [super init]) {
        //加公共的参数
        NSMutableDictionary *dataMutDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        self.method = method;
        self.path = path;
        self.parameters = [NSDictionary dictionaryWithDictionary:dataMutDic];
        self.extendsParameters = ExtendsParameters.new;
    }return self;
}

@end
