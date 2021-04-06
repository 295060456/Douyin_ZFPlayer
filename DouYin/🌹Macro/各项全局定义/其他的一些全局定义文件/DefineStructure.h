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
    DevEnviron_Cambodia_Main = 0,/// 柬埔寨（主要）开发环境
    DevEnviron_Cambodia_Minor,/// 柬埔寨（次要）开发环境
    DevEnviron_Cambodia_Rally,/// 柬埔寨Rally（次要）开发环境
    DevEnviron_China_Mainland,/// 中国大陆开发环境
    TestEnviron,/// 测试环境
    ProductEnviron/// 生产环境
} NetworkingEnvir;

typedef enum : NSInteger {
    VIP界面 = 1,
    充值界面,
    上传短视频界面,
    上传帖子界面
} 界面;

#endif /* DefineStructure_h */
