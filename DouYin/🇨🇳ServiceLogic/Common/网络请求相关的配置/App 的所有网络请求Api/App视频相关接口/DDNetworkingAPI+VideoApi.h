//
//  DDNetworkingAPI+VideoApi.h
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

///// 删除自己发布的视频 POST
//+(URLManagerModel *)delAppVideoPOST;
///// 标签列表 GET
//+(URLManagerModel *)labelListGET;
///// 我的发布 GET
//+(URLManagerModel *)loadVideosGET;
///// 视频列表(关注、点赞)  POST
//+(URLManagerModel *)loadVideosPOST;
///// 我的喜欢(0、短视频 1、长视频)  GET
//+(URLManagerModel *)myPraiseVideoGET;
///// 视频点赞or取消 POST
//+(URLManagerModel *)praiseVideoPOST;
///// 生成上传链接 POST
//+(URLManagerModel *)presignedUploadUrlPOST;
///// 推荐的视频列表 POST
//+(URLManagerModel *)recommendVideosPOST;
///// 搜索视频 POST
//+(URLManagerModel *)searchPOST;
///// 上传视频 POST
//+(URLManagerModel *)uploadVideoPOST;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (VideoApi)

#pragma mark —— App视频相关接口
/// 删除自己发布的视频
+(void)delAppVideoPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 我的发布
+(void)loadVideosGET:(id)parameters
        successBlock:(MKDataBlock)successBlock
        failureBlock:(MKDataBlock)failureBlock;
/// 我的喜欢(0、短视频 1、长视频)  GET
+(void)myPraiseVideoGET:(id)parameters
           successBlock:(MKDataBlock)successBlock
           failureBlock:(MKDataBlock)failureBlock;
/// 视频点赞or取消
+(void)praiseVideoPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock;

/// 生成上传链接
+(void)presignedUploadUrlPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 搜索视频
+(void)searchPOST:(id)parameters
     successBlock:(MKDataBlock)successBlock;

@end

NS_ASSUME_NONNULL_END
