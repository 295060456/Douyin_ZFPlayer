//
//  DDNetworkingAPI+BankCardApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
/*
 * App端接口文档
 * http://172.24.135.53:8011/swagger-ui.html#/App%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%E7%9B%B8%E5%85%B3%E6%8E%A5%E5%8F%A3
 
 开发环境：
 管理后台：http://172.24.135.55/
 app-api：http://172.24.135.55/api/
 h5：http://172.24.135.55/taskpage/

 测试环境(数据已初始化)：
 管理后台：http://172.24.135.54/dist/
 app-api：http://172.24.135.54/api/
 h5：http://172.24.135.54/taskpage/
 
 抖动生产环境
 web-admin：http://www.xiuwa.top/web/beBQJvUpWl
 H5：https://www.xiuwa.top/h5/
 API：https://www.xiuwa.top/api/
 
 抖动备用域名：
 www.vdutbr.cn
 www.peprh.cn
 www.msahe.cn
 
 */

///// 添加银行卡 POST
//+(URLManagerModel *)bankAddPOST;
///// 获取银行卡信息 GET
//+(URLManagerModel *)bankInfoGET;
///// 删除 GET
//+(URLManagerModel *)bankDeleteGET;
///// 银行卡列表 GET
//+(URLManagerModel *)bankListGET;
///// 修改银行卡 POST
//+(URLManagerModel *)bankUpdatePOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (BankCardApi)

#pragma mark —— App银行卡相关接口
/// 添加银行卡
+(void)bankAddPOST:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 获取银行卡信息
+(void)bankInfoGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 删除
+(void)bankDeleteGET:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 银行卡列表
+(void)bankListGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 修改银行卡
+(void)bankUpdatePOST:(id)parameters
         successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
