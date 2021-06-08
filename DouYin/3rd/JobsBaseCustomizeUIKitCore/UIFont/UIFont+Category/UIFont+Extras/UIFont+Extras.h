//
//  UIFont+Extras.h
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Extras)

+(NSMutableArray *)getAvailableFont;/// 打印全员字体
+(NSMutableArray <NSString *>*)foreignAidFontName;/// 打印外援字体

@end

NS_ASSUME_NONNULL_END
