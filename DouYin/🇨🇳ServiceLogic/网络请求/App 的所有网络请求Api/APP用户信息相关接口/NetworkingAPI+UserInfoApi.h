//
//  NetworkingAPI+UserInfoApi.h
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

@interface NetworkingAPI (UserInfoApi)

#pragma mark —— APP用户信息相关接口
/// 绑定手机号
+(void)bindPhonePOST:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 校验是否有权限
+(void)checkHadRoleGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 进行签到
+(void)doSignPOST:(id)parameters
 withsuccessBlock:(MKDataBlock)successBlock;
/// 获取我的详情
+(void)myUserInfoGET:(id)parameters
    withsuccessBlock:(MKDataBlock)successBlock;
/// 滚动数据
+(void)rollDateGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 查询用户信息
+(void)selectIdCardGET:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 我的签到列表
+(void)signListGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;
/// 编辑个人资料
+(void)userInfoUpdatePOST:(id)parameters
         withsuccessBlock:(MKDataBlock)successBlock;
/// 绑定支付宝
+(void)updateAccountInfoPOST:(id)parameters
            withsuccessBlock:(MKDataBlock)successBlock;
/// 邀请好友
+(void)userInfoUpdateCodePOST:(id)parameters
             withsuccessBlock:(MKDataBlock)successBlock;
/// 上传头像
+(void)uploadImagePOST:(id)parameters
      withsuccessBlock:(MKDataBlock)successBlock;
/// 获取用户详情
+(void)userInfoGET:(id)parameters
  withsuccessBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
