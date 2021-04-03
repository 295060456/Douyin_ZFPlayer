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
#pragma mark —— BaseURL
+(NSString *)BaseUrl;
+(NSString *)BaseUrl_H5;
#pragma mark —— 社区相关接口
/// 创作者排行列表 GET
+(URLManagerModel *)creationListGET;
/// 收益排行列表 GET
+(URLManagerModel *)incomeListGET;
/// 人气视频列表 GET
+(URLManagerModel *)popularityVideosGET;
#pragma mark —— 数据统计相关接口
///活跃用户 POST
+(URLManagerModel *)addActiveUserDataPOST;
///启动次数 POST
+(URLManagerModel *)addStartTimePOST;
///使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST;
///渠道列表 GET
+(URLManagerModel *)channelListGET;
/// 播放数据 POST
+(URLManagerModel *)playDataPOST;
///版本信息 GET
+(URLManagerModel *)versionInfoAppGET;
#pragma mark —— App登录信息相关接口
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
#pragma mark —— App广告相关接口
///查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET;
#pragma mark —— App好友关系相关接口
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardGET;
///获取活跃用户 GET
+(URLManagerModel *)awardListGET;
///最新四个好友 GET
+(URLManagerModel *)fourListGET;
///selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET;
///二期好友列表 GET
+(URLManagerModel *)userFriendListGET;
///统计我的收益 GET
+(URLManagerModel *)myInComeGET;
///面对面邀请保存好友手机号码 POST
+(URLManagerModel *)savePhonePOST;
#pragma mark —— App黑名单相关接口
/// 添加 POST
+(URLManagerModel *)blackListAddPOST;
///删除 GET
+(URLManagerModel *)blackListDeleteGET;
///黑名单列表 GET
+(URLManagerModel *)blackListGET;
#pragma mark —— App获取配置信息
///app启动参数 GET
+(URLManagerModel *)refreshGET;
#pragma mark —— App看视频获得金币奖励
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
#pragma mark —— App评论相关接口
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
#pragma mark —— App钱包相关接口
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
/// 我的钱包流水 POST
+(URLManagerModel *)myFlowsPOST;
/// 二期抖币流水 GET
+(URLManagerModel *)myGoldGET;
/// 钱包流水（二期) GET
+(URLManagerModel *)myPurseFlowGET;
/// 获取用户信息 POST
+(URLManagerModel *)myUserWalletPOST;
/// 获取用户信息 POST
+(URLManagerModel *)myWalletPOST;
/// App端转账（转账即可畅玩游戏）POST
+(URLManagerModel *)transferPOST;
/// 包网回调地址 POST
+(URLManagerModel *)transferCallBackPOST;
/// 包网回调校验地址 POST
+(URLManagerModel *)transferVerifyPOST;
/// 余额提现 POST
+(URLManagerModel *)withdrawBalancePOST;
#pragma mark —— App视频相关接口
/// 删除自己发布的视频 POST
+(URLManagerModel *)delAppVideoPOST;
/// 标签列表 GET
+(URLManagerModel *)labelListGET;
/// 我的发布 GET
+(URLManagerModel *)loadVideosGET;
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST;
/// 我的喜欢(0、短视频 1、长视频)  GET
+(URLManagerModel *)myPraiseVideoGET;
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
#pragma mark —— App帖子粉丝相关接口
/// 帖子粉丝用户列表 GET
+(URLManagerModel *)postFansListGET;
#pragma mark —— App帖子关注相关接口
/// 添加 POST
+(URLManagerModel *)postFansListPOST;
/// 删除 GET
+(URLManagerModel *)postFocusDeleteGET;
/// 帖子关注用户列表 GET
+(URLManagerModel *)postFocusListGET;
#pragma mark —— App帖子评论相关接口
/// 评论 GET
+(URLManagerModel *)commentAddPOST;
/// 全部评论列表 GET
+(URLManagerModel *)commentAllListGET;
/// 评论列表 GET
+(URLManagerModel *)commentListGET;
#pragma mark —— App消息相关接口
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET;
/// app公告列表 GET
+(URLManagerModel *)noticeListGET;
/// 消息数量
+(URLManagerModel *)selectMessageNumberGET;
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST;
#pragma mark —— App意见反馈相关接口
/// 意见反馈
+(URLManagerModel *)feedBackAddPOST;
#pragma mark —— App银行卡相关接口
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
#pragma mark —— App用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET;
#pragma mark —— App用户关注相关接口
/// 添加 POST
+(URLManagerModel *)userFocusAddPOST;
/// 删除 GET
+(URLManagerModel *)userFocusDeleteGET;
/// 关注用户列表 GET
+(URLManagerModel *)userFocusListGET;
#pragma mark —— App用户帖子相关接口
/// 发帖 POST
+(URLManagerModel *)postAddPostPOST;
/// 轮播图列表 GET
+(URLManagerModel *)bannerListGET;
/// 评论帖子详情 GET
+(URLManagerModel *)postCommentDetailInfoGET;
/// 删除帖子 POST
+(URLManagerModel *)delPostPOST;
/// 用户帖子详情 GET
+(URLManagerModel *)postDetailInfoGET;
/// 帖子列表 GET
+(URLManagerModel *)postListGET;
/// 帖子我的(关注、点赞.发布) GET
+(URLManagerModel *)postMyPostGET;
/// 帖子详情 GET
+(URLManagerModel *)postInfoGET;
/// 点赞 POST
+(URLManagerModel *)postPraisePostPOST;
/// 查询环体下载地址 GET
+(URLManagerModel *)selectDowndSettingGET;
/// 帖子图片上传 POST
+(URLManagerModel *)postUploadImagePOST;
/// 帖子视频上传 POST
+(URLManagerModel *)postuploadVideoPOST;
/// 用户详情  GET
+(URLManagerModel *)postUserInfoGET;
/// 用户帖子列表 GET
+(URLManagerModel *)userPostListGET;
#pragma mark —— App用户信息相关接口
/// 绑定手机号 POST
+(URLManagerModel *)bindPhonePOST;
/// 校验是否有权限 GET
+(URLManagerModel *)checkHadRoleGET;
/// 系统头像选择
+(URLManagerModel *)choiceHeadImagePOST;
/// 进行签到 POST
+(URLManagerModel *)doSignPOST;
/// 系统头像列表 GET
+(URLManagerModel *)headImageListGET;
/// 邀请好友 POST
+(URLManagerModel *)userInfoInviteFriendPOST;
/// 邀请任务数据展示 GET
+(URLManagerModel *)userInfoListGET;
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET;
/// 获取邀请码接口 POST
+(URLManagerModel *)userInfoSelectInviteCodePOST;
/// App首页任务界面，查询用户长短视频观影数 POST
+(URLManagerModel *)userInfoSelectVideoCountPOST;
/// 敏感词列表
+(URLManagerModel *)userInfoSensitiveListGET;
/// 我的签到列表 GET
+(URLManagerModel *)signListGET;
/// 用户更新个人信息-昵称-生日-地区  POST
+(URLManagerModel *)userInfoUpdatePOST;
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST;
/// App端查看用户详情 GET
+(URLManagerModel *)userInfoGET;
#pragma mark —— App vip相关接口
/// 开通vip GET
+(URLManagerModel *)vipApplyGET;
/// 查询全部会员等级权益列表 GET
+(URLManagerModel *)vipListGET;
/// 用户开通会员之后，查询当前会员等级权益 GET
+(URLManagerModel *)vipSelfGET;

@end

NS_ASSUME_NONNULL_END

