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
///接受一个秒数，对这个秒数进行解析出：时、分、秒，存入TimeModel，外层再对这个TimeModel进行取值，对数据进行拼装
+(TimeModel *)HHMMSS:(NSInteger)TimeSec{
    TimeModel *timeModel = TimeModel.new;
    //format of hour
    timeModel.customHour = [NSString stringWithFormat:@"%02ld",TimeSec / 3600].integerValue;
    //format of minute
    timeModel.customMin = [NSString stringWithFormat:@"%02ld",(TimeSec % 3600) / 60].integerValue;
    //format of second
    timeModel.customSec = [NSString stringWithFormat:@"%02ld",TimeSec % 60].integerValue;
    return timeModel;
}
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
//以当前手机系统时间（包含了时区）为基准，给定一个日期偏移值（正值代表未来，负值代表过去，0代表现在），返回字符串特定格式的“星期几”
+(NSString *)whatDayOfWeekDistanceNow:(NSInteger)offsetDay{
    TimeModel *timeModel = [TimeModel makeSpecificTime];
    NSInteger currentWeekday = timeModel.currentWeekday;//当前时间是周几？1代表周日 2代表周一 7代表周六
    NSInteger offsetResDay = currentWeekday + offsetDay;//偏移量以后的值，对这个值进行分析和讨论
    NSInteger resResWeekDay = 0;//处理的结果落在0~6
    
    if (offsetDay > 0) {//未来
        resResWeekDay = offsetResDay % 7;
    }else if (offsetDay < 0){//昨天
        if (offsetResDay > 0) {
            resResWeekDay = offsetResDay % 7;
        }else if (offsetResDay < 0){
            resResWeekDay = (7 + offsetResDay % 7) % 7;//核心算法
        }else{// offsetResDay == 0
            resResWeekDay = currentWeekday;
        }
    }else{// offsetDay == 0 现在
        resResWeekDay = currentWeekday;
    }

    switch (resResWeekDay) {
        case 0:{
            return @"星期六";
        }break;
        case 1:{
            return @"星期日";
        }break;
        case 2:{
            return @"星期一";
        }break;
        case 3:{
            return @"星期二";
        }break;
        case 4:{
            return @"星期三";
        }break;
        case 5:{
            return @"星期四";
        }break;
        case 6:{
            return @"星期五";
        }break;
            
        default:
            return @"异常数据";
            break;
    }
}
/// 获取一个格式化的字符串时间
/// @param date 传空则是当前iOS系统时间
/// @param dateFormatStr 传空则格式是@"yyyy-MM-dd HH:mm:ss zzz"
+(NSString *)getDayWithDate:(NSDate *_Nullable)date
              dateFormatStr:(NSString *_Nullable)dateFormatStr{
    if (!date) {
        date = TimeModel.new.currentDate;
    }
    
    NSDateFormatter *dateFormatter = nil;
    if ([NSString isNullString:dateFormatStr]) {
        dateFormatter = TimeModel.new.dateFormatter;
    }else{
        dateFormatter = NSDateFormatter.new;
        dateFormatter.dateFormat = dateFormatStr;
    }return [dateFormatter stringFromDate:date];
}
/// NSDate 和 NSString相互转换
+(NSString *)dateString:(NSDate *)date
       dateFormatterStr:(NSString *)dateFormatterStr{
    TimeModel *timeModel = TimeModel.new;
    timeModel.customDate = date;
    timeModel.dateFormatterStr = dateFormatterStr;
    //NSDate 转 NSString
    NSString *dateString = @"";
    if (timeModel.customDate) {
        dateString = [timeModel.dateFormatter stringFromDate:timeModel.customDate];
    }else{
        dateString = [timeModel.dateFormatter stringFromDate:timeModel.currentDate];
    }return dateString;
}
/// NSDate * ---> NSTimeInterval
+(NSTimeInterval)timeIntervalByDate:(NSDate *_Nullable)date{
    if(!date){
        date = NSDate.date;
    }
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
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
#pragma mark —— 功能性的
//各个具体时间的拆解
+(TimeModel *)makeSpecificTime{
    NSCalendar *calendar = NSCalendar.currentCalendar;
    NSUInteger unitFlags;
    
    if (@available(iOS 8.0, *)) {
        unitFlags = NSCalendarUnitEra |
        NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond |
        NSCalendarUnitWeekday |
        NSCalendarUnitWeekdayOrdinal |
        NSCalendarUnitQuarter |
        NSCalendarUnitWeekOfMonth |
        NSCalendarUnitWeekOfYear |
        NSCalendarUnitYearForWeekOfYear |
        NSCalendarUnitNanosecond |
        NSCalendarUnitCalendar |
        NSCalendarUnitTimeZone;
    }else{
        SuppressWdeprecatedDeclarationsWarning(unitFlags = NSEraCalendarUnit |
                                               NSYearCalendarUnit |
                                               NSMonthCalendarUnit |
                                               NSDayCalendarUnit |
                                               NSHourCalendarUnit |
                                               NSMinuteCalendarUnit |
                                               NSSecondCalendarUnit |
                                               NSWeekCalendarUnit |
                                               NSWeekdayCalendarUnit |
                                               NSWeekdayOrdinalCalendarUnit |
                                               NSQuarterCalendarUnit |
                                               NSWeekOfMonthCalendarUnit |
                                               NSWeekOfYearCalendarUnit |
                                               NSYearForWeekOfYearCalendarUnit |
                                               NSCalendarCalendarUnit |
                                               NSTimeZoneCalendarUnit);
    }
    
    TimeModel *timeModel = TimeModel.new;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags
                                                  fromDate:timeModel.currentDate];
    timeModel.currentEra = dateComponent.era;
    timeModel.currentYear = dateComponent.year;
    timeModel.currentMonth = dateComponent.month;
    timeModel.currentDay = dateComponent.day;
    timeModel.currentHour = dateComponent.hour;
    timeModel.currentMin = dateComponent.minute;
    timeModel.currentSec = dateComponent.second;
    timeModel.currentNanoSec = dateComponent.nanosecond;//API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0))
    timeModel.currentWeekday = dateComponent.weekday;//表示周里面的天 1代表周日 2代表周一 7代表周六
    timeModel.currentWeekdayOrdinal = dateComponent.weekdayOrdinal;
    timeModel.currentQuarter = dateComponent.quarter;//API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
    timeModel.currentWeekOfMonth = dateComponent.weekOfMonth;//API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0))
    timeModel.currentWeekOfYear = dateComponent.weekOfYear;//API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0));
    timeModel.currentYearForWeekOfYear = dateComponent.yearForWeekOfYear;//API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0));
    return timeModel;
}
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
/// 获得今天的时间:年/月/日
/// @param dateFormat 时间格式：缺省值@"yyyy-MM-dd"
+(TimeFormatterModel *)getToday:(NSString *_Nullable)dateFormat{
    
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
/// 可以获得两个日期之间的时间间隔
/// @param startTime （给定） 开始时间【字符串格式】
/// @param endTime （可以不用给定）结束时间【字符串格式】
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
//https://www.jianshu.com/p/5f4e7fabcc02
/// iOS 获取 加上多少时间以后的时间A (NSDate *) = 基础时间（NSDate *） +  时间间隔（NSInteger）https://blog.csdn.net/weixin_34055787/article/details/91893379
+(NSDate *)getDate:(NSDate *_Nonnull)date
  afterIntegerTime:(NSInteger)afterIntegerTime{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = NSDateComponents.new;
    offsetComponents.hour = afterIntegerTime;
    NSDate *resultDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:date
                                                   options:0];
    return resultDate;
}
/// 以当前时间为基准，加上某个时间间隔（NSTimeInterval类型）以后的NSData值
+(NSDate *)getDateFromCurrentAfterTimeInterval:(NSTimeInterval)timeInterval{
    return [[NSDate alloc] initWithTimeIntervalSinceNow:timeInterval];
}
/// 计算两字符串时间的差值【方法一】
-(NSTimeInterval)intervalDifferenceBetweenStarTime:(NSString *)starTime
                                         toEndTime:(NSString *)endTime
                                   byDateFormatter:(NSDateFormatter *)dateFormatter{
    
    if (!dateFormatter) {
        TimeModel *timeModel = TimeModel.new;
        timeModel.dateFormatterStr = @"HH:mm:ss";//根据自己的需求定义格式
        dateFormatter = timeModel.dateFormatter;
    }
    NSDate *startDate = [dateFormatter dateFromString:starTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}
/// 计算两字符串时间的差值【方法二】
-(NSDateComponents *)dateComponentsDiffBetweenStarTime:(NSString *)starTime
                                             toEndTime:(NSString *)endTime
                                       byDateFormatter:(NSDateFormatter *)dateFormatter{
    if (!dateFormatter) {
        TimeModel *timeModel = TimeModel.new;
        timeModel.dateFormatterStr = @"HH:mm:ss";//根据自己的需求定义格式
        dateFormatter = timeModel.dateFormatter;
    }
    NSDate *date1 = [dateFormatter dateFromString:starTime];
    NSDate *date2 = [dateFormatter dateFromString:endTime];
    // 1.创建日历
    NSCalendar *calendar = NSCalendar.currentCalendar;
    
    NSCalendarUnit type =
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    // 2.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type
                                         fromDate:date1
                                           toDate:date2
                                          options:0];
    // 3.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", (long)cmps.year, (long)cmps.month, (long)cmps.day, (long)cmps.hour, (long)cmps.minute, (long)cmps.second);
    return cmps;
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
    NSDate *oldDate = [UserDefaultManager fetchDataWithKey:@"APPFirstStartKey"];
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
    UserDefaultModel *userDefaultModel = UserDefaultModel.new;
    userDefaultModel.key = @"APPFirstStartKey";
    userDefaultModel.obj = NSDate.date;
    
    [UserDefaultManager storedData:userDefaultModel];
    return flag;
}
///判断某个时间是否为  今天（系统时区）
+(BOOL)isToday:(NSDate *_Nonnull)date{
    NSDateFormatter *fmt = NSDateFormatter.new;
    fmt.timeZone = NSTimeZone.systemTimeZone; // 系统时区
    fmt.dateStyle = NSDateFormatterMediumStyle;
    fmt.timeStyle = NSDateFormatterShortStyle;
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:TimeModel.new.currentDate];// Now
    
    return [dateStr isEqualToString:nowStr];
}

@end
