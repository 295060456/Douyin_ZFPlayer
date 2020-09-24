//
//  URL_Manager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP @"http://"
#define append(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]//多参数

NS_ASSUME_NONNULL_BEGIN

@interface URL_Manager : NSObject

+(URL_Manager *)sharedInstance;

-(NSString *)BaseUrl_1;
-(NSString *)BaseUrl_H5;
#pragma mark —— APP登录信息相关接口
///POST找回密码接口-修改密码
-(NSString *)MKLoginChangePasswordPOST;
///POST找回密码接口-身份验证
-(NSString *)MKLoginCheckIdentityPOST;
///POST登录接口
-(NSString *)MkLoginPOST;
///GET退出接口
-(NSString *)MKOutGET;
///GET随机生成4位随机数
-(NSString *)MKLoginRandCodeGET;
///POST注册接口
-(NSString *)MKLoginRegisterPOST;
///POST重置密码接口
-(NSString *)MKLoginResetPasswordPOST;
///POST发送短信
-(NSString *)MKLoginSendSmsCodePOST;
#pragma mark —— App广告相关接口
///GET 查询开屏或视频广告
-(NSString *)MKadInfoAdInfoGET;
#pragma mark —— APP好友关系相关接口
///GET手动执行奖励记录
-(NSString *)MKUserFriendAddAwardInfoGET;
///GET 获取活跃用户
-(NSString *)MKUserFriendAwardListGET;
///GET 最新四个好友
-(NSString *)MKUserFriendFourListGET;
///GET selectUrl
-(NSString *)MKUserFriendSelectUrlGET;
///GET 好友列表
-(NSString *)MKUserFriendListlistGET;
///GET统计我的收益
-(NSString *)MKUserFriendMyInComeGET;
///POST面对面邀请保存好友手机号码
-(NSString *)MKUserFriendsavePhonePOST;
#pragma mark —— APP黑名单相关接口
///POST 添加
-(NSString *)MKBlackAddPOST;
///GET 删除
-(NSString *)MKBlackDeleteGET;
///GET 黑名单列表
-(NSString *)MKBlackListGET;
#pragma mark —— APP获取配置信息
///POST App启动参数
-(NSString *)MKSysInitDataPOST;
#pragma mark —— APP看视频获得金币奖励
///POST首页宝箱奖励
-(NSString *)MKRewardBoxRewardPOST;
///POST首页看视频得抖币奖励
-(NSString *)MKRewardRandomRewardPOST;
///GET首页看视频得抖币配置
-(NSString *)MKRewardRewardSnapshotGET;
///POST首页看视频得抖币配置
-(NSString *)MKRewardRewardSnapshotPOST;
#pragma mark —— APP评论相关接口
///POST 评论视频
-(NSString *)MKCommentVideoPOST;
///POST 删除评论
-(NSString *)MKCommentDelCommentPOST;
///GET 初始化用户评论列表
-(NSString *)MKCommentQueryInitListGET;
///GET 获取评论列表
-(NSString *)MKCommentQueryReplyListGET;
///POST 回复评论
-(NSString *)MKCommentReplyCommentPOST;
///POST 点赞或取消点赞
-(NSString *)MKCommentSetPraisePOST;
#pragma mark —— APP钱包相关接口
///POST 金币兑换
-(NSString *)MKWalletChargeGoldPOST;
///POST 余额兑换会员
-(NSString *)MKWalletChargeVIPPOST;
///GET 获取余额兑换会员类型下拉框
-(NSString *)MKGetToMemTypeGET;
///GET 获取提现兑换类型下拉框
-(NSString *)MKgetWithdrawTypeGET;
///POST 我的钱包流水
-(NSString *)MKWalletMyFlowsPOST;
///POST 获取用户信息
-(NSString *)MKWalletMyWalletPOST;
///POST余额提现
-(NSString *)MKWalletWithdrawBalancePOST;
///GET 获取兑换余额提示
-(NSString *)MKChargeBalanceTipsGET;
#pragma mark —— APP视频相关接口
///POST 删除自己发布的视频
-(NSString *)MKVideosDelAppVideoPOST;
///POST 获取视频信息 videos/getVideo
-(NSString *)MKGetVideoPOST;
///POST 指定用户的视频列表(关注、点赞) 0-关注(默认)，1-喜欢，2-发布的作品
-(NSString *)MKVideosLoadVideosPOST;
///POST 视频点赞or取消
-(NSString *)MKVideosPraiseVideoPOST;
///POST 推荐的视频列表
-(NSString *)MKVideosRecommendVideosPOST;
///POST App 视频上传
-(NSString *)MKVideosUploadVideoAppPOST;
///POST  APP视频上传(临时方案，后面需要app走sdk上传) (仅支持flv/mp4类型) 使用web service
-(NSString *)MKVideoUploadVideoAppTempPOST;
///GET 标签列表
-(NSString *)MKVideosLabelListGET;
///POST 标签列表
-(NSString *)MKVideosLabelListPOST;
#pragma mark —— App消息相关接口
///GET 获取用户粉丝详情
-(NSString *)MKMessageFansInfoGET;
///GET 消息一级列表
-(NSString *)MKMessageList_1_GET;
///GET 获取系统消息详情视频列表
-(NSString *)MKMessageInfoGET;
///GET 消息二级级列表
-(NSString *)MKMessageList_2_GET;
///GET 消息开关列表
-(NSString *)MKmessageTurnOffListGET;
///POST 修改消息开关
-(NSString *)MKmessageUpdateOffPOST;
#pragma mark —— App消息状态相关接口
///POST 添加已读消息
-(NSString *)MKMessageStatusAddPOST;
#pragma mark —— APP银行卡相关接口
///POST 添加银行卡
-(NSString *)MKBankAddPOST;
///GET 获取银行卡信息
-(NSString *)MkBankInfoGET;
///GET 删除
-(NSString *)MKBankDeleteGET;
///GET 银行卡列表
-(NSString *)MKBankListGET;
///POST 修改银行卡
-(NSString *)MKBankUpdatePOST;
#pragma mark —— APP用户粉丝相关接口
///GET 获取用户粉丝详情
-(NSString *)MKUserFansInfoGET;
//GET 我的粉丝列表
-(NSString *)MKUserFansListGET;
///GET 粉丝人视频记录
-(NSString *)MKUserFansSelectFocusListGET;
#pragma mark —— App用户关注相关接口
///POST 添加
-(NSString *)MKUserFocusAddPOST;
///GET 删除
-(NSString *)MKUserFocusDeleteGET;
///GET 获取用户关注详情
-(NSString *)MKUserFocusFocusInfoGET;
///GET 关注用户列表
-(NSString *)MkUserFocusListGET;
///GET 被关注人视频记录
-(NSString *)MKUserFocusSelectFocusListGET;
#pragma mark —— APP用户信息相关接口
///POST绑定手机号
-(NSString *)MKUserInfoBindPhonePOST;
///GET校验是否有权限
-(NSString *)MKUserInfoCheckHadRoleGET;
///POST 进行签到
-(NSString *)MKUserInfoDoSignPOST;
///GET 获取我的详情
-(NSString *)MKuserInfoMyUserInfoGET;
///GET 滚动数据
-(NSString *)MKuserInfoRollDateGET;
///GET 查询用户信息
-(NSString *)MKUserInfoSelectIdCardGET;
///GET 我的签到列表
-(NSString *)MKUserInfoSignListGET;
///POST 编辑个人资料
-(NSString *)MKUserInfoUpdatePOST;
///POST 载入首页
-(NSString *)MkUserInfoLoadHomePagePOST;
///GET 滚动数据
-(NSString *)MKUserInfoRollDateGET;
///POST绑定支付宝
-(NSString *)MKuserInfoUpdateAccountInfoPOST;
///POST 邀请好友
-(NSString *)MKUserInfoUpdateCodePOST;
///POST 上传头像
-(NSString *)MKUserInfoUploadImagePOST;
///GET 获取用户详情
-(NSString *)MKUserInfoGET;
#pragma mark —— H5那一套
/// 帮助中心
-(NSString *)MKH5HelpCenter;
/// 填写邀请码
-(NSString *)MKH5InvitationCode;
/// 邀请好友
-(NSString *)MKH5Invit;
/// 银行卡
-(NSString *)MKH5BankCard;
/// 上传须知
-(NSString *)MKH5UploadNotice;
/// 开屏广告
-(NSString *)MKH5OpenScrennAD;
/// 任务
-(NSString *)MKH5Task;
///
-(NSString *)ImgBaseURL;

@end

NS_ASSUME_NONNULL_END
