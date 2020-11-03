//
//  ViewController@3.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@3.h"

@interface ViewController_3 ()<NSStreamDelegate>
{
    
}

@end

@implementation ViewController_3

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

-(void)dd{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://222.186.150.148:9000/my-bucketname/images/ios6644d56be5f6483da761c50.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minio%252F20201103%252Fus-east-1%252Fs3%252Faws4_request&X-Amz-Date=20201103T034552Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=543d3d754733b51c9c05f68d605fd3057d5c3d8a8507e64e1e26e743760d61e6"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"image/jpg"
    };

    [request setAllHTTPHeaderFields:headers];

    [request setHTTPMethod:@"PUT"];
    
    NSData *dd = UIImagePNGRepresentation(KIMG(@"0"));
    
    request.HTTPBody = UIImagePNGRepresentation(KIMG(@"0"));

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionary);
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    
    
    [self dd];

//    NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],[ZBRequestManager networkReachability]);
//    [DataManager sharedInstance].tag = ReuseIdentifier;
//    /**
//     公共配置
//     插件机制
//     证书设置
//     */
//    [RequestTool setupPublicParameters];
//    @weakify(self)
//    [NetworkingAPI temp:^(id data) {
//        @strongify(self)
//        NSLog(@"");
//    }];
    
//    [self PUT:@"https://www.bombom999.top/my-bucketname/putbyios.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minio%2F20201029%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201029T081659Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=16ffcdbcd00f965b8319012835db01cd1df2bcf8e7626761b59daef061ab83cc"
//   parameters:nil
//     progress:nil
//      success:nil
//      failure:nil];
    
    
//    @weakify(self)
//    [NetworkingAPI temp];
}

//-(void)cc{
//#define Coding(str) [str dataUsingEncoding:NSUTF8StringEncoding]
//    NSURL *URL = [NSURL URLWithString:@"https://www.bombom999.top/my-bucketname/images/iosimg.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minio%2F20201019%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201019T074421Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=61523129bacc68290a6de367080edd39e0bc9909882ffac0265fd8f4d03b212d"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    request.timeoutInterval = 1;
//    request.HTTPMethod = @"PUT";
//    
//    NSString *value = @"multipart/form-data;boundary=dashcam";
//     [request setValue:value forHTTPHeaderField:@"Content-Type"];
//     NSMutableData *fileData = [NSMutableData data];
//     //文件参数
//     [fileData appendData:Coding(@"--dashcam\r\n")];
//     NSString *dis = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",@"bin", @"bin.bin"];
//     [fileData appendData:Coding(dis)];
//     
//     NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", @"application/octet-stream"];
//     [fileData appendData:Coding(type)];
//     [fileData appendData:Coding(@"\r\n")];
//     [fileData appendData:data];
//     [fileData appendData:Coding(@"\r\n")];
//     [fileData appendData:Coding(@"--dashcam--\r\n")];
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    [[self.session uploadTaskWithRequest:request
//                                fromData:fileData] resume];
//}

- (void)PUT:(NSString *)URLString
 parameters:(NSDictionary *)parameters
   progress:(MKDataBlock)progress
    success:(MKDataBlock)success
    failure:(MKDataBlock)failure {
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT"
//                                                                                              URLString:URLString
//                                                                                             parameters:nil
//                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
////        NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"];
////
////        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:path];
////        inputStream.delegate = self;
////        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
////        [inputStream open];
////
////        [formData appendPartWithInputStream:inputStream
////                                       name:@"file"
////                                   fileName:@"111"
////                                     length:UIImagePNGRepresentation(KIMG(@"0")).length
////                                   mimeType:@"image/jpeg"];
//
//        [formData appendPartWithFileData:UIImagePNGRepresentation(KIMG(@"0"))
//                                    name:@"file"
//                                fileName:@"image"
//                                mimeType:@"image/jpeg"];
//
//    } error:nil];
//
//    [request setValue:@"image/jpeg"
//   forHTTPHeaderField:@"Content-Type"];
//
//    NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request
//                                                                 progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"");
//    } completionHandler:^(NSURLResponse * _Nonnull response,
//                          id  _Nullable responseObject,
//                          NSError * _Nullable error) {
//        NSLog(@"");
//    }];
//    [task resume];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"PUT";
    [request setValue:@"image/jpeg"
   forHTTPHeaderField:@"Content-Type"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromData:UIImagePNGRepresentation(KIMG(@"0")) progress:^(NSProgress * _Nonnull uploadProgress) {
//        progressBlock(uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        completionBlock(error);
        NSLog(@"");
        
    }];
 
//    self.task = task;
 
    [task resume];
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;
{
//    switch (eventCode) {
//        // 有数据可读
//        case NSStreamEventHasBytesAvailable:
//        {
//            //读取数据并打印
//            NSMutableData *data = [[NSMutableData alloc] init];
//            uint8_t buf[2048];
//            NSInteger len = 0;
//            len = [(NSInputStream *)aStream read:buf maxLength:2048];
//            if (len) {
//                [data appendBytes:(const void *)buf length:len];
//                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@", str);
//            }else{
//                NSLog(@"no buffer");
//            }
//            break;
//        }
//        //读到了流的结尾
//        case NSStreamEventEndEncountered:{
//            // 关闭流
//            [aStream close];
//            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//            aStream = nil;
//            break;
//        }
//
//        default:
//            break;
//    }
}

//{
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"PUT";
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"0" ofType:@"png"];
//
//    NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:path];
//    inputStream.delegate = self;
//    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [inputStream open];
//
//    request.HTTPBodyStream = inputStream;
//
//    NSURLSessionUploadTask *task = [[NSURLSession sharedSession] uploadTaskWithStreamedRequest:request];
//    [task resume];
//}

@end
