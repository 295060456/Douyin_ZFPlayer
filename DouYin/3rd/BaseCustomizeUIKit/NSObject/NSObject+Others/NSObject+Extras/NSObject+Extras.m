//
//  NSObject+Extras.m
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import "NSObject+Extras.h"

@implementation NSObject (Extras)
///震动特效反馈
+(void)feedbackGenerator{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    } else {
        // Fallback on earlier versions
        AudioServicesPlaySystemSound(1520);
    }
}
///检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
+(BOOL)didUserPressLockButton{
    //获取屏幕亮度
    CGFloat oldBrightness = [UIScreen mainScreen].brightness;
    //以较小的数量改变屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01));
    CGFloat newBrightness  = [UIScreen mainScreen].brightness;
    //恢复屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness;
    //判断屏幕亮度是否能够被改变
    return oldBrightness != newBrightness;
}
///iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch{
    [[UIApplication sharedApplication] setIdleTimerDisabled:lockSwitch];
}
/// 打印请求体
+(void)printRequestMessage:(NSURLSessionDataTask *)task{
    // 请求URL
    NSLog(@"请求URL:%@\n",task.originalRequest.URL);
    
    // 请求方式
    NSLog(@"请求方式:%@\n",task.originalRequest.HTTPMethod);
    
    // 请求头信息
    NSLog(@"请求头信息:%@\n",task.originalRequest.allHTTPHeaderFields);
    
    // 请求正文信息
    NSLog(@"请求正文信息:%@\n",[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    
//    // 请求响应时间
//    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:NSDate.date];
//    NSLog(@"请求响应时间:%@\n",@(time));
//    NSLog(@"\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求正文信息:%@\n请求响应时间:%@\n",task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
}

+(void)savePic:(GKPhotoBrowser *)browser{
    if (browser) {
        GKPhoto *photo = browser.photos[browser.currentIndex];
        
        NSData *imageData = nil;
        
        if ([photo.image isKindOfClass:[SDAnimatedImage class]]) {
            imageData = [(SDAnimatedImage *)photo.image animatedImageData];
        }else if ([photo.image isKindOfClass:[YYImage class]]) {
            imageData = [(YYImage *)photo.image animatedImageData];
        }else {
            imageData = [photo.image sd_imageData];
        }
        
        if (!imageData) return;
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            if (@available(iOS 9, *)) {
                PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
                [request addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                request.creationDate = [NSDate date];
            }
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"保存照片成功");
                    [WHToast showSuccessWithMessage:@"图片保存成功"
                                           duration:2
                                      finishHandler:^{}];
                } else if (error) {
                    [WHToast showErrorWithMessage:@"保存保存失败"
                                         duration:2
                                    finishHandler:^{}];
                    NSLog(@"保存照片出错:%@",error.localizedDescription);
                }
            });
        }];
    }else{
        NSLog(@"GKPhotoBrowser * 为空");
    }
}

@end
