//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

//NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Main;/// 柬埔寨（主要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Minor;/// 柬埔寨（次要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Rally;/// 柬埔寨Rally（次要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_China_Mainland;/// 中国大陆开发环境
NetworkingEnvir networkingEnvir = TestEnviron;/// 测试环境
//NetworkingEnvir networkingEnvir = ProductEnviron;/// 生产环境

@implementation NSObject (URLManager)
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
+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"http://172.24.135.53:8011/";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_Cambodia_Rally:{
            /// 柬埔寨Rally（次要）开发环境
            return @"http://172.24.135.15:8011/";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"http://222.186.150.148:81/api/";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"http://172.24.135.54/api/";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"https://www.xiuwa.top/api/";
        }break;
        default:
            return @"";
            break;
    }
}

+(NSString *)BaseUrl_H5{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"http://222.186.150.148/taskpage";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_Cambodia_Rally:{
            /// 柬埔寨Rally（次要）开发环境
            return @"http://172.24.135.15/api/";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"http://222.186.150.148:81/taskpage-white";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"http://172.24.135.54/taskpage-white";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"https://www.xunniao.top/h5-white";
        }break;
        default:
            return @"";
            break;
    }
}
#pragma mark —— 社区相关接口
/// 创作者排行列表 GET
+(URLManagerModel *)creationListGET{
    return [NSObject url:@"app/community/creationList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 收益排行列表 GET
+(URLManagerModel *)incomeListGET{
    return [NSObject url:@"app/community/incomeList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 人气视频列表 GET
+(URLManagerModel *)popularityVideosGET{
    return [NSObject url:@"app/community/popularityVideos"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— 数据统计相关接口
/// 活跃用户 POST
+(URLManagerModel *)addActiveUserDataPOST{
    return [NSObject url:@"app/statistics/addActiveUserData"
                funcName:NSStringFromSelector(_cmd)];
}
/// 启动次数 POST
+(URLManagerModel *)addStartTimePOST{
    return [NSObject url:@"app/statistics/addStartTime"
                funcName:NSStringFromSelector(_cmd)];
}
/// 使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST{
    return [NSObject url:@"app/statistics/addUseTimeData"
                funcName:NSStringFromSelector(_cmd)];
}
/// 渠道列表 GET
+(URLManagerModel *)channelListGET{
    return [NSObject url:@"app/statistics/channelList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 播放数据 POST
+(URLManagerModel *)playDataPOST{
    return [NSObject url:@"app/statistics/playData"
                funcName:NSStringFromSelector(_cmd)];
}
/// app版本信息 GET
+(URLManagerModel *)versionInfoAppGET{
    return [NSObject url:@"app/statistics/versionInfo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App登录信息相关接口
/// 找回密码接口-重置密码 POST
+(URLManagerModel *)changePasswordPOST{
    return [NSObject url:@"app/login/changePassword"
                funcName:NSStringFromSelector(_cmd)];
}
/// 找回密码接口-身份验证 POST
+(URLManagerModel *)checkIdentityPOST{
    return [NSObject url:@"app/login/checkIdentity"
                funcName:NSStringFromSelector(_cmd)];
}
/// 登录接口 POST
+(URLManagerModel *)appLoginPOST{
    return [NSObject url:@"app/login/login"
                funcName:NSStringFromSelector(_cmd)];
}
/// 退出接口 GET
+(URLManagerModel *)appLogoutGET{
    return [NSObject url:@"app/login/out"
                funcName:NSStringFromSelector(_cmd)];
}
/// 随机生成4位随机数 GET
+(URLManagerModel *)randCodeGET{
    return [NSObject url:@"app/login/randCode"
                funcName:NSStringFromSelector(_cmd)];
}
/// 注册接口(new) POST
+(URLManagerModel *)appRegisterPOST{
    return [NSObject url:@"app/login/register"
                funcName:NSStringFromSelector(_cmd)];
}
/// 修改密码接口 POST
+(URLManagerModel *)resetPasswordPOST{
    return [NSObject url:@"app/login/resetPassword"
                funcName:NSStringFromSelector(_cmd)];
}
/// 发送短信 POST
+(URLManagerModel *)sendSmsCodePOST{
    return [NSObject url:@"app/login/sendSmsCode"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App广告相关接口
/// 查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET{
    return [NSObject url:@"app/adInfo/adInfo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App好友关系相关接口
/// 手动执行奖励记录 GET
+(URLManagerModel *)addAwardGET{
    return [NSObject url:@"app/userFriend/addAward"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取活跃用户 GET
+(URLManagerModel *)awardListGET{
    return [NSObject url:@"app/userFriend/awardList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 最新四个好友 GET
+(URLManagerModel *)fourListGET{
    return [NSObject url:@"app/userFriend/fourList"
                funcName:NSStringFromSelector(_cmd)];
}
/// selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET{
    return [NSObject url:@"app/userFriend/friendUrl"
                funcName:NSStringFromSelector(_cmd)];
}
/// 二期好友列表 GET
+(URLManagerModel *)userFriendListGET{
    return [NSObject url:@"app/userFriend/frindList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 统计我的收益 GET
+(URLManagerModel *)myInComeGET{
    return [NSObject url:@"app/userFriend/myInCome"
                funcName:NSStringFromSelector(_cmd)];
}
/// 面对面邀请保存好友手机号码 POST
+(URLManagerModel *)savePhonePOST{
    return [NSObject url:@"app/userFriend/savePhone"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App黑名单相关接口
/// 添加 POST
+(URLManagerModel *)blackListAddPOST{
    return [NSObject url:@"app/black/add"
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)blackListDeleteGET{
    return [NSObject url:@"app/black/delete"
                funcName:NSStringFromSelector(_cmd)];
}
/// 黑名单列表 GET
+(URLManagerModel *)blackListGET{
    return [NSObject url:@"app/black/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App获取配置信息
/// app启动参数 GET
+(URLManagerModel *)refreshGET{
    return [NSObject url:@"app/sys/refresh"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App看视频获得金币奖励
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
#pragma mark —— App评论相关接口
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
    return [NSObject url:@"app/comment/queryInitList"
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
#pragma mark —— App钱包相关接口
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
/// 我的钱包流水 POST
+(URLManagerModel *)myFlowsPOST{
    return [NSObject url:@"app/wallet/myFlows"
                funcName:NSStringFromSelector(_cmd)];
}
/// 二期抖币流水 GET
+(URLManagerModel *)myGoldGET{
    return [NSObject url:@"app/wallet/myGold"
                funcName:NSStringFromSelector(_cmd)];
}
/// 钱包流水（二期) GET
+(URLManagerModel *)myPurseFlowGET{
    return [NSObject url:@"app/wallet/myPurseFlow"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户信息 POST
+(URLManagerModel *)myUserWalletPOST{
    return [NSObject url:@"app/wallet/myUserWallet"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取用户信息 POST
+(URLManagerModel *)myWalletPOST{
    return [NSObject url:@"app/wallet/myWallet"
                funcName:NSStringFromSelector(_cmd)];
}
/// App端转账（转账即可畅玩游戏）POST
+(URLManagerModel *)transferPOST{
    return [NSObject url:@"app/wallet/transfer"
                funcName:NSStringFromSelector(_cmd)];
}
/// 包网回调地址 POST
+(URLManagerModel *)transferCallBackPOST{
    return [NSObject url:@"app/wallet/transferCallBack"
                funcName:NSStringFromSelector(_cmd)];
}
/// 包网回调校验地址 POST
+(URLManagerModel *)transferVerifyPOST{
    return [NSObject url:@"app/wallet/transferVerify"
                funcName:NSStringFromSelector(_cmd)];
}
/// 余额提现 POST
+(URLManagerModel *)withdrawBalancePOST{
    return [NSObject url:@"app/wallet/withdrawBalance"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App视频相关接口
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
/// 我的发布 GET
+(URLManagerModel *)loadVideosGET{
    return [NSObject url:@"app/videos/loadVideos"
                funcName:NSStringFromSelector(_cmd)];
}
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST{
    return [NSObject url:@"app/videos/loadVideos"
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的喜欢(0、短视频  1、长视频)  GET
+(URLManagerModel *)myPraiseVideoGET{
    return [NSObject url:@"app/videos/myPraiseVideo"
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
#pragma mark —— App帖子粉丝相关接口
/// 帖子粉丝用户列表 GET
+(URLManagerModel *)postFansListGET{
    return [NSObject url:@"app/postFans/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App帖子关注相关接口
/// 添加 POST
+(URLManagerModel *)postFansListPOST{
return [NSObject url:@"app/postFocus/add"
            funcName:NSStringFromSelector(_cmd)];
}
/// 删除 GET
+(URLManagerModel *)postFocusDeleteGET{
    return [NSObject url:@"app/postFocus/delete"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子关注用户列表 GET
+(URLManagerModel *)postFocusListGET{
    return [NSObject url:@"app/postFocus/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App帖子评论相关接口
/// 评论 GET
+(URLManagerModel *)commentAddPOST{
    return [NSObject url:@"app/comment/add"
                funcName:NSStringFromSelector(_cmd)];
}
/// 全部评论列表 GET
+(URLManagerModel *)commentAllListGET{
    return [NSObject url:@"app/comment/allList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 评论列表 GET
+(URLManagerModel *)commentListGET{
    return [NSObject url:@"app/comment/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息相关接口
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET{
    return [NSObject url:@"app/message/messageList"
                funcName:NSStringFromSelector(_cmd)];
}
/// app公告列表 GET
+(URLManagerModel *)noticeListGET{
    return [NSObject url:@"app/message/noticeList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 消息数量
+(URLManagerModel *)selectMessageNumberGET{
    return [NSObject url:@"/app/message/selectMessageNumber"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST{
    return [NSObject url:@"app/messageStatus/add"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App意见反馈相关接口
/// 意见反馈
+(URLManagerModel *)feedBackAddPOST{
    return [NSObject url:@"app/feedBack/add"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App银行卡相关接口
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
#pragma mark —— App用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET{
    return [NSObject url:@"app/userFans/list"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App用户关注相关接口
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
#pragma mark —— App用户帖子相关接口
/// 发帖 POST
+(URLManagerModel *)postAddPostPOST{
    return [NSObject url:@"app/post/addPost"
                funcName:NSStringFromSelector(_cmd)];
}
/// 轮播图列表 GET
+(URLManagerModel *)bannerListGET{
    return [NSObject url:@"app/post/bannerList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 评论帖子详情 GET
+(URLManagerModel *)postCommentDetailInfoGET{
    return [NSObject url:@"app/post/commentDetailInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 删除帖子 POST
+(URLManagerModel *)delPostPOST{
    return [NSObject url:@"app/post/delPost"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户帖子详情 GET
+(URLManagerModel *)postDetailInfoGET{
    return [NSObject url:@"app/post/detailInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子列表 GET
+(URLManagerModel *)postListGET{
    return [NSObject url:@"app/post/list"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子我的(关注、点赞.发布) GET
+(URLManagerModel *)postMyPostGET{
    return [NSObject url:@"app/post/myPost"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子详情 GET
+(URLManagerModel *)postInfoGET{
    return [NSObject url:@"app/post/postInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 点赞 POST
+(URLManagerModel *)postPraisePostPOST{
    return [NSObject url:@"app/post/praisePost"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询环体下载地址 GET
+(URLManagerModel *)selectDowndSettingGET{
    return [NSObject url:@"/app/post/selectDowndSetting"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子图片上传 POST
+(URLManagerModel *)postUploadImagePOST{
    return [NSObject url:@"app/post/uploadImage"
                funcName:NSStringFromSelector(_cmd)];
}
/// 帖子视频上传 POST
+(URLManagerModel *)postuploadVideoPOST{
    return [NSObject url:@"app/post/uploadVideo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户详情  GET
+(URLManagerModel *)postUserInfoGET{
    return [NSObject url:@"app/post/userInfo"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户帖子列表 GET
+(URLManagerModel *)userPostListGET{
    return [NSObject url:@"app/post/userPostList"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App用户信息相关接口
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
/// 系统头像选择
+(URLManagerModel *)choiceHeadImagePOST{
    return [NSObject url:@"/app/userInfo/choiceHeadImage"
                funcName:NSStringFromSelector(_cmd)];
}
/// 进行签到 POST
+(URLManagerModel *)doSignPOST{
    return [NSObject url:@"app/userInfo/doSign"
                funcName:NSStringFromSelector(_cmd)];
}
/// 系统头像列表 GET
+(URLManagerModel *)headImageListGET{
    return [NSObject url:@"app/userInfo/headImageList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 邀请好友 POST
+(URLManagerModel *)userInfoInviteFriendPOST{
    return [NSObject url:@"app/userInfo/inviteFriend"
                funcName:NSStringFromSelector(_cmd)];
}
/// 邀请任务数据展示 GET
+(URLManagerModel *)userInfoListGET{
    return [NSObject url:@"app/userInfo/list"
                funcName:NSStringFromSelector(_cmd)];
}
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET{
    return [NSObject url:@"app/userInfo/rollDate"
                funcName:NSStringFromSelector(_cmd)];
}
/// 获取邀请码接口 POST
+(URLManagerModel *)userInfoSelectInviteCodePOST{
    return [NSObject url:@"app/userInfo/selectInviteCode"
                funcName:NSStringFromSelector(_cmd)];
}
/// App首页任务界面，查询用户长短视频观影数 POST
+(URLManagerModel *)userInfoSelectVideoCountPOST{
    return [NSObject url:@"app/userInfo/selectVideoCount"
                funcName:NSStringFromSelector(_cmd)];
}
/// 敏感词列表
+(URLManagerModel *)userInfoSensitiveListGET{
    return [NSObject url:@"app/userInfo/sensitiveList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 我的签到列表 GET
+(URLManagerModel *)signListGET{
    return [NSObject url:@"app/userInfo/signList"
                funcName:NSStringFromSelector(_cmd)];
}
/// 用户更新个人信息-昵称-生日-地区  POST
+(URLManagerModel *)userInfoUpdatePOST{
    return [NSObject url:@"app/userInfo/update"
                funcName:NSStringFromSelector(_cmd)];
}
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST{
    return [NSObject url:@"app/userInfo/uploadImage"
                funcName:NSStringFromSelector(_cmd)];
}
/// App端查看用户详情 GET
+(URLManagerModel *)userInfoGET{
    return [NSObject url:@"app/userInfo/userInfo"
                funcName:NSStringFromSelector(_cmd)];
}
#pragma mark —— App vip相关接口
/// 开通vip GET
+(URLManagerModel *)vipApplyGET{
    return [NSObject url:@"app/vip/apply"
                funcName:NSStringFromSelector(_cmd)];
}
/// 查询全部会员等级权益列表 GET
+(URLManagerModel *)vipListGET{
    return [NSObject url:@"app/vip/list"
                funcName:NSStringFromSelector(_cmd)];
}

/// 用户开通会员之后，查询当前会员等级权益 GET
+(URLManagerModel *)vipSelfGET{
    return [NSObject url:@"app/vip/self"
                funcName:NSStringFromSelector(_cmd)];
}

@end
