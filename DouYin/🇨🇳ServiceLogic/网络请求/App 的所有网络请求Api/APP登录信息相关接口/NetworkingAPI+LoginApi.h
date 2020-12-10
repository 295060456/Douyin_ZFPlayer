//
//  NetworkingAPI+LoginApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"
/*
各种环境的地址 和 接口文档地址 在这里写，方便调用
 
 */
NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (LoginApi)

#pragma mark —— APP登录信息相关接口
/// 找回密码接口-重置密码
+(void)changePasswordPOST:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 找回密码接口-身份验证
+(void)checkIdentityPOST:(id)parameters
        withsuccessBlock:(MKDataBlock)successBlock;
/// 登录
+(void)appLoginPOST:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;
/// 退出
+(void)appLogoutGET:(id)parameters
   withsuccessBlock:(MKDataBlock)successBlock;
/// 随机生成4位随机数
+(void)randCodeGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 注册接口(new)
+(void)appRegisterPOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 修改密码接口
+(void)resetPasswordPOST:(id)parameters
        withsuccessBlock:(MKDataBlock)successBlock;
/// 发送短信
+(void)sendSmsCodePOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
