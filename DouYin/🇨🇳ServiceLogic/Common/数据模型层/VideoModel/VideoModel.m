//
//  VideoModel.m
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "VideoModel.h"

@implementation VideoModel_Core

@end

@implementation VideoModel

-(instancetype)init{
    if (self = [super init]) {
        [VideoModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                @"VideoModel_Core":@"listMutArr"
            };
        }];
    }return self;
}

@end
