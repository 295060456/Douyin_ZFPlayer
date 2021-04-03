//
//  DDNetworkingAPI+UserPostApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
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

///// 发帖 POST
//+(URLManagerModel *)postAddPostPOST;
///// 轮播图列表 GET
//+(URLManagerModel *)bannerListGET;
///// 评论帖子详情 GET
//+(URLManagerModel *)postCommentDetailInfoGET;
///// 删除帖子 POST
//+(URLManagerModel *)delPostPOST;
///// 用户帖子详情 GET
//+(URLManagerModel *)postDetailInfoGET;
///// 帖子列表 GET
//+(URLManagerModel *)postListGET;
///// 帖子我的(关注、点赞.发布) GET
//+(URLManagerModel *)postMyPostGET;
///// 帖子详情 GET
//+(URLManagerModel *)postInfoGET;
///// 点赞 POST
//+(URLManagerModel *)postPraisePostPOST;
///// 帖子图片上传 POST
//+(URLManagerModel *)postUploadImagePOST;
///// 帖子视频上传 POST
//+(URLManagerModel *)postuploadVideoPOST;
///// 用户详情  GET
//+(URLManagerModel *)postUserInfoGET;
///// 用户帖子列表 GET
//+(URLManagerModel *)userPostListGET;

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserPostApi)

#pragma mark —— App用户帖子相关接口
/// 发帖 POST
+(void)postAddPostPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 轮播图列表 GET
+(void)bannerListGET:(id)parameters
        successBlock:(MKDataBlock)successBlock;
/// 评论帖子详情 GET
+(void)postCommentDetailInfoGET:(id)parameters
                   successBlock:(MKDataBlock)successBlock;
/// 删除帖子 POST
+(void)delPostPOST:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 用户帖子详情 GET
+(void)postDetailInfoGET:(id)parameters
            successBlock:(MKDataBlock)successBlock;
/// 帖子列表 GET
+(void)postListGET:(id)parameters
      successBlock:(MKDataBlock)successBlock
      failureBlock:(MKDataBlock)failureBlock;
/// 帖子我的(关注、点赞.发布) GET
+(void)postMyPostGET:(id)parameters
        successBlock:(MKDataBlock)successBlock
        failureBlock:(MKDataBlock)failureBlock;
/// 帖子详情 GET
+(void)postInfoGET:(id)parameters
      successBlock:(MKDataBlock)successBlock;
/// 点赞 POST
+(void)postPraisePostPOST:(id)parameters
             successBlock:(MKDataBlock)successBlock;
/// 查询环体下载地址 GET
+(void)selectDowndSettingGET:(id)parameters
                successBlock:(MKDataBlock)successBlock;
/// 帖子图片上传 POST
+(void)postUploadImagePOST:(id)parameters
               uploadDatas:(NSMutableArray<ZBUploadData *> *)uploadDatas
              successBlock:(MKDataBlock)successBlock
              failureBlock:(MKDataBlock)failureBlock;
/// 帖子视频上传 POST
+(void)postuploadVideoPOST:(id)parameters
               uploadVideo:(NSMutableArray <NSData *>*)videoDatas
              successBlock:(MKDataBlock)successBlock
              failureBlock:(MKDataBlock)failureBlock;
/// 用户详情  GET
+(void)postUserInfoGET:(id)parameters
          successBlock:(MKDataBlock)successBlock;
/// 用户帖子列表 GET
+(void)userPostListGET:(id)parameters
          successBlock:(MKDataBlock)successBlock
          failureBlock:(MKDataBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
