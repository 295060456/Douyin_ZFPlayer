//
//  NSObject+Time.m
//  Feidegou
//
//  Created by Kite on 2019/12/9.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "NSObject+Time.h"

@implementation NSObject (Time)

#pragma mark —— 时间格式转换
/// 将某个（NSDate *）时间 转换格式
/// @param date 一个指定的时间，若未指定则为当前时间
/// @param timeFormatStr 时间格式 缺省值 @"MMM dd,yyyy HH:mm tt"
+(TimeFormatterModel *)timeFormatterWithDate:(NSDate *_Nullable)date
                               timeFormatStr:(NSString *_Nullable)timeFormatStr{
    
    TimeFormatterModel *timeModel = TimeFormatterModel.new;
    
    NSDateFormatter *dateFormatter = NSDateFormatter.new;
    //设定时间格式,这里可以设置成自己需要的格式
    if([NSString isNullString:timeFormatStr]){
        dateFormatter.dateFormat = @"MMM dd,yyyy HH:mm tt";
    }else{
        dateFormatter.dateFormat = timeFormatStr;
    }
    
    if(!date){
        date = NSDate.date;
    }
    
    timeModel.date = date;//时间字符串NSDate
    timeModel.dateStr = [dateFormatter stringFromDate:date];//NSDate转时间字符串
    timeModel.intervalBySec = [date timeIntervalSince1970];//(NSDate *)时间转时间戳 单位：秒
    timeModel.intervalByMilliSec = intervalBySec * 1000;//(NSDate *)时间转时间戳 单位：毫秒
    
    return timeModel;
}
/// NSDate * ---> NSString *   (NSDate*)时间 转 (NSString*)时间戳（毫秒级）
/// @param date 不传值则为当前时间
+(NSString *)dateConversionTimeStamp:(NSDate *_Nullable)date
                       timeFormatStr:(NSString *_Nullable)timeFormatStr
                       intervalStyle:(IntervalStyle)intervalStyle{
    if (!date) {
        date = NSDate.date;
    }
    
    NSDateFormatter *dateFormatter = NSDateFormatter.new;
    
    //设定时间格式,这里可以设置成自己需要的格式
    if([NSString isNullString:timeFormatStr]){
        dateFormatter.dateFormat = @"MMM dd,yyyy HH:mm tt";
    }else{
        dateFormatter.dateFormat = timeFormatStr;
    }
    
    NSString *timeSp = nil;
    if (intervalStyle == intervalBySec) {
        
//        [dateFormatter stringFromDate:date];
        
        timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    }else if(intervalStyle == intervalByMilliSec){
        timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970] * 1000];
    }
    return timeSp;
}
///NSString * ---> NSDate *  (NSString *)时间 转 (NSDate *时间)
+(NSDate *)strByDate:(NSString *_Nonnull)dateStr
       timeFormatter:(NSString *_Nullable)timeFormatter{
    NSDateFormatter *dateFormatter = NSDateFormatter.new;
    
    if ([NSString isNullString:timeFormatter]) {
        dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }else{
        dateFormatter.dateFormat = timeFormatter;
    }
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
/// NSDate * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDate:(NSDate *_Nullable)date{
    if(!date){
        date = NSDate.date;
    }
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
}
/// NSTimeInterval ---> NSDate *
+(NSDate *)dateByTimeInterval:(NSTimeInterval)interval{
    NSDate *date = nil;
    if(interval == 0){
        date = NSDate.date;
    }else{
        date = [NSDate dateWithTimeIntervalSince1970:interval];
    }
    return date;
}
/// NSString * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDateStr:(NSString *_Nullable)dateStr
                         timeFormatter:(NSString *_Nullable)timeFormatter
                         intervalStyle:(IntervalStyle)intervalStyle{
    NSTimeInterval interval = 0;
    if (intervalStyle == intervalBySec) {
        interval = [[NSObject strByDate:dateStr timeFormatter:timeFormatter] timeIntervalSince1970];
    }else if (intervalStyle == intervalByMilliSec){
        interval = [[NSObject strByDate:dateStr timeFormatter:timeFormatter] timeIntervalSince1970] * 1000;
    }else{}
    return interval;
}
/// NSTimeInterval ---> NSString *
+(NSString *)timeIntervalByInterval:(NSTimeInterval)interval{
    NSString *intervalStr = [NSObject dateConversionTimeStamp:[NSObject dateByTimeInterval:interval]
                                                timeFormatStr:nil
                                                intervalStyle:intervalBySec];
    return intervalStr;
}
/// NSString * ---> NSString *   格式转换为   小时：分钟：秒
/// @param totalTime 传入 秒
+(NSString *)getHHMMSSFromStr:(NSString *_Nonnull)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}
/// NSString * ---> NSString * 格式转换为  分钟：秒
/// @param totalTime 传入 秒
+(NSString *)getMMSSFromStr:(NSString *_Nonnull)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}
/// 转换为指定时间格式（时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"、毫秒级
/// @param timeStamp 时间戳
/// @param timeFormatter  时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"
+(NSString *)timeStampConversionNSString:(NSString *_Nonnull)timeStamp
                           timeFormatter:(NSString *_Nullable)timeFormatter
                           intervalStyle:(IntervalStyle)intervalStyle{
    NSDate *date = nil;
    if (intervalStyle == intervalBySec) {
        date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    }else if(intervalStyle == intervalByMilliSec){
        date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue] / 1000];
    }
    NSDateFormatter *formatter = NSDateFormatter.new;
    
    if ([NSString isNullString:timeFormatter]) {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }else{
        formatter.dateFormat = timeFormatter;
    }
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
#pragma mark —— 功能性的
/// 获得当前时间
+(TimeFormatterModel *)currentTime{
    NSDate *date = NSDate.date;
    NSTimeZone *zone = NSTimeZone.systemTimeZone;// 系统时区
    TimeFormatterModel *timeModel = TimeFormatterModel.new;
    
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];//??
    NSDate *currentDate = [date dateByAddingTimeInterval:interval];
    NSString *currentStr = [NSObject dateConversionTimeStamp:currentDate
                                               timeFormatStr:nil
                                               intervalStyle:intervalBySec];
    
    timeModel.date = currentDate;
    timeModel.dateStr = currentStr;
    timeModel.intervalBySec = interval;

    return timeModel;
}
///判断某个时间是否为今天
+(BOOL)isToday:(NSDate *_Nonnull)date{
    NSDateFormatter *fmt = NSDateFormatter.new;
    fmt.timeZone = NSTimeZone.systemTimeZone; // 系统时区
    fmt.dateStyle = NSDateFormatterMediumStyle;
    fmt.timeStyle = NSDateFormatterShortStyle;
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:NSDate.date];// NOW
    
    return [dateStr isEqualToString:nowStr];
}
/// 获得今天的时间:年/月/日
/// @param dateFormat 时间格式：缺省值@"yyyy-MM-dd"
+(TimeFormatterModel *)getToday:(NSString *_Nonnull)dateFormat{
    
    NSDateFormatter *formatter = NSDateFormatter.new;
    
    if ([NSString isNullString:dateFormat]) {
        formatter.dateFormat = @"yyyy-MM-dd";
    }else{
        formatter.dateFormat = dateFormat;
    }
    
    NSTimeZone *zone = NSTimeZone.systemTimeZone;// 系统时区
    
    NSString *dateTime_Str = [formatter stringFromDate:NSDate.date];//今天
    NSDate *dateTime_Date = [formatter dateFromString:dateTime_Str];
    NSTimeInterval interval = [zone secondsFromGMTForDate:NSDate.date];
    
    TimeFormatterModel *timeModel = TimeFormatterModel.new;
    timeModel.dateStr = dateTime_Str;
    timeModel.date = dateTime_Date;
    timeModel.intervalBySec = interval;
    timeModel.intervalByMilliSec = timeModel.intervalBySec * 1000;
    
    return timeModel;
}
//https://www.jianshu.com/p/5f4e7fabcc02
/// iOS 获取 加上多少时间以后的时间A (NSDate *) = 基础时间（NSDate *） +  时间间隔（NSInteger）https://blog.csdn.net/weixin_34055787/article/details/91893379
+(NSDate *)getDate:(NSDate *_Nonnull)date
         afterTime:(NSInteger)afterTime{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = NSDateComponents.new;
    offsetComponents.hour = afterTime;
    NSDate *resultDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:date
                                                   options:0];
    return resultDate;
}
/// 可以获得两个日期之间的时间间隔
/// @param startTime （给定） 开始时间
/// @param endTime （可以不用给定）结束时间
/// @param timeFormatter 时间格式：缺省值@"yyyy-MM-dd HH:mm:ss"
+(TimeFormatterModel *)timeIntervalstartDate:(NSString *_Nonnull)startTime
                                     endDate:(NSString *_Nullable)endTime
                               timeFormatter:(NSString *_Nullable)timeFormatter{

    if ([NSString isNullString:timeFormatter]) {
        timeFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = NSDateFormatter.new;
    dateFormatter.dateFormat = timeFormatter;
    NSDate *startDate = [dateFormatter dateFromString:startTime];
    NSDate *endDate = nil;
    if ([NSString isNullString:endTime]) {
        NSString *now = [dateFormatter stringFromDate:NSDate.date];
        endDate = [dateFormatter dateFromString:now];
    }else{
        endDate = [dateFormatter dateFromString:endTime];
    }
    
    TimeFormatterModel *timeModel = TimeFormatterModel.new;
    timeModel.intervalBySec = [endDate timeIntervalSinceDate:startDate];
    timeModel.intervalByMilliSec = timeModel.intervalBySec * 1000;
    
    return timeModel;
}
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
                              timeFormatter:(NSString *_Nullable)timeFormatter{
    NSDate *localDate = NSDate.date;
    NSDateComponents *comps = NSDateComponents.new;
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *minDate = [calender dateByAddingComponents:comps
                                                toDate:localDate
                                               options:0];
    NSDateFormatter *formatter = NSDateFormatter.new;
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    if ([NSString isNullString:timeFormatter]) {
        formatter.dateFormat = @"YYYY-MM-dd HH";
    }else{
        formatter.dateFormat = timeFormatter;
    }

    NSDateComponents *components = [calender components:NSCalendarUnitYear|
                                                       NSCalendarUnitMonth|
                                                         NSCalendarUnitDay|
                                                        NSCalendarUnitHour
                                               fromDate:minDate];
    NSInteger thisYear = components.year;
    NSInteger thisMonth = components.month;
    NSInteger thisDay = components.day;
    NSInteger thisHour = components.hour;
    NSString *DateTime = [NSString stringWithFormat:@"%ld-%ld-%ld-%ld",(long)thisYear,(long)thisMonth,(long)thisDay,(long)thisHour];
    NSArray *array = [DateTime componentsSeparatedByString:@"-"];
    return array;
}

/**
 *  判断是否当日第一次启动App
 */
//+(BOOL)isFirstLaunchApp{
//
//    NSDateFormatter *format = [[NSDateFormatter alloc]init];
//    [format setDateFormat:@"yyyy-MM-dd"];
//
//    //取本机时间
//    NSDate *date_localMachine = [NSDate date];
//    BOOL c = [[NSCalendar currentCalendar] isDateInToday:date_localMachine];//永真
//    //----------将nsdate按formatter格式转成nsstring
//    NSString *currentTimeString = [format stringFromDate:date_localMachine];
//
//    //取本地数据库中时间
//    NSDate *date_local = [format dateFromString:GetUserDefaultWithKey(@"daytime")];
//    NSString *currentTimeString_0 = [format stringFromDate:date_local];
//    BOOL b = [[NSCalendar currentCalendar] isDateInToday:date_local];
//
//
//    NSString *str_1 = GetUserDefaultWithKey(@"daytime");
//    //更新本地记录
//    SetUserDefaultKeyWithObject(@"daytime",[NSString getTimeString:currentTimeString]);
//    UserDefaultSynchronize;
//
//    //再取本地数据库时间
//
//    NSString *str_0 = GetUserDefaultWithKey(@"daytime");
//
//    NSDate *date_local_01 = [format dateFromString:GetUserDefaultWithKey(@"daytime")];
//    NSString *currentTimeString_01 = [format stringFromDate:date_local_01];
//
//    if (c != b ) {//第一次
//        return YES;
//    }else return NO;
//}

+ (BOOL)isFirstLaunchApp{
    BOOL flag;
    
//    NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"APPFirstStartKey"];

    NSDate *oldDate = GetUserDefaultObjForKey(@"APPFirstStartKey");

    UserDefaultSynchronize;
    
    if (oldDate == nil) {
        NSLog(@"未启动过，第一次启动");
        flag = YES;
    }else {
        if ([self isToday:oldDate]) {
            NSLog(@"今日  已启动过");
            flag = NO;
        }else {
            NSLog(@"今天第一次启动");
            flag = YES;
        }
    }
    // 保存启动时间
//    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"APPFirstStartKey"];
    
    SetUserDefaultKeyWithObject(@"APPFirstStartKey",[NSDate date]);
    UserDefaultSynchronize;
    return flag;
}

@end

@implementation TimeFormatterModel

@end
