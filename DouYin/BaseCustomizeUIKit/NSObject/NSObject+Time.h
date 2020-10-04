//
//  NSObject+Time.h
//  Feidegou
//
//  Created by Kite on 2019/12/9.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IntervalStyle) {
    intervalBySec = 0,//单位：秒
    intervalByMilliSec//单位：毫秒
};

//以应对同一时间不同格式的需求
@interface TimeFormatterModel : NSObject

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)NSString *dateStr;
@property(nonatomic,assign)NSTimeInterval intervalBySec;//单位：秒
@property(nonatomic,assign)NSTimeInterval intervalByMilliSec;//单位：毫秒
 

@end

/**
 
 NSDateFormatter常用的格式有：
 yyyy-MM-dd
 HH:mm:ss.SSS
 yyyy-MM-dd
 HH:mm:ss
 yyyy-MM-dd
 MM dd yyyy
 
 NSDateFormatter格式化参数如下：
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 
 */

@interface NSObject (Time)

#pragma mark —— 时间格式转换
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
///NSString * ---> NSDate *  (NSString *)时间 转 (NSDate *时间)
+(NSDate *)strByDate:(NSString *_Nonnull)dateStr
       timeFormatter:(NSString *_Nullable)timeFormatter;
/// NSDate * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDate:(NSDate *_Nullable)date;
/// NSTimeInterval ---> NSDate *
+(NSDate *)dateByTimeInterval:(NSTimeInterval)interval;
/// NSString * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDateStr:(NSString *_Nullable)dateStr
                         timeFormatter:(NSString *_Nullable)timeFormatter
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
#pragma mark —— 功能性的
/// 获得当前时间
+(TimeFormatterModel *)currentTime;
///判断某个时间是否为今天
+(BOOL)isToday:(NSDate *_Nonnull)date;
/// 获得今天的时间:年/月/日
/// @param dateFormat 时间格式：缺省值@"yyyy-MM-dd"
+(TimeFormatterModel *)getToday:(NSString *_Nonnull)dateFormat;
//https://www.jianshu.com/p/5f4e7fabcc02
/// iOS 获取 加上多少时间以后的时间A (NSDate *) = 基础时间（NSDate *） +  时间间隔（NSInteger）https://blog.csdn.net/weixin_34055787/article/details/91893379
+(NSDate *)getDate:(NSDate *_Nonnull)date
         afterTime:(NSInteger)afterTime;
/// 可以获得两个日期之间的时间间隔
/// @param NSString *startTime （给定） 开始时间
/// @param NSString *endTime （可以不用给定）结束时间
/// @param timeFormatter 时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"
+(TimeFormatterModel *)timeIntervalstartDate:(NSString *_Nonnull)startTime
                                     endDate:(NSString *_Nullable)endTime
                               timeFormatter:(NSString *_Nullable)timeFormatter;
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

/**
 *  判断是否当日第一次启动App
 */
//+(BOOL)isFirstLaunchApp;

+ (BOOL)isFirstLaunchApp;

@end

NS_ASSUME_NONNULL_END
