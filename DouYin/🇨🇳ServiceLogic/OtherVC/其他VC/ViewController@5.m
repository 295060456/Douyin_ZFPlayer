//
//  ViewController@5.m
//  My_BaseProj
//
//  Created by Jobs on 2020/7/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController@5.h"

@interface ViewController_5 ()

@end

@implementation ViewController_5

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
}


/// 帖子图片上传 POST
-(void)networking_postUploadImagePOST{
 NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],(long)[ZBRequestManager networkReachability]);
 [DataManager sharedInstance].tag = [ReuseIdentifier stringByAppendingString:NSStringFromSelector(_cmd)];

 [RequestTool setupPublicParameters];//公共配置、插件机制、证书设置
 @weakify(self)
 NSDictionary *parameters = @{};
 [DDNetworkingAPI requestApi:NSObject.postUploadImagePOST.funcName
        uploadImagesParamArr:@[parameters,
                               self.photosImageMutArr]
                successBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }
                failureBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }];
}
 
+(void)postUploadImagePOST:(id)parameters
       uploadImageDatas:(NSMutableArray<UIImage *> *)uploadImageDatas
           successBlock:(MKDataBlock)successBlock
           failureBlock:(MKDataBlock)failureBlock{
 
 NSMutableArray *uploadDatas = NSMutableArray.array;
 for (int i = 0; i < uploadImageDatas.count; i++) {
     UIImage *image = uploadImageDatas[i];
     NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
     NSString *fileName = [NSString stringWithFormat:@"%ld_%u.jpeg",time,arc4random() / 1000];
     ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                                  fileName:fileName
                                                  mimeType:@"image/jpeg"
                                                  fileData:imageData];
     [uploadDatas addObject:zbdata];
 }
 [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
     request.server = NSObject.BaseUrl;
     request.url = [request.server stringByAppendingString:NSObject.postUploadImagePOST.url];
     NSLog(@"request.URLString = %@",request.url);
     request.methodType = ZBMethodTypeUpload;
     request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
//        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置Headers 兼容
     request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
     request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
     request.requestSerializer = ZBHTTPRequestSerializer;
     request.uploadDatas = uploadDatas;
     if (![NSString isNullString:[DataManager sharedInstance].tag]) {
         request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
     };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
 } progress:^(NSProgress * _Nullable progress) {
     NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
 } success:^(id  responseObject,ZBURLRequest * request) {
     NSLog(@"responseObject: %@", responseObject);
     if (successBlock) {
         successBlock(responseObject);
     }
 } failure:^(NSError * _Nullable error) {
     NSLog(@"error: %@", error);
     if (failureBlock) {
         failureBlock(error);
     }
 }];
}

/// 帖子视频上传 POST
-(void)networking_postuploadVideoPOST{
 NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],(long)[ZBRequestManager networkReachability]);
 [DataManager sharedInstance].tag = [ReuseIdentifier stringByAppendingString:NSStringFromSelector(_cmd)];

 [RequestTool setupPublicParameters];//公共配置、插件机制、证书设置
 @weakify(self)
 NSDictionary *parameters = @{};
 
 extern NSString *postuploadVideoPOST;
 extern NSString *preproccess;
 
 [DDNetworkingAPI requestApi:NSObject.postuploadVideoPOST.funcName
        uploadVideosParamArr:@[parameters,
                               self.videosData]
                successBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }
                failureBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }];
}

 NSString *postuploadVideoPOST;
 +(void)postuploadVideoPOST:(id)parameters
                uploadVideo:(NSMutableArray <NSData *>*)videoDatas
               successBlock:(MKDataBlock)successBlock
               failureBlock:(MKDataBlock)failureBlock{
     NSMutableArray *uploadDatas = NSMutableArray.array;
     for (int i = 0; i < videoDatas.count; i++) {
         NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
         NSString *fileName = [NSString stringWithFormat:@"%ld_%u.mp4", time, arc4random() / 1000];

         ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                                      fileName:fileName
                                                      mimeType:@"video/mp4"
                                                      fileData:videoDatas[i]];
         
     //    ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
     //                                                 fileName:fileName
     //                                                 mimeType:@"video/mp4"
     //                                                  fileURL:videoURL];
         [uploadDatas addObject:zbdata];
     }
     
     [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
         request.server = NSObject.BaseUrl;
         request.url = [request.server stringByAppendingString:NSObject.postuploadVideoPOST.url];
         NSLog(@"request.URLString = %@",request.url);
         request.methodType = ZBMethodTypeUpload;
         request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
 //        request.parameters = parameters;//与公共配置 Parameters 兼容
 //        request.headers = headers;//与公共配置Headers 兼容
         request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
         request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
         request.requestSerializer = ZBHTTPRequestSerializer;
         request.uploadDatas = uploadDatas;
         if (![NSString isNullString:[DataManager sharedInstance].tag]) {
             request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
         };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
     } progress:^(NSProgress * _Nullable progress) {
         NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
         [WHToast toastLoadingMsg:@"视频上传中...请稍后"];
     } success:^(id  responseObject,ZBURLRequest * request) {
         NSLog(@"responseObject: %@", responseObject);
         [WHToast toastHide];
         if (successBlock) {
             successBlock(responseObject);
         }
     } failure:^(NSError * _Nullable error) {
         NSLog(@"error: %@", error);
         [WHToast toastHide];
         if (failureBlock) {
             failureBlock(error);
         }
     }];
 }

@end
