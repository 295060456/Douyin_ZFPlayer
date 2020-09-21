//
//  BaseVC+OpenURL.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (OpenURL)

///跳转系统设置
-(void)pushToSysConfig;
///对OpenURL的处理
-(BOOL)OpenURL:(NSString *)URLStr
       options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options
      showText:(NSString *)showTextStr
     superView:(UIView *)superView
     useAssert:(BOOL)isuseAssert
completionHandler:(NoResultBlock)openSuccessBlock;

@end

NS_ASSUME_NONNULL_END
