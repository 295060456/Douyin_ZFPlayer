//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

/// 柬埔寨（主要）开发环境
BOOL DevEnviron_Cambodia_Main = YES;
///// 柬埔寨（次要）开发环境
BOOL DevEnviron_Cambodia_Minor = NO;
/// 柬埔寨Rally（次要）开发环境
BOOL DevEnviron_Cambodia_Rally = NO;
/// 中国大陆开发环境
BOOL DevEnviron_China_Mainland = NO;
/// 测试环境
BOOL TestEnviron = NO;
/// 生产环境
BOOL ProductEnviron = NO;

@implementation NSObject (URLManager)
/*
 各种环境的地址 和 接口文档地址 在这里写，方便调用
 
 */
+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl_1{
    if (DevEnviron_Cambodia_Main) {
        /// 柬埔寨（主要）开发环境
        return @"http://172.24.135.53:8011/";
    }else if(DevEnviron_Cambodia_Minor){
        /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
        return @"";
    }else if (DevEnviron_Cambodia_Rally){
        /// 柬埔寨Rally（次要）开发环境
        return @"";
    }else if (DevEnviron_China_Mainland){
        /// 中国大陆开发环境
        return @"";
    }else if (TestEnviron){
        /// 测试环境
        return @"";
    }else if (ProductEnviron){
        /// 生产环境
        return @"";
    }else{
        return @"";
    }
}

+(NSString *)BaseUrl_H5{
    if (DevEnviron_Cambodia_Main) {
        /// 柬埔寨（主要）开发环境
        return @"";
    }else if (DevEnviron_Cambodia_Minor){
        /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
        return @"";
    }else if (DevEnviron_Cambodia_Rally){
        /// 柬埔寨Rally（次要）开发环境
        return @"";
    }else if (DevEnviron_China_Mainland){
        /// 中国大陆开发环境
        return @"";
    }else if (TestEnviron){
        /// 测试环境
        return @"";
    }else if (ProductEnviron){
        /// 生产环境
        return @"";
    }else{
        return @"";
    }
}
#pragma mark —— 数据统计相关接口
///活跃用户 POST
+(URLManagerModel *)addActiveUserDataPOST{
    return [NSObject url:@"app/statistics/addActiveUserData"
                funcName:NSStringFromSelector(_cmd)];
}
///启动次数 POST
+(URLManagerModel *)addStartTimePOST{
    return [NSObject url:@"app/statistics/addStartTime"
                funcName:NSStringFromSelector(_cmd)];
}
///使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST{
    return [NSObject url:@"app/statistics/addUseTimeData"
                funcName:NSStringFromSelector(_cmd)];
}
///渠道列表 GET
+(URLManagerModel *)channelListGET{
    return [NSObject url:@"app/statistics/channelList"
                funcName:NSStringFromSelector(_cmd)];
}
///版本信息 GET
+(URLManagerModel *)versionInfoAppGET{
    return [NSObject url:@"app/statistics/versionInfoapp"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP登录信息相关接口
///找回密码接口-重置密码 POST
+(URLManagerModel *)changePasswordPOST{
    return [NSObject url:@"app/login/changePassword"
                funcName:NSStringFromSelector(_cmd)];
}
///找回密码接口-身份验证 POST
+(URLManagerModel *)checkIdentityPOST{
    return [NSObject url:@"app/login/checkIdentity"
                funcName:NSStringFromSelector(_cmd)];
}
///登录接口 POST
+(URLManagerModel *)appLoginPOST{
    return [NSObject url:@"app/login/login"
                funcName:NSStringFromSelector(_cmd)];
}
///退出接口 GET
+(URLManagerModel *)appLogoutGET{
    return [NSObject url:@"app/login/out"
                funcName:NSStringFromSelector(_cmd)];
}
///随机生成4位随机数 GET
+(URLManagerModel *)randCodeGET{
    return [NSObject url:@"app/login/randCode"
                funcName:NSStringFromSelector(_cmd)];
}
///注册接口(new) POST
+(URLManagerModel *)appRegisterPOST{
    return [NSObject url:@"app/login/register"
                funcName:NSStringFromSelector(_cmd)];
}
///修改密码接口 POST
+(URLManagerModel *)resetPasswordPOST{
    return [NSObject url:@"app/login/resetPassword"
                funcName:NSStringFromSelector(_cmd)];
}
///发送短信 POST
+(URLManagerModel *)sendSmsCodePOST{
    return [NSObject url:@"app/login/sendSmsCode"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP广告相关接口
///查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET{
    return [NSObject url:@"app/adInfo/adInfo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP好友关系相关接口
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardGET{
    return [NSObject url:@"app/userFriend/addAward"
                funcName:NSStringFromSelector(_cmd)];
}
///手动执行奖励记录 GET
+(URLManagerModel *)addAwardInfoGET{
    return [NSObject url:@"app/userFriend/addAwardInfo"
                funcName:NSStringFromSelector(_cmd)];
}
///获取活跃用户 GET
+(URLManagerModel *)awardListGET{
    return [NSObject url:@"app/userFriend/awardList"
                funcName:NSStringFromSelector(_cmd)];
}
///最新四个好友 GET
+(URLManagerModel *)fourListGET{
    return [NSObject url:@"app/userFriend/fourList"
                funcName:NSStringFromSelector(_cmd)];
}
///selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET{
    return [NSObject url:@"app/userFriend/friendUrl"
                funcName:NSStringFromSelector(_cmd)];
}
///好友列表 GET
+(URLManagerModel *)userFriendListGET{
    return [NSObject url:@"app/userFriend/list"
                funcName:NSStringFromSelector(_cmd)];
}
///统计我的收益 GET
+(URLManagerModel *)myInComeGET{
    return [NSObject url:@"app/userFriend/myInCome"
                funcName:NSStringFromSelector(_cmd)];
}
///面对面邀请保存好友手机号码 POST
+(URLManagerModel *)savePhonePOST{
    return [NSObject url:@"app/userFriend/savePhone"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP黑名单相关接口
/// 添加 POST
+(URLManagerModel *)blackListAddPOST{
    return [NSObject url:@"app/black/add"
                funcName:NSStringFromSelector(_cmd)];
}
///删除 GET
+(URLManagerModel *)blackListDeleteGET{
    return [NSObject url:@"app/black/delete"
                funcName:NSStringFromSelector(_cmd)];
}
///黑名单列表 GET
+(URLManagerModel *)blackListGET{
    return [NSObject url:@"app/black/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP获取配置信息
///app启动参数 POST
+(URLManagerModel *)initializePOST{
    return [NSObject url:@"app/sys/initialize"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP看视频获得金币奖励
/// 首页宝箱奖励 POST
+(URLManagerModel *)boxRewardPOST{
    return [NSObject url:@"app/reward/boxReward"
                funcName:NSStringFromSelector(_cmd)];
}
/// 抖币领取开关 GET
+(URLManagerModel *)goldSwitchGET{
    return [NSObject url:@"app/reward/goldSwitch"
                funcName:NSStringFromSelector(_cmd)];
}
/// 抖币领取开关 POST
+(URLManagerModel *)goldSwitchPOST{
    return [NSObject url:@"app/reward/goldSwitch"
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币奖励 POST
+(URLManagerModel *)randomRewardPOST{
    return [NSObject url:@"app/reward/randomReward"
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币配置 GET
+(URLManagerModel *)rewardSnapshotGET{
    return [NSObject url:@"app/reward/rewardSnapshot"
                funcName:NSStringFromSelector(_cmd)];
}
/// 首页看视频得抖币配置 POST
+(URLManagerModel *)rewardSnapshotPOST{
    return [NSObject url:@"app/reward/rewardSnapshot"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP评论相关接口
/// 评论视频 POST
+(URLManagerModel *)commentVideoPOST{
    return [NSObject url:@"app/comment/commentVideo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除评论 POST
+(URLManagerModel *)delCommentPOST{
    return [NSObject url:@"app/comment/delComment"
                funcName:NSStringFromSelector(_cmd)];
}
/// 初始化用户评论列表 GET
+(URLManagerModel *)queryInitListGET{
    return [NSObject url:@"app/comment/queryInitListGET"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取回复列表 GET
+(URLManagerModel *)queryReplyListGET{
    return [NSObject url:@"app/comment/queryReplyList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 回复评论 POST
+(URLManagerModel *)replyCommentPOST{
    return [NSObject url:@"app/comment/replyComment"
                funcName:NSStringFromSelector(_cmd)];
}
/// 点赞或取消点赞 POST
+(URLManagerModel *)setPraisePOST{
    return [NSObject url:@"app/comment/setPraise"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP钱包相关接口
/// 抖币兑换余额提示 GET
+(URLManagerModel *)chargeBalanceTipsGET{
    return [NSObject url:@"app/wallet/chargeBalanceTips"
                funcName:NSStringFromSelector(_cmd)];
}
/// 金币兑换 POST
+(URLManagerModel *)chargeGoldPOST{
    return [NSObject url:@"app/wallet/chargeGold"
                funcName:NSStringFromSelector(_cmd)];
}
/// 余额兑换会员 POST
+(URLManagerModel *)chargeVipPOST{
    return [NSObject url:@"app/wallet/chargeVIP"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取余额兑换会员类型下拉框 GET
+(URLManagerModel *)getToMemTypeGET{
    return [NSObject url:@"app/wallet/getToMemType"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取提现兑换类型下拉框 GET
+(URLManagerModel *)getWithdrawTypeGET{
    return [NSObject url:@"app/wallet/getWithdrawType"
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的钱包流水 GET
+(URLManagerModel *)myFlowsGET{
    return [NSObject url:@"app/wallet/myFlows"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户信息 POST
+(URLManagerModel *)myWalletPOST{
    return [NSObject url:@"app/wallet/myWallet"
                funcName:NSStringFromSelector(_cmd)];
}
/// 余额提现 POST
+(URLManagerModel *)withdrawBalancePOST{
    return [NSObject url:@"app/wallet/withdrawBalance"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP视频相关接口
/// 删除自己发布的视频 POST
+(URLManagerModel *)delAppVideoPOST{
    return [NSObject url:@"app/videos/delAppVideo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 标签列表 GET
+(URLManagerModel *)labelListGET{
    return [NSObject url:@"app/videos/labelList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST{
    return [NSObject url:@"app/videos/loadVideos"
                funcName:NSStringFromSelector(_cmd)];
}
/// 视频点赞or取消 POST
+(URLManagerModel *)praiseVideoPOST{
    return [NSObject url:@"app/videos/praiseVideo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 生成上传链接 POST
+(URLManagerModel *)presignedUploadUrlPOST{
    return [NSObject url:@"app/videos/presignedUploadUrl"
                funcName:NSStringFromSelector(_cmd)];
}
/// 推荐的视频列表 POST
+(URLManagerModel *)recommendVideosPOST{
    return [NSObject url:@"app/videos/recommendVideos"
                funcName:NSStringFromSelector(_cmd)];
}
/// 搜索视频 POST
+(URLManagerModel *)searchPOST{
    return [NSObject url:@"app/videos/search"
                funcName:NSStringFromSelector(_cmd)];
}
/// 上传视频 POST
+(URLManagerModel *)uploadVideoPOST{
    return [NSObject url:@"app/videos/uploadVideo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息相关接口
/// 获取用户粉丝详情 GET
+(URLManagerModel *)fansInfoGET{
    return [NSObject url:@"app/message/fansInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息一级列表 GET
+(URLManagerModel *)messageFirstClassListGET{
    return [NSObject url:@"app/message/list"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取系统消息详情视频列表 GET
+(URLManagerModel *)messageInfoGET{
    return [NSObject url:@"app/message/messageInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET{
    return [NSObject url:@"app/message/messageList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 公告列表 GET
+(URLManagerModel *)noticeListappGET{
    return [NSObject url:@"app/message/noticeListapp"
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息开关列表 GET
+(URLManagerModel *)turnOffListGET{
    return [NSObject url:@"app/message/turnOffList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 修改消息开关 POST
+(URLManagerModel *)updateOffPOST{
    return [NSObject url:@"app/message/updateOff"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST{
    return [NSObject url:@"app/messageStatus/add"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP银行卡相关接口
/// 添加银行卡 POST
+(URLManagerModel *)bankAddPOST{
    return [NSObject url:@"app/bank/add"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取银行卡信息 GET
+(URLManagerModel *)bankInfoGET{
    return [NSObject url:@"app/bank/bankInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)bankDeleteGET{
    return [NSObject url:@"app/bank/delete"
                funcName:NSStringFromSelector(_cmd)];
}
/// 银行卡列表 GET
+(URLManagerModel *)bankListGET{
    return [NSObject url:@"app/bank/list"
                funcName:NSStringFromSelector(_cmd)];
}
/// 修改银行卡 POST
+(URLManagerModel *)bankUpdatePOST{
    return [NSObject url:@"app/bank/update"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET{
    return [NSObject url:@"app/userFans/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户关注相关接口
/// 添加 POST
+(URLManagerModel *)userFocusAddPOST{
    return [NSObject url:@"app/userFocus/add"
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)userFocusDeleteGET{
    return [NSObject url:@"app/userFocus/delete"
                funcName:NSStringFromSelector(_cmd)];
}
/// 关注用户列表 GET
+(URLManagerModel *)userFocusListGET{
    return [NSObject url:@"app/userFocus/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— APP用户信息相关接口
/// 绑定手机号 POST
+(URLManagerModel *)bindPhonePOST{
    return [NSObject url:@"app/userInfo/bindPhone"
                funcName:NSStringFromSelector(_cmd)];
}
/// 校验是否有权限 GET
+(URLManagerModel *)checkHadRoleGET{
    return [NSObject url:@"app/userInfo/checkHadRole"
                funcName:NSStringFromSelector(_cmd)];
}
/// 进行签到 POST
+(URLManagerModel *)doSignPOST{
    return [NSObject url:@"app/userInfo/doSign"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取我的详情 GET
+(URLManagerModel *)myUserInfoGET{
    return [NSObject url:@"app/userInfo/myUserInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET{
    return [NSObject url:@"app/userInfo/rollDate"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询用户信息 GET
+(URLManagerModel *)selectIdCardGET{
    return [NSObject url:@"app/userInfo/selectIdCard"
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的签到列表 GET
+(URLManagerModel *)signListGET{
    return [NSObject url:@"app/userInfo/signList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 编辑个人资料 POST
+(URLManagerModel *)userInfoUpdatePOST{
    return [NSObject url:@"app/userInfo/update"
                funcName:NSStringFromSelector(_cmd)];
}
/// 绑定支付宝 POST
+(URLManagerModel *)updateAccountInfoPOST{
    return [NSObject url:@"app/userInfo/updateAccountInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 邀请好友 POST
+(URLManagerModel *)userInfoUpdateCode{
    return [NSObject url:@"app/userInfo/updateCode"
                funcName:NSStringFromSelector(_cmd)];
}
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST{
    return [NSObject url:@"app/userInfo/uploadImage"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户详情 GET
+(URLManagerModel *)userInfoGET{
    return [NSObject url:@"app/userInfo/userInfo"
                funcName:NSStringFromSelector(_cmd)];
}

@end
