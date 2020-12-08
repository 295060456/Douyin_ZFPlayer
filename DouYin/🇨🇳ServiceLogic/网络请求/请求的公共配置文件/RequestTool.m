//
//  RequestTool.m
//  ZBNetworkingDemo
//
//  Created by Suzhibin on 2020/6/2.
//  Copyright © 2020 Suzhibin. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+(void)setupPublicParameters{
#pragma mark —— 公共配置
    /**
     基础配置
     需要在请求之前配置，设置后所有请求都会带上 此基础配置
     */
    NSMutableDictionary *parameters = NSMutableDictionary.dictionary;
    NSString *timeString = [NSString stringWithFormat:@"%.2f",[NSDate.date timeIntervalSince1970]];
    parameters[@"timeString"] = timeString;//时间戳

    NSMutableDictionary *headers = NSMutableDictionary.dictionary;
    headers[@"Token"] = @"Token";

    [ZBRequestManager setupBaseConfig:^(ZBConfig * _Nullable config) {
        config.baseServer = server_URL;//如果同一个环境，有多个域名 不要设置baseURL
        config.parameters = parameters;//公共参数
        // filtrationCacheKey因为时间戳是变动参数，缓存key需要过滤掉 变动参数,如果 不使用缓存功能 或者 没有变动参数 则不需要设置。
        config.filtrationCacheKey = @[@"timeString"];
        config.headers = headers;//请求头
        config.requestSerializer = ZBJSONRequestSerializer; //全局设置 请求格式 默认JSON
        config.responseSerializer = ZBJSONResponseSerializer; //全局设置 响应格式 默认JSON
        config.timeoutInterval = 15;//超时时间  优先级 小于 单个请求重新设置
        //config.retryCount = 2;//请求失败 所有请求重新连接次数
        config.consoleLog = YES;//开log
        config.userInfo = @{@"info":@"ZBNetworking"};//请求的信息，可以用来注释和判断使用
//        config.responseContentTypes = @[@"text/aaa",@"text/bbb"];//添加新的响应数据类型
        /**
         内部已存在的响应数据类型
         @"text/html",@"application/json",@"text/json", @"text/plain",@"text/javascript",@"text/xml",@"image/*",@"multipart/form-data",@"application/octet-stream",@"application/zip"
         */
    }];
#pragma mark —— 插件机制
    /**
       插件机制
       自定义 所有 请求,响应,错误 处理逻辑的方法

       比如 1.自定义缓存逻辑 感觉ZBNetworking缓存不好，想使用yycache 等
           2.自定义响应逻辑 服务器会在成功回调里做 返回code码的操作
           3.一个应用有多个服务器地址，可在此进行配置
           4.统一loading 等UI处理
           5. ......
       */
    //预处理 请求
    [ZBRequestManager setRequestProcessHandler:^(ZBURLRequest * _Nullable request,
                                                 id  _Nullable __autoreleasing * _Nullable setObject) {
         NSLog(@"请求之前");
        //比如 我们可以根据参数寻找一个业务的请求 ，给改该请求做一个替换响应数据的操作
        if ([request.userInfo[@"tag"] isEqualToString:@"7777"]) {
            if (request.apiType != ZBRequestTypeCache) {
                      /**
                      //⚠️setObject 赋值 就会走成功回调
                      如判断内的请求包含keep请求，keep功能将受影响
                      request.keepType=ZBResponseKeepFirst
                      request.keepType=ZBResponseKeepLast
                       都不会不起作用了。所有请求都会成功了。
                       */
                *setObject = @{@"authors":@[@{@"errorCode":@"400"}],
                                @"videos":@[@{@"errorCode":@"400"}]};
            }
        }

//        if ([request.userInfo[@"tag"] isEqualToString:@"9999"]) {
//            //自定义缓存逻辑时apiType需要设置为 request.apiType=ZBRequestTypeRefresh（默认）这样就不会走ZBNetworking自带缓存了
//            request.apiType=ZBRequestTypeRefresh;
//            //排除上传和下载请求
//            if (request.methodType != ZBMethodTypeUpload ||
//                request.methodType != ZBMethodTypeDownLoad) {
//                NSDictionary *dict= [[DataManager sharedInstance] dataInfoWithKey:[NSString stringWithFormat:@"%@%@",request.URLString,request.parameters[@"author"]]];
//                if (dict) {
//                  //⚠️setObject 赋值 就会走成功回调
//                    *setObject=dict;
//                }
//            }
//        }
    }];
    //预处理 响应：在这里过滤错误信息，外层最终得到我们想要的核心数据
    [ZBRequestManager setResponseProcessHandler:^id(ZBURLRequest * _Nullable request,
                                                    id  _Nullable responseObject,
                                                    NSError * _Nullable __autoreleasing * _Nullable error) {
        NSLog(@"成功回调 数据返回之前");
        if ([request.userInfo[@"info"] isEqualToString:@"ViewController_1"]) {//分辨接口，预防个别接口的处理方式和大众不太一样
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                NSDictionary *dataDic = (NSDictionary *)responseObject;
                
//                dataDic[@"HTTPServiceResponseCodeKey"];
//                dataDic[@"HTTPServiceResponseMsgKey"];
//                dataDic[@"HTTPServiceResponseDataKey"];

                NSNumber *b = (NSNumber *)dataDic[HTTPServiceResponseCodeKey];
                if (b.integerValue == HTTPResponseCodeSuccess) {
                    VideoModel *videoModel = [VideoModel mj_objectWithKeyValues:dataDic[HTTPServiceResponseDataKey]];
                    videoModel.listMutArr = [VideoModel_Core mj_objectArrayWithKeyValuesArray:dataDic[HTTPServiceResponseDataKey][@"list"]];
                    NSLog(@"");
                    return videoModel.listMutArr;
                }
            }
        }
        return nil;
    }];
    //预处理 错误
    [ZBRequestManager setErrorProcessHandler:^(ZBURLRequest * _Nullable request,
                                               NSError * _Nullable error){
        if (error.code == NSURLErrorCancelled){
            NSLog(@"请求取消❌------------------");
        }else if (error.code == NSURLErrorTimedOut){
            NSLog(@"请求超时");
        }else{
            NSLog(@"请求失败");
        }
    }];
#pragma mark —— 证书设置
    /**
     证书设置
     ZBRequestEngine 继承AFHTTPSessionManager，所需其他设置 可以使用[ZBRequestEngine defaultEngine] 自行设置
     */
    NSString *name = @"";
    if (name.length > 0) {
        // 先导入证书
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:name ofType:@"cer"];//证书的路径
        NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
           // 如果需要验证自建证书(无效证书)，需要设置为YES，默认为NO;
        securityPolicy.allowInvalidCertificates = YES;
           // 是否需要验证域名，默认为YES;
        securityPolicy.validatesDomainName = NO;
        securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
        [ZBRequestEngine defaultEngine].securityPolicy = securityPolicy;
    }
}

@end

/*
{
    msg = "";
    data = {
        endRow = "10";
        hasNextPage = 1;
        pages = 11;
        pageNum = 1;
        navigatepageNums = (
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8
        );
        isLastPage = 0;
        total = "108";
        nextPage = 2;
        navigatePages = 8;
        size = 10;
        hasPreviousPage = 0;
        navigateFirstPage = 1;
        startRow = "1";
        navigateLastPage = 8;
        prePage = 0;
        list = (
            {
                isPraise = 0;
                authorId = "1292664845497339905";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
                praiseNum = 0;
                author = "束浩博375";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1919.jpeg";
                videoId = "1295363512092078082";
                videoTitle = "永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我永恒的承诺卟属於我";
                videoSize = "3770625";
                isVip = 0;
                commentNum = 0;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1919.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:14:52";
                playNum = 0;
                videoTime = 15;
            },
            {
                isPraise = 0;
                authorId = "1292839352157691906";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
                praiseNum = 0;
                author = "居德赫004";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1486.jpeg";
                videoId = "1295359973504593922";
                videoTitle = "西_大大滴花姑娘";
                videoSize = "2173600";
                isVip = 0;
                commentNum = 2;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1486.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:00:53";
                playNum = 0;
                videoTime = 17;
            },
            {
                isPraise = 0;
                authorId = "1290921141845663745";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
                praiseNum = 0;
                author = "唐斯年028";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080619/1290895585221619714/mp4/007.jpeg";
                videoId = "1291340246880989186";
                videoTitle = "我心不允许我脆弱";
                videoSize = "8525205";
                isVip = 0;
                commentNum = 6;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020080619/1290895585221619714/mp4/007.mp4";
                areSelf = 0;
                publishTime = "2020-08-06 19:47:20";
                playNum = 0;
                videoTime = 111;
            },
            {
                isPraise = 0;
                authorId = "1292307099493142529";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png";
                praiseNum = 0;
                author = "毛涵润082";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1920.jpeg";
                videoId = "1295363662403350529";
                videoTitle = "黑洲非人";
                videoSize = "5586606";
                isVip = 0;
                commentNum = 1;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1920.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:15:23";
                playNum = 0;
                videoTime = 18;
            },
            {
                isPraise = 0;
                authorId = "1292839997338116098";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n1@2x.png";
                praiseNum = 0;
                author = "宇文咏德828";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1485.jpeg";
                videoId = "1295359861940301825";
                videoTitle = "我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口我想找你，却没了借口";
                videoSize = "2229898";
                isVip = 0;
                commentNum = 0;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1485.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:00:26";
                playNum = 0;
                videoTime = 15;
            },
            {
                isPraise = 0;
                authorId = "1291659151000276993";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n1@2x.png";
                praiseNum = 0;
                author = "向兴言122";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_2068.jpeg";
                videoId = "1295364747893420033";
                videoTitle = "哈里波特大";
                videoSize = "3694994";
                isVip = 0;
                commentNum = 1;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_2068.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:19:47";
                playNum = 0;
                videoTime = 11;
            },
            {
                isPraise = 0;
                authorId = "1292738239194492929";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png";
                praiseNum = 0;
                author = "佘泰宁796";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1863.jpeg";
                videoId = "1295363101071257602";
                videoTitle = "罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜罗密欧与猪过夜";
                videoSize = "9018840";
                isVip = 0;
                commentNum = 0;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/MP4/IMG_1863.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 22:12:58";
                playNum = 0;
                videoTime = 31;
            },
            {
                isPraise = 0;
                authorId = "1291366732774060033";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png";
                praiseNum = 0;
                author = "韶杰184";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/mp4/video_2019-10-22_02-29-50.jpeg";
                videoId = "1295366055035678722";
                videoTitle = "倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山倾城一笑，抵我半壁江山";
                videoSize = "1258478";
                isVip = 0;
                commentNum = 3;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081722/1290895585221619714/mp4/video_2019-10-22_02-29-50.mp4";
                areSelf = 0;
                publishTime = "2020-08-17 22:25:06";
                playNum = 0;
                videoTime = 11;
            },
            {
                isPraise = 0;
                authorId = "1293025246747648002";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n3@2x.png";
                praiseNum = 0;
                author = "端木刚729";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_0107.jpeg";
                videoId = "1295358992205230081";
                videoTitle = "药别停";
                videoSize = "1425088";
                isVip = 0;
                commentNum = 0;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/IMG_0107.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 21:57:01";
                playNum = 0;
                videoTime = 13;
            },
            {
                isPraise = 0;
                authorId = "1293173931422814209";
                videoSort = 0;
                headImage = "http://www.akixr.top:9000/bucket1-dev/IMAGES/app-user/headimg/n1@2x.png";
                praiseNum = 0;
                author = "油麻地话事人";
                videoImg = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/0004.jpeg";
                videoId = "1295357635519852546";
                videoTitle = "纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻纯眞嘚发酵叻";
                videoSize = "1695495";
                isVip = 0;
                commentNum = 7;
                isAttention = 0;
                videoIdcUrl = "http://www.akixr.top:9000/bucket1-dev/VIDEOS/2020081721/1290895585221619714/MP4/0004.MP4";
                areSelf = 0;
                publishTime = "2020-08-17 21:51:37";
                playNum = 0;
                videoTime = 15;
            }
        );
        isFirstPage = 1;
        pageSize = 10;
    };
    code = 200;
}

*/
