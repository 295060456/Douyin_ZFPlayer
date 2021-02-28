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
//软性打开URL：【不会处理打开成功和打开失败两种情况】如果URL有误无法打开则就这样
+(void)OpenURL:(NSString *)URLStr;
//硬性打开URL：【会处理打开成功和打开失败两种情况】如果URL有误，可以做其他事，比如打开一个备用URL
+(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
completionOpenSuccessHandler:(NoResultBlock _Nullable)openSuccessBlock
completionOpenFailHandler:(NoResultBlock _Nullable)openFailBlock;

@end

NS_ASSUME_NONNULL_END
