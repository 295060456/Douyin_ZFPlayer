//
//  BaseVC+OpenURL.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+OpenURL.h"
#import <objc/runtime.h>

@implementation BaseVC (OpenURL)

///跳转系统设置
-(void)pushToSysConfig{
    [self OpenURL:UIApplicationOpenSettingsURLString
          options:@{}
         showText:@""
        superView:self.view
        useAssert:NO
completionHandler:^{
        //TODO
    }];
}

-(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
      showText:(NSString *)showTextStr
     superView:(UIView *)superView
     useAssert:(BOOL)isuseAssert
completionHandler:(NoResultBlock)openSuccessBlock{
    
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLStr]];
    showTextStr = [NSString ensureNonnullString:showTextStr ReplaceStr:@"打开失败"];
    options = options ? options :@{};
    
    NoResultBlock block = ^(){
        NSLog(@"打开失败");
        if (isuseAssert) {
            NSAssert(canOpen,@"打开失败");
        }else{
            [MBProgressHUD wj_showPlainText:showTextStr view:superView];
        }
    };
    
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
                }];
                return YES;
            }else{
                if (block) {
                    block();
                }
                return NO;
            }
        }else {
            if (block) {
                block();
            }
            return NO;
        }
    }else {
        if (canOpen) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr]];
            return YES;
        }else{
            if (block) {
                block();
            }
            return NO;
        }
    }
}

@end
