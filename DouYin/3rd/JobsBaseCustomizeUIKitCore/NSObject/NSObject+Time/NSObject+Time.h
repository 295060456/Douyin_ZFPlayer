//
//  NSObject+Time.h
//  Feidegou
//
//  Created by Kite on 2019/12/9.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Time.h"
#import "TimeModel.h"
#import "UserDefaultManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Time)

#pragma mark —— 时间格式转换
/// 接受一个秒数，对这个秒数进行解析出：时、分、秒，存入TimeModel，外层再对这个TimeModel进行取值，对数据进行拼装
+(TimeModel *)HHMMSS:(NSInteger)TimeSec;
/// 将某个（NSDate *）时间 转换格式
/// @param date 一个指定的时间，若未指定则为当前时间
/// @param timeFormatStr 时间格式 缺省值 @"MMM dd,yyyy HH:mm tt"
+(TimeFormatterModel *)timeFormatterWithDate:(NSDate *_Nullable)date
                               timeFormatStr:(NSString *_Nullable)timeFormatStr;
/// NSDate * ---> NSString *   (NSDate*)时间 转 (NSString*)时间戳（毫秒级）
/// @param date 不传值则为当前时间
+(NSString *)dateConversionTimeStamp:(NSDate *_Nullable)date
                       timeFormatStr:(NSString *_Nullable)timeFormatStr
                       intervalStyle:(IntervalStyle)intervalStyle;
/// NSTimeInterval ---> NSString *
+(NSString *)timeIntervalByInterval:(NSTimeInterval)interval;
/// NSString * ---> NSString *   格式转换为   小时：分钟：秒
/// @param totalTime 传入 秒
+(NSString *)getHHMMSSFromStr:(NSString *_Nonnull)totalTime;
/// NSString * ---> NSString * 格式转换为  分钟：秒
/// @param totalTime 传入 秒
+(NSString *)getMMSSFromStr:(NSString *_Nonnull)totalTime;
/// 转换为指定时间格式（时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"、毫秒级
/// @param timeStamp 时间戳
/// @param timeFormatter  时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"
+(NSString *)timeStampConversionNSString:(NSString *_Nonnull)timeStamp
                           timeFormatter:(NSString *_Nullable)timeFormatter
                           intervalStyle:(IntervalStyle)intervalStyle;

//以当前手机系统时间（包含了时区）为基准，给定一个日期偏移值（正值代表未来，负值代表过去，0代表现在），返回字符串特定格式的“星期几”
+(NSString *)whatDayOfWeekDistanceNow:(NSInteger)offsetDay;
/// 获取一个格式化的字符串时间
/// @param date 传空则是当前iOS系统时间
/// @param dateFormatStr 传空则格式是@"yyyy-MM-dd HH:mm:ss zzz"
+(NSString *)getDayWithDate:(NSDate *_Nullable)date
              dateFormatStr:(NSString *_Nullable)dateFormatStr;
/// NSDate 和 NSString相互转换
+(NSString *)dateString:(NSDate *)date
       dateFormatterStr:(NSString *)dateFormatterStr;
/// NSDate * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDate:(NSDate *_Nullable)date;
/// NSString * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDateStr:(NSString *_Nullable)dateStr
                         timeFormatter:(NSString *_Nullable)timeFormatter
                         intervalStyle:(IntervalStyle)intervalStyle;
/// NSTimeInterval ---> NSDate *
+(NSDate *)dateByTimeInterval:(NSTimeInterval)interval;
///NSString * ---> NSDate *  (NSString *)时间 转 (NSDate *时间)
+(NSDate *)strByDate:(NSString *_Nonnull)dateStr
       timeFormatter:(NSString *_Nullable)timeFormatter;
#pragma mark —— 功能性的
+(TimeModel *)makeSpecificTime;//各个具体时间的拆解
/// 获得当前时间
+(TimeFormatterModel *)currentTime;
/// 获得今天的时间:年/月/日
/// @param dateFormat 时间格式：缺省值@"yyyy-MM-dd"
+(TimeFormatterModel *)getToday:(NSString *_Nullable)dateFormat;
/// 可以获得两个日期之间的时间间隔
/// @param startTime （给定） 开始时间【字符串格式】
/// @param endTime （可以不用给定）结束时间【字符串格式】
/// @param timeFormatter 时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"
+(TimeFormatterModel *)timeIntervalstartDate:(NSString *_Nonnull)startTime
                                     endDate:(NSString *_Nullable)endTime
                               timeFormatter:(NSString *_Nullable)timeFormatter;
//https://www.jianshu.com/p/5f4e7fabcc02
/// iOS 获取 加上多少时间以后的时间A (NSDate *) = 基础时间（NSDate *） +  时间间隔（NSInteger）https://blog.csdn.net/weixin_34055787/article/details/91893379
+(NSDate *)getDate:(NSDate *_Nonnull)date
  afterIntegerTime:(NSInteger)afterIntegerTime;
/// 以当前时间为基准，加上某个时间间隔（NSTimeInterval类型）以后的NSData值
+(NSDate *)getDateFromCurrentAfterTimeInterval:(NSTimeInterval)timeInterval;
/// 计算两字符串时间的差值【方法一】
-(NSTimeInterval)intervalDifferenceBetweenStarTime:(NSString *)starTime
                                         toEndTime:(NSString *)endTime
                                   byDateFormatter:(NSDateFormatter *)dateFormatter;
/// 计算两字符串时间的差值【方法二】
-(NSDateComponents *)dateComponentsDiffBetweenStarTime:(NSString *)starTime
                                             toEndTime:(NSString *)endTime
                                       byDateFormatter:(NSDateFormatter *)dateFormatter;
///  在当前日期时间加上 某个时间段(传负数即返回当前时间之前x月x日的时间)  https://blog.csdn.net/autom_lishun/article/details/79094241
/// @param year 当前时间若干年后 （传负数为当前时间若干年前）
/// @param month 当前时间若干月后  （传0即与当前时间一样）
/// @param day 当前时间若干天后
/// @param hour 当前时间若干小时后
/// @param minute 当前时间若干分钟后
/// @param second 当前时间若干秒后
+(NSArray *)dateStringAfterlocalDateForYear:(NSInteger)year
                                      Month:(NSInteger)month
                                        Day:(NSInteger)day
                                       Hour:(NSInteger)hour
                                     Minute:(NSInteger)minute
                                     Second:(NSInteger)second
                              timeFormatter:(NSString *_Nullable)timeFormatter;
///判断是否当日第一次启动App
+(BOOL)isFirstLaunchApp;
///判断某个时间是否为今天
+(BOOL)isToday:(NSDate *_Nonnull)date;


@end

NS_ASSUME_NONNULL_END
