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
    [NSObject OpenURL:UIApplicationOpenSettingsURLString];
}
//软性打开URL：【不会处理打开成功和打开失败两种情况】如果URL有误无法打开则就这样
+(void)OpenURL:(NSString *)URLStr{
    [NSObject OpenURL:URLStr
              options:@{}
completionOpenSuccessHandler:nil
completionOpenFailHandler:nil];
}
//硬性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
+(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
completionOpenSuccessHandler:(NoResultBlock _Nullable)openSuccessBlock
completionOpenFailHandler:(NoResultBlock _Nullable)openFailBlock{
    
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
            SuppressWdeprecatedDeclarationsWarning([[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr]]);
            return YES;
        }else{
            if (openFailBlock) {
                openFailBlock();
            }return NO;
        }
    }
}

@end
