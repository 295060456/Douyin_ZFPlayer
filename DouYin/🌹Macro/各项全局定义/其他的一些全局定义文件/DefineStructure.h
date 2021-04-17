//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h

#import <UIKit/UIKit.h>
/*
 这个类只放置用户自定义的定义的枚举值
 */
typedef enum : NSInteger {
    DevEnviron_01 = 0,/// 开发环境_01
    DevEnviron_02,///  开发环境_02
    DevEnviron_03,/// 开发环境_03
    DevEnviron_04,/// 开发环境_04
    TestEnviron,/// 测试环境
    UATEnviron,//// UAT 环境
    ProductEnviron,/// 生产环境
} NetworkingEnvir;

typedef enum : NSInteger {
    VIP界面 = 1,
    充值界面,
    上传短视频界面,
    上传帖子界面
} 界面;

#endif /* DefineStructure_h */
