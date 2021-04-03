//
//  DDNetworkingAPI+WalletApi.h
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

///// 抖币兑换余额提示 GET
//+(URLManagerModel *)chargeBalanceTipsGET;
///// 金币兑换 POST
//+(URLManagerModel *)chargeGoldPOST;
///// 余额兑换会员 POST
//+(URLManagerModel *)chargeVipPOST;
///// 获取余额兑换会员类型下拉框 GET
//+(URLManagerModel *)getToMemTypeGET;
///// 获取提现兑换类型下拉框 GET
//+(URLManagerModel *)getWithdrawTypeGET;
///// 我的钱包流水 POST
//+(URLManagerModel *)myFlowsPOST;
///// 二期抖币流水 GET
//+(URLManagerModel *)myGoldGET;
///// 钱包流水（二期) GET
//+(URLManagerModel *)myPurseFlowGET;
///// 获取用户信息 POST
//+(URLManagerModel *)myUserWalletPOST;
///// 获取用户信息 POST
//+(URLManagerModel *)myWalletPOST;
///// App端转账（转账即可畅玩游戏）POST
//+(URLManagerModel *)transferPOST;
///// 包网回调地址 POST
//+(URLManagerModel *)transferCallBackPOST;
///// 包网回调校验地址 POST
//+(URLManagerModel *)transferVerifyPOST;
///// 余额提现 POST
//+(URLManagerModel *)withdrawBalancePOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (WalletApi)

#pragma mark —— App钱包相关接口
/// 抖币兑换余额提示
+(void)chargeBalanceTipsGET:(id)parameters
               successBlock:(MKDataBlock)successBlock;
/// 金币兑换
+(void)chargeGoldPOST:(id)parameters
         successBlock:(MKDataBlock)successBlock;
/// 余额兑换会员
+(void)chargeVipPOST:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 获取余额兑换会员类型下拉框
+(void)getToMemTypeGET:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 获取提现兑换类型下拉框
+(void)getWithdrawTypeGET:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 我的钱包流水
+(void)myFlowsPOST:(id)parameters
      successBlock:(MKDataBlock)successBlock
      failureBlock:(MKDataBlock)failureBlock;
/// 二期抖币流水
+(void)myGoldGET:(id)parameters
    successBlock:(MKDataBlock)successBlock
    failureBlock:(MKDataBlock)failureBlock;
/// 钱包流水（二期)
+(void)myPurseFlowGET:(id)parameters
         successBlock:(MKDataBlock)successBlock
         failureBlock:(MKDataBlock)failureBlock;
/// 获取用户信息
+(void)myUserWalletPOST:(id)parameters
           successBlock:(MKDataBlock)successBlock;
/// 获取用户信息
+(void)myWalletPOST:(id)parameters
       successBlock:(MKDataBlock)successBlock;
/// App端转账（转账即可畅玩游戏
+(void)transferPOST:(id)parameters
       successBlock:(MKDataBlock)successBlock;
/// 包网回调地址
+(void)transferCallBackPOST:(id)parameters
               successBlock:(MKDataBlock)successBlock;
/// 包网回调校验地址
+(void)transferVerifyPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 余额提现
+(void)withdrawBalancePOST:(id)parameters
              successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
