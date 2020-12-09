//
//  NSObject+OpenURL.m
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import "NSObject+OpenURL.h"

@implementation NSObject (OpenURL)

///跳转系统设置
+(void)pushToSysConfig{

    [NSObject OpenURL:UIApplicationOpenSettingsURLString
              options:@{}
completionOpenSuccessHandler:^{
        //TODO
    }
completionOpenFailHandler:^{
        //TODO
    }];
}

+(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
completionOpenSuccessHandler:(NoResultBlock)openSuccessBlock
completionOpenFailHandler:(NoResultBlock)openFailBlock{
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLStr]];
    options = options ? options : @{};
    
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (canOpen) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr]
                                                   options:options
                                         completionHandler:^(BOOL success) {
                    NSLog(@"打开成功");
                    if (openSuccessBlock) {
                        openSuccessBlock();
                    }
                }];return YES;
            }else{
                if (openFailBlock) {
                    openFailBlock();
                }return NO;
            }
        }else {
            if (openFailBlock) {
                openFailBlock();
            }return NO;
        }
    }else {
        if (canOpen) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr]];
#pragma clang diagnostic pop
            return YES;
        }else{
            if (openFailBlock) {
                openFailBlock();
            }return NO;
        }
    }
}

@end
