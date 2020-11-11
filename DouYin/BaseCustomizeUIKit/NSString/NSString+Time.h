//
//  NSString+Time.h
//  JobsIM
//
//  Created by Jobs on 2020/11/11.
//

#import <Foundation/Foundation.h>
#import "TimeModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 此分类主要是为了管理时间获取
@interface NSString (Time)

/// NSDate 和 NSString相互转换
+(NSString *)dateString:(NSDate *)date
       dateFormatterStr:(NSString *)dateFormatterStr;
/// 接受一个秒数，对这个秒数进行解析出：时、分、秒，存入TimeModel，外层再对这个TimeModel进行取值，对数据进行拼装
+(TimeModel *)HHMMSS:(NSInteger)TimeSec;

@end

NS_ASSUME_NONNULL_END
