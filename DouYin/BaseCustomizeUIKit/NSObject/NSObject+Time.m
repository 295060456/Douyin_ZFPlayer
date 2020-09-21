//
//  NSObject+Time.m
//  Feidegou
//
//  Created by Kite on 2019/12/9.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "NSObject+Time.h"

@implementation NSObject (Time)
//https://blog.csdn.net/autom_lishun/article/details/79094241
+(NSArray *)dateStringAfterlocalDateForYear:(NSInteger)year
                                      Month:(NSInteger)month
                                        Day:(NSInteger)day
                                       Hour:(NSInteger)hour
                                     Minute:(NSInteger)minute
                                     Second:(NSInteger)second{
    NSDate *localDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:second];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *minDate = [calender dateByAddingComponents:comps toDate:localDate options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH"];
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:minDate];
    NSInteger thisYear=[components year];
    NSInteger thisMonth=[components month];
    NSInteger thisDay=[components day];
    NSInteger thisHour=[components hour];
    NSString *DateTime = [NSString stringWithFormat:@"%ld-%ld-%ld-%ld",(long)thisYear,(long)thisMonth,(long)thisDay,(long)thisHour];
    NSArray *array = [DateTime componentsSeparatedByString:@"-"];
    return array;
}
//https://blog.csdn.net/weixin_34055787/article/details/91893379
//https://www.jianshu.com/p/5f4e7fabcc02
+(NSDate *)getDate:(NSDate *)date
         afterTime:(NSInteger)afterTime{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:afterTime];
    NSDate *resultDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:date
                                                   options:0];
    return resultDate;
}
///获得当前时间
+(NSDate *)currentTime{
    NSDate *date = NSDate.date;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    NSDate *current = [date dateByAddingTimeInterval:interval];
    return current;
}
///获得今天的时间 年月日
+(NSString *)getToday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
///传入 秒  得到 xx:xx:xx
+(NSString *)getHHMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}
///传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}
///开始时间给定 结束时间不给定就启用现在的时间戳
+(NSTimeInterval)timeIntervalstartDate:(NSString *_Nonnull)startTime
                               endDate:(NSString *_Nullable)endTime
                         timeFormatter:(NSDateFormatter *_Nullable)timeFormatter{
    if (timeFormatter == nil ||
        timeFormatter == Nil) {
        timeFormatter = NSDateFormatter.new;
        [timeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate* startDate = [timeFormatter dateFromString:startTime];
    NSDate* endDate;
    if ([NSString isNullString:endTime]) {
        NSString *now = [timeFormatter stringFromDate:[NSDate date]];
        endDate = [timeFormatter dateFromString:now];
    }else{
        endDate = [timeFormatter dateFromString:endTime];
    }
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
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
///判断某个时间是否为今天
+ (BOOL)isToday:(NSDate *)date{
    NSDateFormatter *fmt = NSDateFormatter.new;
    fmt.timeZone = [NSTimeZone systemTimeZone]; // 系统时区
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:NSDate.date];//NOW
    
    return [dateStr isEqualToString:nowStr];
}
///时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue] / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
///时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970] * 1000];
    return timeSp;
}
///字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

@end
