//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

NetworkingEnvir networkingEnvir = DevEnviron_01;/// 开发环境_1
//NetworkingEnvir networkingEnvir = DevEnviron_02;/// 开发环境_2
//NetworkingEnvir networkingEnvir = DevEnviron_03;/// 开发环境_3
//NetworkingEnvir networkingEnvir = DevEnviron_04;/// 开发环境_4
//NetworkingEnvir networkingEnvir = TestEnviron;/// 测试环境
//NetworkingEnvir networkingEnvir = UATEnviron;/// UAT环境
//NetworkingEnvir networkingEnvir = ProductEnviron;/// 生产环境

@implementation NSObject (URLManager)

+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl{
    switch (networkingEnvir) {
        case DevEnviron_01:{
            /// 开发环境_1
            return @"";
        }break;
        case DevEnviron_02:{
            /// 开发环境_2
            return @"";
        }break;
        case DevEnviron_03:{
            /// 开发环境_3
            return @"";
        }break;
        case DevEnviron_04:{
            /// 测试环境
            return @"";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case UATEnviron:{
            /// UAT 环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}

+(NSString *)BaseUrl_H5{
    switch (networkingEnvir) {
        case DevEnviron_01:{
            /// 开发环境_1
            return @"";
        }break;
        case DevEnviron_02:{
            /// 开发环境_2
            return @"";
        }break;
        case DevEnviron_03:{
            /// 开发环境_3
            return @"";
        }break;
        case DevEnviron_04:{
            /// 测试环境
            return @"";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case UATEnviron:{
            /// UAT 环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}
#pragma mark —— App接口示例
+(URLManagerModel *)appInterfaceTesting{
    return [NSObject url:@"http://172.24.135.12/CommentData.json"
                funcName:NSStringFromSelector(_cmd)];
}

@end
