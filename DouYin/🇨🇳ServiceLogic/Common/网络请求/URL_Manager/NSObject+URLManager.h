//
//  NSObject+URLManager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLManagerModel.h"

#define HTTP @"http://"
#define append(fmt, ...) [self append:[URLManagerModel stringWithFormat:fmt, ##__VA_ARGS__]]//多参数

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (URLManager)
/*
 各种环境的地址 和 接口文档地址 在这里写，方便调用
 
 */
#pragma mark —— BaseURL
+(NSString *)BaseUrl_1;
+(NSString *)BaseUrl_H5;
#pragma mark —— 数据统计相关接口
///活跃用户 POST
+(URLManagerModel *)addActiveUserDataPOST;
///启动次数 POST
+(URLManagerModel *)addStartTimePOST;
///使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST;
///渠道列表 GET
+(URLManagerModel *)channelListGET;
///版本信息 GET
+(URLManagerModel *)versionInfoAppGET;
#pragma mark —— APP登录信息相关接口
///找回密码接口-重置密码 POST
+(URLManagerModel *)changePasswordPOST;
///找回密码接口-身份验证 POST
+(URLManagerModel *)checkIdentityPOST;
///登录接口 POST
+(URLManagerModel *)appLoginPOST;
///退出接口 GET
+(URLManagerModel *)appLogoutGET;
///随机生成4位随机数 GET
+(URLManagerModel *)randCodeGET;
///注册接口(new) POST
+(URLManagerModel *)appRegisterPOST;
///修改密码接口 POST
+(URLManagerModel *)resetPasswordPOST;
///发送短信 POST
+(URLManagerModel *)sendSmsCodePOST;
#pragma mark —— APP广告相关接口
///查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET;
#pragma mark —— APP好友关系相关接口
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardGET;
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardInfoGET;
///获取活跃用户 GET
+(URLManagerModel *)awardListGET;
///最新四个好友 GET
+(URLManagerModel *)fourListGET;
///selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET;
///好友列表 GET
+(URLManagerModel *)userFriendListGET;
///统计我的收益 GET
+(URLManagerModel *)myInComeGET;
///面对面邀请保存好友手机号码 POST
+(URLManagerModel *)savePhonePOST;
#pragma mark —— APP黑名单相关接口
/// 添加 POST
+(URLManagerModel *)blackListAddPOST;
///删除 GET
+(URLManagerModel *)blackListDeleteGET;
///黑名单列表 GET
+(URLManagerModel *)blackListGET;
#pragma mark —— APP获取配置信息
///app启动参数 POST
+(URLManagerModel *)initializePOST;
#pragma mark —— APP看视频获得金币奖励
/// 首页宝箱奖励 POST
+(URLManagerModel *)boxRewardPOST;
/// 抖币领取开关 GET
+(URLManagerModel *)goldSwitchGET;
/// 抖币领取开关 POST
+(URLManagerModel *)goldSwitchPOST;
/// 首页看视频得抖币奖励 POST
+(URLManagerModel *)randomRewardPOST;
/// 首页看视频得抖币配置 GET
+(URLManagerModel *)rewardSnapshotGET;
/// 首页看视频得抖币配置 POST
+(URLManagerModel *)rewardSnapshotPOST;
#pragma mark —— APP评论相关接口
/// 评论视频 POST
+(URLManagerModel *)commentVideoPOST;
/// 删除评论 POST
+(URLManagerModel *)delCommentPOST;
/// 初始化用户评论列表 GET
+(URLManagerModel *)queryInitListGET;
/// 获取回复列表 GET
+(URLManagerModel *)queryReplyListGET;
/// 回复评论 POST
+(URLManagerModel *)replyCommentPOST;
/// 点赞或取消点赞 POST
+(URLManagerModel *)setPraisePOST;
#pragma mark —— APP钱包相关接口
/// 抖币兑换余额提示 GET
+(URLManagerModel *)chargeBalanceTipsGET;
/// 金币兑换 POST
+(URLManagerModel *)chargeGoldPOST;
/// 余额兑换会员 POST
+(URLManagerModel *)chargeVipPOST;
/// 获取余额兑换会员类型下拉框 GET
+(URLManagerModel *)getToMemTypeGET;
/// 获取提现兑换类型下拉框 GET
+(URLManagerModel *)getWithdrawTypeGET;
/// 我的钱包流水 GET
+(URLManagerModel *)myFlowsGET;
/// 获取用户信息 POST
+(URLManagerModel *)myWalletPOST;
/// 余额提现 POST
+(URLManagerModel *)withdrawBalancePOST;
#pragma mark —— APP视频相关接口
/// 删除自己发布的视频 POST
+(URLManagerModel *)delAppVideoPOST;
/// 标签列表 GET
+(URLManagerModel *)labelListGET;
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST;
/// 视频点赞or取消 POST
+(URLManagerModel *)praiseVideoPOST;
/// 生成上传链接 POST
+(URLManagerModel *)presignedUploadUrlPOST;
/// 推荐的视频列表 POST
+(URLManagerModel *)recommendVideosPOST;
/// 搜索视频 POST
+(URLManagerModel *)searchPOST;
/// 上传视频 POST
+(URLManagerModel *)uploadVideoPOST;
#pragma mark —— App消息相关接口
/// 获取用户粉丝详情 GET
+(URLManagerModel *)fansInfoGET;
/// 消息一级列表 GET
+(URLManagerModel *)messageFirstClassListGET;
/// 获取系统消息详情视频列表 GET
+(URLManagerModel *)messageInfoGET;
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET;
/// 公告列表 GET
+(URLManagerModel *)noticeListappGET;
/// 消息开关列表 GET
+(URLManagerModel *)turnOffListGET;
/// 修改消息开关 POST
+(URLManagerModel *)updateOffPOST;
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST;
#pragma mark —— APP银行卡相关接口
/// 添加银行卡 POST
+(URLManagerModel *)bankAddPOST;
/// 获取银行卡信息 GET
+(URLManagerModel *)bankInfoGET;
/// 删除 GET
+(URLManagerModel *)bankDeleteGET;
/// 银行卡列表 GET
+(URLManagerModel *)bankListGET;
/// 修改银行卡 POST
+(URLManagerModel *)bankUpdatePOST;
#pragma mark —— APP用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET;
#pragma mark —— APP用户关注相关接口
/// 添加 POST
+(URLManagerModel *)userFocusAddPOST;
/// 删除 GET
+(URLManagerModel *)userFocusDeleteGET;
/// 关注用户列表 GET
+(URLManagerModel *)userFocusListGET;
#pragma mark —— APP用户信息相关接口
/// 绑定手机号 POST
+(URLManagerModel *)bindPhonePOST;
/// 校验是否有权限 GET
+(URLManagerModel *)checkHadRoleGET;
/// 进行签到 POST
+(URLManagerModel *)doSignPOST;
/// 获取我的详情 GET
+(URLManagerModel *)myUserInfoGET;
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET;
/// 查询用户信息 GET
+(URLManagerModel *)selectIdCardGET;
/// 我的签到列表 GET
+(URLManagerModel *)signListGET;
/// 编辑个人资料 POST
+(URLManagerModel *)userInfoUpdatePOST;
/// 绑定支付宝 POST
+(URLManagerModel *)updateAccountInfoPOST;
/// 邀请好友 POST
+(URLManagerModel *)userInfoUpdateCode;
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST;
/// 获取用户详情 GET
+(URLManagerModel *)userInfoGET;

@end

NS_ASSUME_NONNULL_END

