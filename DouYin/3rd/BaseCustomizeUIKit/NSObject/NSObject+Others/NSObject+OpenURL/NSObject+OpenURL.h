//
//  NSObject+OpenURL.h
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OpenURL)

///跳转系统设置
+(void)pushToSysConfig;
///对OpenURL的处理
+(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
completionOpenSuccessHandler:(NoResultBlock)openSuccessBlock
completionOpenFailHandler:(NoResultBlock)openFailBlock;

@end

NS_ASSUME_NONNULL_END
