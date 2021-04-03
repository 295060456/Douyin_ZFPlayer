//
//  DDNetworkingAPI+UserInfoApi.h
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

///// 绑定手机号 POST
//+(URLManagerModel *)bindPhonePOST;
///// 校验是否有权限 GET
//+(URLManagerModel *)checkHadRoleGET;
///// 系统头像选择
//+(URLManagerModel *)choiceHeadImagePOST;
///// 进行签到 POST
//+(URLManagerModel *)doSignPOST;
///// 系统头像列表 GET
//+(URLManagerModel *)headImageListGET;
///// 邀请好友 POST
//+(URLManagerModel *)userInfoInviteFriendPOST;
///// 邀请任务数据展示 GET
//+(URLManagerModel *)userInfoListGET;
///// 滚动数据 GET
//+(URLManagerModel *)rollDateGET;
///// 获取邀请码接口 POST
//+(URLManagerModel *)userInfoSelectInviteCodePOST;
///// App首页任务界面，查询用户长短视频观影数 POST
//+(URLManagerModel *)userInfoSelectVideoCountPOST;
///// 敏感词列表
//+(URLManagerModel *)userInfoSensitiveListGET;
///// 我的签到列表 GET
//+(URLManagerModel *)signListGET;
///// 用户更新个人信息-昵称-生日-地区  POST
//+(URLManagerModel *)userInfoUpdatePOST;
///// 上传头像 POST
//+(URLManagerModel *)uploadImagePOST;
///// App端查看用户详情 GET
//+(URLManagerModel *)userInfoGET;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserInfoApi)

#pragma mark —— App用户信息相关接口
/// 绑定手机号
+(void)bindPhonePOST:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 校验是否有权限
+(void)checkHadRoleGET:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 系统头像选择
+(void)choiceHeadImagePOST:(id)parameters
              successBlock:(MKDataBlock)successBlock;
/// 进行签到
+(void)doSignPOST:(id)parameters
     successBlock:(MKDataBlock)successBlock;
/// 系统头像列表
+(void)headImageListGET:(id)parameters
           successBlock:(MKDataBlock)successBlock
           failureBlock:(MKDataBlock)failureBlock;
/// 邀请好友
+(void)userInfoInviteFriendPOST:(id)parameters
                   successBlock:(MKDataBlock)successBlock;
/// 邀请任务数据展示
+(void)userInfoListGET:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 滚动数据
+(void)rollDateGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 获取邀请码接口
+(void)userInfoSelectInviteCodePOST:(id)parameters
                       successBlock:(MKDataBlock)successBlock;
/// App首页任务界面，查询用户长短视频观影数
+(void)userInfoSelectVideoCountPOST:(id)parameters
                       successBlock:(MKDataBlock)successBlock;
/// 敏感词列表
+(void)userInfoSensitiveListGET:(id)parameters
                   successBlock:(MKDataBlock)successBlock;
/// 我的签到列表
+(void)signListGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 用户更新个人信息-昵称-生日-地区
+(void)userInfoUpdatePOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 上传头像
+(void)uploadImagePOST:(id)parameters
      uploadImageDatas:(NSMutableArray<UIImage *> *)uploadImageDatas
          successBlock:(MKDataBlock)successBlock
          failureBlock:(MKDataBlock)failureBlock;
/// App端查看用户详情
+(void)userInfoGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
