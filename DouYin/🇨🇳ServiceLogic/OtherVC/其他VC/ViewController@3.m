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

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{

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
    
    [self PUT:@"https://www.bombom999.top/my-bucketname/images/iosimage.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minio%2F20201023%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20201023T084512Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c9416cd5b090bccf44f08dff3b4776cfc06088f47b5e34211a59ecf669004bb5"
   parameters:nil
     progress:nil
      success:nil
      failure:nil];
    
    
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
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
  

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT"
                                                                                              URLString:URLString
                                                                                             parameters:nil
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"];
//
//        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:path];
//        inputStream.delegate = self;
//        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [inputStream open];
//
//        [formData appendPartWithInputStream:inputStream
//                                       name:@"file"
//                                   fileName:@"111"
//                                     length:UIImagePNGRepresentation(KIMG(@"0")).length
//                                   mimeType:@"image/jpeg"];
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(KIMG(@"0"))
                                    name:@"file"
                                fileName:@"image"
                                mimeType:@"image/jpeg"];

    } error:nil];

    [request setValue:@"image/jpeg"
   forHTTPHeaderField:@"Content-Type"];

    NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request
                                                                 progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
    } completionHandler:^(NSURLResponse * _Nonnull response,
                          id  _Nullable responseObject,
                          NSError * _Nullable error) {
        NSLog(@"");
    }];
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
