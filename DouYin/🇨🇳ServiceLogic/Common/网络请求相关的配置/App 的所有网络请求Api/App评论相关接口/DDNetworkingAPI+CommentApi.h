//
//  DDNetworkingAPI+CommentApi.h
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

///// 评论视频 POST
//+(URLManagerModel *)commentVideoPOST;
///// 删除评论 POST
//+(URLManagerModel *)delCommentPOST;
///// 初始化用户评论列表 GET
//+(URLManagerModel *)queryInitListGET;
///// 获取回复列表 GET
//+(URLManagerModel *)queryReplyListGET;
///// 回复评论 POST
//+(URLManagerModel *)replyCommentPOST;
///// 点赞或取消点赞 POST
//+(URLManagerModel *)setPraisePOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (CommentApi)

#pragma mark —— App评论相关接口
/// 评论视频
+(void)commentVideoPOST:(id)parameters
           successBlock:(MKDataBlock)successBlock;
/// 删除评论
+(void)delCommentPOST:(id)parameters
         successBlock:(MKDataBlock)successBlock;
/// 初始化用户评论列表
+(void)queryInitListGET:(id)parameters
           successBlock:(MKDataBlock)successBlock;
/// 获取回复列表
+(void)queryReplyListGET:(id)parameters
            successBlock:(MKDataBlock)successBlock;
/// 回复评论
+(void)replyCommentPOST:(id)parameters
           successBlock:(MKDataBlock)successBlock;
/// 点赞或取消点赞
+(void)setPraisePOST:(id)parameters
        successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
