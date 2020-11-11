//
//  NSString+Time.m
//  JobsIM
//
//  Created by Jobs on 2020/11/11.
//

#import "NSString+Time.h"

@implementation NSString (Time)
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
//接受一个秒数，对这个秒数进行解析出：时、分、秒，存入TimeModel，外层再对这个TimeModel进行取值，对数据进行拼装
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

@end
