//
//  NSObject+AppTools.m
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import "NSObject+AppTools.h"

@implementation NSObject (AppTools)

#pragma mark —— 登录模块 在适当的时候调用
+(void)toLogin{
    
}
/// YES  已经登录 ｜  NO   没有登录
+(BOOL)isLogin{
    return NO;
//    return ![NSString isNullString:DDUserInfo.sharedInstance.uid];
}
/// 强制登录
+(void)forcedLogin{
    if (![NSObject isLogin]) {
        [NSObject toLogin];
        return;
    }
}
/// 跳转官方交流群
+(void)openGoToPotatol{
    [NSObject openURL:@"https://t.me/doudong"];
}

+(UIImage *)defaultHeaderImage{
    if ([NSObject isLogin]) {
        return KIMG(@"default_avatar_white");
    }else{
        return KIMG(@"未登录默认头像（灰）");
    }
}
///【用户添加关注】 POST
+(void)networking_postMyPostGETWithAuthorId:(NSString *)authorId
                               successBlock:(MKDataBlock)successBlock{}
///【用户取消关注】
+(void)networking_userFocusDeleteGETWithAuthorId:(NSString *)authorId
                                    successBlock:(MKDataBlock)successBlock{}
///【帖子添加关注】 POST
+(void)networking_postFansListPOSTWithAuthorId:(NSString *)authorId
                                  successBlock:(MKDataBlock)successBlock{

}
///【帖子取消关注】
+(void)networking_postFocusDeleteGETWithAuthorId:(NSString *)authorId
                                    successBlock:(MKDataBlock)successBlock{

}
/// 配置关注按钮
+(UIButton *)configAttentionBtn{
    UIButton *attentionBtn = UIButton.new;
    attentionBtn.adjustsImageWhenHighlighted = NO;
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:KWidth(12.5) weight:UIFontWeightRegular];
//    [attentionBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//    [attentionBtn setTitleColor:AppMainCor_05 forState:UIControlStateSelected];
    [attentionBtn setTitle:@"关注"
                  forState:UIControlStateNormal];
    [attentionBtn setTitle:@"已关注"
                  forState:UIControlStateSelected];
    [attentionBtn setBackgroundImage:KIMG(@"关注按钮")
                            forState:UIControlStateNormal];
    [attentionBtn setBackgroundImage:KIMG(@"已关注按钮")
                            forState:UIControlStateSelected];
    return attentionBtn;
}
///【用户关注】按钮逻辑
+(void)logicAttentionBtn:(UIButton *)btn
                  userID:(NSString *)userID
            successBlock:(nullable MKDataBlock)successBlock{

}
//【用户取消关注】按钮逻辑
+(void)unfollowUser:(id)parameters
       successBlock:(nullable MKDataBlock)successBlock{
}
///【帖子关注】按钮逻辑
+(void)logicAttentionBtn:(UIButton *)btn
                  postID:(NSString *)postID
            successBlock:(nullable MKDataBlock)successBlock{
    
}
//【帖子取消关注】关注
+(void)unfollowPost:(id)parameters
       successBlock:(nullable MKDataBlock)successBlock{

}
/// 点赞 POST
+(void)networking_postPraisePostPOST:(id)plazaCommunityListModel{

}
/// 启动次数 POST
+(void)startTime:(nullable void (^)(void))success
         failure:(nullable void (^)(NSError *error))failure {

}
/// 使用时长 POST
+(void)userUseTime:(NSInteger)second
           success:(nullable void (^)(void))success
           failure:(nullable void (^)(NSError *error))failure {

}
/// 播放数据
+(void)playDataWithMovNum:(NSInteger)movNum
             moiveDuration:(NSInteger)moiveDuration
                  videoNum:(NSInteger)videoNum
             videoDuration:(NSInteger)videoDuration
                    urlNum:(NSInteger)urlNum
                   success:(nullable void (^)(void))success
                   failure:(nullable void (^)(NSError *error))failure {

}
/// 用户更新个人信息-昵称-生日-地区  POST
+(void)networking_userInfoUpdatePOST:(id)userInfoUpdateModel
                        successBlock:(MKDataBlock)successBlock{

}
// 进App就要调用这个接口
+(void)refreshToken{

}

+(BOOL)isFristpostChannle{
    NSString *frist = [[NSUserDefaults standardUserDefaults] valueForKey:@"fristpostChannle"];
    if([NSString isNullString:frist]) {
        return YES;
    }return NO;
}

+(void)completeFristpostChannle {
    [[NSUserDefaults standardUserDefaults] setValue:@"fristpostChannle"
                                             forKey:@"fristpostChannle"];
}
/// 登出清空用户数据
-(void)logOut{
//    [UserDefaultManager cleanDataWithKey:authorizationKey];
//    [UserDefaultManager cleanDataWithKey:userIdKey];
//    [UserDefaultManager cleanDataWithKey:userInfoKey];
//    [RequestTool initConfig];
}
/// app版本信息
+(void)checkVersionBlock:(MKDataBlock)block{

}
/// 视频列表(关注、点赞)  POST
+(void)networking_loadVideosPOSTWithParameters:(NSDictionary *)parameters
                                  successBlock:(MKDataBlock)successBlock
                                  failureBlock:(MKDataBlock)failureBlock{

}
+(void)networking_myPraiseVideoGETWithParameters:(id)parameters
                                    successBlock:(MKDataBlock)successBlock
                                    failureBlock:(MKDataBlock)failureBlock{

}

@end

