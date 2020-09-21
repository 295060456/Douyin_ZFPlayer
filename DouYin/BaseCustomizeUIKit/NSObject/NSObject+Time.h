//
//  NSObject+Time.h
//  Feidegou
//
//  Created by Kite on 2019/12/9.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Time)

/**
 *  ** 在当前日期时间加上 某个时间段(传负数即返回当前时间之前x月x日的时间)
 *  @param year   当前时间若干年后 （传负数为当前时间若干年前）
 *  @param month  当前时间若干月后  （传0即与当前时间一样）
 *  @param day  当前时间若干天后
 *  @param hour   当前时间若干小时后
 *  @param minute 当前时间若干分钟后
 *  @param second 当前时间若干秒后
 *  @return 处理后的时间字符串
 */
+(NSArray *)dateStringAfterlocalDateForYear:(NSInteger)year
                                       Month:(NSInteger)month
                                         Day:(NSInteger)day
                                        Hour:(NSInteger)hour
                                      Minute:(NSInteger)minute
                                      Second:(NSInteger)second;

+(NSDate *)getDate:(NSDate *)date
         afterTime:(NSInteger)afterTime;
///当前时间
+(NSDate *)currentTime;

+(NSString *)getToday;
///传入 秒  得到 xx:xx:xx
+(NSString *)getHHMMSSFromStr:(NSString *)totalTime;
///传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromStr:(NSString *)totalTime;
///开始时间给定 结束时间不给定就启用现在的时间戳
+(NSTimeInterval)timeIntervalstartDate:(NSString *_Nonnull)startTime
                               endDate:(NSString *_Nullable)endTime
                         timeFormatter:(NSDateFormatter *_Nullable)timeFormatter;
///时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp;
///时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date;
///字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;

@end

NS_ASSUME_NONNULL_END
