//
//  ZFMRACNetworkTool.h
//  ZFMRACNetwork
//
//  Created by todriver02 on 2018/8/1.
//  Copyright © 2018年 zhufaming. All rights reserved.
//

#ifndef ZFMRACNetworkTool_h
#define ZFMRACNetworkTool_h

#import "FMHttpConstant.h"//网络请求相关的宏定义
#import "FMHttpResonse.h"//请求相关的参数配置
#import "FMHttpRequest.h"//网络请求响应的，信号返回的数据模型
#import "FMARCNetwork.h"//网络请求主要的工具类

#endif /* ZFMRACNetworkTool_h */

/* 使用示例:
 //一般传参
- (void)test{
    /// 
    NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
    ///  #define MH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:@"Room/GetHotLive_v2"
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"%p",response.reqResult);
            NSLog(@"--%@",response.reqResult);
        }
    }];
}
 //上传图片
 -(void)uploadPic_producingArea_havePaid_netWorking:(UIImage *)image{
     NSString *randomStr = [EncryptUtils shuffledAlphabet:16];
     __block NSData *picData = [UIImage imageZipToData:image];
     ModelLogin *modelLogin;
     if ([[PersonalInfo sharedInstance] isLogined]) {
         modelLogin = [[PersonalInfo sharedInstance] fetchLoginUserInfo];
     }
     NSDictionary *dataDic = @{
         @"order_id":self.Order_id,
         @"user_id":modelLogin.userId,
         @"identity":[YDDevice getUQID]
     };
     
     NSDictionary *dic = @{
         @"data":aesEncryptString([NSString convertToJsonData:dataDic], randomStr),
         @"key":[RSAUtil encryptString:randomStr
                             publicKey:RSA_Public_key],
         @"randomStr":randomStr
     };
     
     self.reqSignal = [[FMARCNetwork sharedInstance] uploadNetworkPath:CatfoodCO_payURL
                                                                params:dic
                                                             fileDatas:@[picData]
                                                                  name:@"test.png"
                                                              mimeType:@"image/png"];
     @weakify(self)
     [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
         @strongify(self)
         NSDictionary *dic = [NSString dictionaryWithJsonString:aesDecryptString(response.reqResult, randomStr)];
         NSLog(@"%@",dic);
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             Toast(dic[@"message"]);
         }];
         if ([dic[@"code"] intValue] == 200) {
                     NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *vc = vcArr[2];
             [self.navigationController popToViewController:vc animated:YES];
         }
     }];
 }

*/
