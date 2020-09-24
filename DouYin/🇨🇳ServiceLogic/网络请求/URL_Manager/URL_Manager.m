//
//  URL_Manager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "URL_Manager.h"

@implementation URL_Manager

#pragma mark —— 基础配置
static URL_Manager *static_URL_Manager = nil;
+(URL_Manager *)sharedInstance{
    @synchronized(self){
        if (!static_URL_Manager) {
            static_URL_Manager = URL_Manager.new;
        }
    }return static_URL_Manager;
}

-(NSString *)BaseUrl_1{

//    return append(@"%@%@",HTTP,@"www.11wy.top/api");//线上服务 发布;
//    return append(@"%@%@",HTTP,@"www.11wy.top:8011");//线上服务 调试;
//    return append(@"%@%@",HTTP,@"172.24.135.204:8011");//测试服务专线 （禁止使用）
    return append(@"%@%@",HTTP,@"172.24.135.209:8011");//开发服务;
//    return append(@"%@%@",HTTP,@"146.196.78.142:10007");//cong线上服务 调试;
//    return append(@"%@%@",HTTP,@"172.24.135.204:8011/");// muyu
}

-(NSString *)BaseUrl_H5{
//    return append(@"%@%@",HTTP,@"172.24.135.208");//测试服务 专线 （禁止使用）
    return append(@"%@%@",HTTP,@"172.24.135.209");//开发服务
//    return append(@"%@%@",HTTP,@"www.11wy.top");//线上服务 发布 | 调试;
//    return append(@"%@%@",HTTP,@"146.196.78.142:10006");//cong线上服务 调试;
//    return append(@"%@%@",HTTP,@"172.24.137.29");//muyu
    //    return append(@"%@%@",HTTP,@"www.11wy.top");//线上服务 发布 | 调试;
    //    return append(@"%@%@",HTTP,@"172.24.136.31:8012");
}
#pragma mark —— APP登录信息相关接口
///POST找回密码接口-修改密码
-(NSString *)MKLoginChangePasswordPOST{
    return @"/app/login/changePassword";
}
///POST找回密码接口-身份验证
-(NSString *)MKLoginCheckIdentityPOST{
    return @"/app/login/checkIdentity";
}
///POST登录接口
-(NSString *)MkLoginPOST{
    return @"/app/login/login";
}
///GET退出接口
-(NSString *)MKOutGET{
    return @"/app/login/out";
}
///GET随机生成4位随机数
-(NSString *)MKLoginRandCodeGET{
    return @"/app/login/randCode";
}
///POST注册接口
-(NSString *)MKLoginRegisterPOST{
    return @"/app/login/register";
}
///POST重置密码接口
-(NSString *)MKLoginResetPasswordPOST{
    return @"/app/login/resetPassword";
}
///POST发送短信
-(NSString *)MKLoginSendSmsCodePOST{
    return @"/app/login/sendSmsCode";
}
#pragma mark —— App广告相关接口
///GET 查询开屏或视频广告
-(NSString *)MKadInfoAdInfoGET{
    return @"/app/adInfo/adInfo";
}
#pragma mark —— APP好友关系相关接口
///GET手动执行奖励记录
-(NSString *)MKUserFriendAddAwardInfoGET{
    return @"/app/userFriend/addAwardInfo";
}
///GET 获取活跃用户
-(NSString *)MKUserFriendAwardListGET{
    return @"/app/userFriend/awardList";
}
///GET 最新四个好友
-(NSString *)MKUserFriendFourListGET{
    return @"/app/userFriend/fourList";
}
///GET selectUrl
-(NSString *)MKUserFriendSelectUrlGET{
    return @"/app/userFriend/friendUrl";
}
///GET 好友列表
-(NSString *)MKUserFriendListlistGET{
    return @"/app/userFriend/list";
}
///GET统计我的收益
-(NSString *)MKUserFriendMyInComeGET{
    return @"/app/userFriend/myInCome";
}
///POST面对面邀请保存好友手机号码
-(NSString *)MKUserFriendsavePhonePOST{
    return @"/app/userFriend/savePhone";
}
#pragma mark —— APP黑名单相关接口
///POST 添加
-(NSString *)MKBlackAddPOST{
    return @"/app/black/add";
}
///GET 删除
-(NSString *)MKBlackDeleteGET{
    return @"/app/black/delete";
}
///GET 黑名单列表
-(NSString *)MKBlackListGET{
    return @"/app/black/list";
}
#pragma mark —— APP获取配置信息
///POST App启动参数
-(NSString *)MKSysInitDataPOST{
    return @"/app/sys/initData";
}
#pragma mark —— APP看视频获得金币奖励
///POST首页宝箱奖励
-(NSString *)MKRewardBoxRewardPOST{
    return @"/app/reward/boxReward";
}
///POST首页看视频得抖币奖励
-(NSString *)MKRewardRandomRewardPOST{
    return @"/app/reward/randomReward";
}
///GET首页看视频得抖币配置
-(NSString *)MKRewardRewardSnapshotGET{
    return @"/app/reward/rewardSnapshot";
}
///POST首页看视频得抖币配置
-(NSString *)MKRewardRewardSnapshotPOST{
    return @"/app/reward/rewardSnapshot";
}
#pragma mark —— APP评论相关接口
///POST 评论视频
-(NSString *)MKCommentVideoPOST{
    return @"/app/comment/commentVideo";
}
///POST 删除评论
-(NSString *)MKCommentDelCommentPOST{
    return @"/app/comment/delComment";
}
///GET 初始化用户评论列表
-(NSString *)MKCommentQueryInitListGET{
    return @"/app/comment/queryInitList";
}
///GET 获取评论列表
-(NSString *)MKCommentQueryReplyListGET{
    return @"/app/comment/queryReplyList";
}
///POST 回复评论
-(NSString *)MKCommentReplyCommentPOST{
    return @"/app/comment/replyComment";
}
///POST 点赞或取消点赞
-(NSString *)MKCommentSetPraisePOST{
    return @"/app/comment/setPraise";
}
#pragma mark —— APP钱包相关接口
///POST 金币兑换
-(NSString *)MKWalletChargeGoldPOST{
    return @"/app/wallet/chargeGold";
}
///POST 余额兑换会员
-(NSString *)MKWalletChargeVIPPOST{
    return @"/app/wallet/chargeVIP";
}
///GET 获取余额兑换会员类型下拉框
-(NSString *)MKGetToMemTypeGET{
    return @"/app/wallet/getToMemType";
}
///GET 获取提现兑换类型下拉框
-(NSString *)MKgetWithdrawTypeGET{
    return @"/app/wallet/getWithdrawType";
}
///POST 我的钱包流水
-(NSString *)MKWalletMyFlowsPOST{
    return @"/app/wallet/myFlows";
}
///POST 获取用户信息
-(NSString *)MKWalletMyWalletPOST{
    return @"/app/wallet/myWallet";
}
///GET 获取兑换余额提示
-(NSString *)MKChargeBalanceTipsGET{
    return @"/app/wallet/chargeBalanceTips";
}
///POST余额提现
-(NSString *)MKWalletWithdrawBalancePOST{
    return @"/app/wallet/withdrawBalance";
}
#pragma mark —— APP视频相关接口
///POST 删除自己发布的视频
-(NSString *)MKVideosDelAppVideoPOST{
    return @"/app/videos/delAppVideo";
}
///POST 获取视频信息 videos/getVideo
-(NSString *)MKGetVideoPOST{
    return @"/app/videos/getVideo";
}
///POST 指定用户的视频列表(关注、点赞) 0-关注(默认)，1-喜欢，2-发布的作品
-(NSString *)MKVideosLoadVideosPOST{//
    return @"/app/videos/loadVideos";
}
///POST 视频点赞or取消
-(NSString *)MKVideosPraiseVideoPOST{//
    return @"/app/videos/praiseVideo";
}
///POST 推荐的视频列表
-(NSString *)MKVideosRecommendVideosPOST{//
    return @"/app/videos/recommendVideos";
}
///POST App 视频上传
-(NSString *)MKVideosUploadVideoAppPOST{
    return @"/app/videos/uploadVideoAPP";
}
///POST  APP视频上传(临时方案，后面需要app走sdk上传) (仅支持flv/mp4类型) 使用web service
-(NSString *)MKVideoUploadVideoAppTempPOST{
    return @"/app/videos/uploadVideoAPPTemp";
}
///GET 标签列表
-(NSString *)MKVideosLabelListGET{
    return @"/app/videos/videoLabelList";
}
///POST 标签列表
-(NSString *)MKVideosLabelListPOST{
    return @"/app/videos/videoLabelList";
}
#pragma mark —— App消息相关接口
///GET 获取用户粉丝详情
-(NSString *)MKMessageFansInfoGET{
    return @"/app/message/fansInfo";
}
///GET 消息一级列表
-(NSString *)MKMessageList_1_GET{
    return @"/app/message/list";
}
///GET 获取系统消息详情视频列表
-(NSString *)MKMessageInfoGET{
    return @"/app/message/messageInfo";
}
///GET 消息二级级列表
-(NSString *)MKMessageList_2_GET{
    return @"/app/message/messageList";
}
///GET 消息开关列表
-(NSString *)MKmessageTurnOffListGET{
    return @"/app/message/turnOffList";
}
///POST 修改消息开关
-(NSString *)MKmessageUpdateOffPOST{
    return @"/app/message/updateOff";
}
#pragma mark —— App消息状态相关接口
///POST 添加已读消息
-(NSString *)MKMessageStatusAddPOST{
    return @"/app/messageStatus/add";
}
#pragma mark —— APP银行卡相关接口
///POST 添加银行卡
-(NSString *)MKBankAddPOST{
    return @"/app/bank/add";
}
///GET 获取银行卡信息
-(NSString *)MkBankInfoGET{
    return @"/app/bank/bankInfo";
}
///GET 删除
-(NSString *)MKBankDeleteGET{
    return @"/app/bank/delete";
}
///GET 银行卡列表
-(NSString *)MKBankListGET{
    return @"/app/bank/list";
}
///POST 修改银行卡
-(NSString *)MKBankUpdatePOST{
    return @"/app/bank/update";
}
#pragma mark —— APP用户粉丝相关接口
///GET 获取用户粉丝详情
-(NSString *)MKUserFansInfoGET{
    return @"/app/userFans/fansInfo";
}
//GET 我的粉丝列表
-(NSString *)MKUserFansListGET{
    return @"/app/userFans/list";
}
///GET 粉丝人视频记录
-(NSString *)MKUserFansSelectFocusListGET{
    return @"/app/userFans/selectFocusList";
}
#pragma mark —— App用户关注相关接口
///POST 添加
-(NSString *)MKUserFocusAddPOST{
    return @"/app/userFocus/add";
}
///GET 删除
-(NSString *)MKUserFocusDeleteGET{
    return @"/app/userFocus/delete";
}
///GET 获取用户关注详情
-(NSString *)MKUserFocusFocusInfoGET{
    return @"/app/userFocus/focusInfo";
}
///GET 关注用户列表
-(NSString *)MkUserFocusListGET{
    return @"/app/userFocus/list";
}
///GET 被关注人视频记录
-(NSString *)MKUserFocusSelectFocusListGET{
    return @"/app/userFocus/selectFocusList";
}
#pragma mark —— APP用户信息相关接口
///POST绑定手机号
-(NSString *)MKUserInfoBindPhonePOST{
    return @"/app/userInfo/bindPhone";
}
///GET校验是否有权限
-(NSString *)MKUserInfoCheckHadRoleGET{
    return @"/app/userInfo/checkHadRole";
}
///POST 进行签到
-(NSString *)MKUserInfoDoSignPOST{
    return @"/app/userInfo/doSign";
}
///GET 获取我的详情
-(NSString *)MKuserInfoMyUserInfoGET{
    return @"/app/userInfo/myUserInfo";
}
///GET 滚动数据
-(NSString *)MKuserInfoRollDateGET{
    return @"/app/userInfo/rollDate";
}
///GET 查询用户信息
-(NSString *)MKUserInfoSelectIdCardGET{
    return @"/app/userInfo/selectIdCard";
}
///GET 我的签到列表
-(NSString *)MKUserInfoSignListGET{
    return @"/app/userInfo/signList";
}
///POST 编辑个人资料
-(NSString *)MKUserInfoUpdatePOST{
    return @"/app/userInfo/update";
}
///POST 载入首页
-(NSString *)MkUserInfoLoadHomePagePOST{
    return @"/app/userInfo/loadHomePage";
}
///GET 滚动数据
-(NSString *)MKUserInfoRollDateGET{
    return @"/app/userInfo/rollDate";
}
///POST绑定支付宝
-(NSString *)MKuserInfoUpdateAccountInfoPOST{
    return @"/app/userInfo/updateAccountInfo";
}
///POST 邀请好友
-(NSString *)MKUserInfoUpdateCodePOST{
    return @"/app/userInfo/updateCode";
}
///POST 上传头像
-(NSString *)MKUserInfoUploadImagePOST{
    return @"/app/userInfo/uploadImage";
}
///GET 获取用户详情
-(NSString *)MKUserInfoGET{
    return @"/app/userInfo/userInfo";
}
#pragma mark —— H5那一套
/// 帮助中心
-(NSString *)MKH5HelpCenter{
    return @"/taskpage/#/helpCenter"; 
}
/// 填写邀请码
-(NSString *)MKH5InvitationCode{
    return @"/taskpage/#/invitationcode";
}
/// 邀请好友
-(NSString *)MKH5Invit{
    return @"/taskpage/#/invit";
}
/// 银行卡
-(NSString *)MKH5BankCard{
    return @"/taskpage/#/bandcard";
}
/// 上传须知
-(NSString *)MKH5UploadNotice{
    return @"/taskpage/#/uolodNotice";
}
/// 开屏广告
-(NSString *)MKH5OpenScrennAD{
    return @"/taskpage/#/adverti";
}
/// 任务
-(NSString *)MKH5Task{
    return @"/taskpage/#/task";
}
///
-(NSString *)ImgBaseURL{
    return @"";
}

@end
