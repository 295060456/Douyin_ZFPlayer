//
//  DDNetworkingAPI+LoginApi.h
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

/////找回密码接口-重置密码 POST
//+(URLManagerModel *)changePasswordPOST;
/////找回密码接口-身份验证 POST
//+(URLManagerModel *)checkIdentityPOST;
/////登录接口 POST
//+(URLManagerModel *)appLoginPOST;
/////退出接口 GET
//+(URLManagerModel *)appLogoutGET;
/////随机生成4位随机数 GET
//+(URLManagerModel *)randCodeGET;
/////注册接口(new) POST
//+(URLManagerModel *)appRegisterPOST;
/////修改密码接口 POST
//+(URLManagerModel *)resetPasswordPOST;
/////发送短信 POST
//+(URLManagerModel *)sendSmsCodePOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (LoginApi)

#pragma mark —— App登录信息相关接口
/// 找回密码接口-重置密码
+(void)changePasswordPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 找回密码接口-身份验证
+(void)checkIdentityPOST:(id)parameters
            successBlock:(MKDataBlock)successBlock;
/// 登录
+(void)appLoginPOST:(id)parameters
       successBlock:(MKDataBlock)successBlock;
/// 退出
+(void)appLogoutGET:(id)parameters
       successBlock:(MKDataBlock)successBlock;
/// 随机生成4位随机数
+(void)randCodeGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 注册接口(new)
+(void)appRegisterPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 修改密码接口
+(void)resetPasswordPOST:(id)parameters
            successBlock:(MKDataBlock)successBlock;
/// 发送短信
+(void)sendSmsCodePOST:(id)parameters
          successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
