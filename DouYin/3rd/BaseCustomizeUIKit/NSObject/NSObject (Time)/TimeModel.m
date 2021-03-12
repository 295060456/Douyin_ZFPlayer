//
//  TimeModel.m
//  JobsIM
//
//  Created by Jobs on 2020/11/11.
//

#import "TimeModel.h"

@implementation TimeFormatterModel

@end

@implementation TimeModel
/*
 *  为了防止溢出，基本上时间戳传给后台或者后台返回给我们的都是字符串类型的。
 *  时间戳定义：从1970年1月1日开始计时到现在所经过的时间
 */
#pragma mark —— 当前时间：来源iOS系统Api
// 获取当前时间，始终有值，且每时每刻都在变化，也就是每次取值都不一样，所以不能用懒加载
-(NSDate *)currentDate{
    return NSDate.date;
}
// 距离当前时间的秒数 【正数为未来、负数为过去】
-(CGFloat)currentDateOffsetSec{
    return _currentDateOffsetSec;
}
// 与currentDateOffsetSec发生作用，表示据当前时间的一个偏差时间的时间
-(NSDate *)currentOffsetDate{
    return [NSDate dateWithTimeIntervalSinceNow:self.currentDateOffsetSec];
}
// 获取当前iOS时间戳（字符串格式）
-(NSString *)currentTimestampStr{
    return [NSString stringWithFormat:@"%@",self.currentDate];//因为当前时间是不断变化，当前时间戳也在不断地变化，所以不能用懒加载
}
// 获取当前时间sec秒后的时间戳秒数
-(NSTimeInterval)currentTimestampOffsetSec{
    return [self.currentOffsetDate timeIntervalSince1970];
}
// 获取当前时间sec秒后的时间戳毫秒数
-(NSTimeInterval)currentTimestampOffsetMilliSec{
    return self.currentTimestampOffsetSec * 1000;
}
// 获取当前时间的时间戳秒数
-(NSTimeInterval)currentTimestampSec{
    return [self.currentDate timeIntervalSince1970];
}
// 获取当前时间的时间戳毫秒数
-(NSTimeInterval)currentTimestampMilliSec{
    return self.currentTimestampSec * 1000;
}
#pragma mark —— 自定义某一个时间：来源比如说是服务器时间
-(NSDate *)customDate{
    return _customDate;//自定义某一个时间，不需要缺省值
}
// 自定义某一个时间的时间戳（字符串格式）
-(NSString *)customTimestampStr{
    return [NSString stringWithFormat:@"%@",self.customDate];
}
// 自定义某一个时间的时间戳秒数(基本数据类型)
-(NSTimeInterval)customTimestampSec{
    if (self.customDate) {
        return [self.customDate timeIntervalSince1970];
    }else{
        NSLog(@"自定义某一个时间为null，请检查");
        NSAssert(self.customDate, @"自定义某一个时间为null，请检查");
        return 0;
    }
}
// 自定义某一个时间的时间戳毫秒数
-(NSTimeInterval)customTimestampMilliSec{
    return self.customTimestampSec * 1000;
}
#pragma mark —— 时区
//手机当前时区
-(NSTimeZone *)localTimeZone{
    if (!_localTimeZone) {
        _localTimeZone = NSTimeZone.localTimeZone;
    }return _localTimeZone;
}
//自定义时区名 默认北京时区
-(NSString *)customTimeZoneStr{
    if(!_customTimeZoneStr){
        _customTimeZoneStr = @"GMT+0800";// 我爱北京天安门，天安门上太阳升
    }return _customTimeZoneStr;
}
//自定义时区
-(NSTimeZone *)customTimeZone{
    return [NSTimeZone timeZoneWithName:self.customTimeZoneStr];
}
#pragma mark —— 时间格式化
-(NSString *)dateFormatterStr{
    if (!_dateFormatterStr) {
        /*
         科普
         //NSDateFormatter常用的格式有：
         @"yyyy-MM-dd HH:mm:ss.SSS"
         @"yyyy-MM-dd HH:mm:ss"
         @"yyyy-MM-dd"
         @"MM dd yyyy"
         
         //NSDateFormatter格式化参数如下：(注意区分大小写)
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
        _dateFormatterStr = @"yyyy-MM-dd HH:mm:ss zzz";//设置缺省类型，外层可自定义
    }return _dateFormatterStr;
}

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = NSDateFormatter.new;
        _dateFormatter.dateFormat = self.dateFormatterStr;
    }return _dateFormatter;
}
#pragma mark —— 结论部分
//当前时区与格林威治时间的时间差
-(NSInteger)timeOffset{
    return [self.localTimeZone secondsFromGMTForDate:self.currentDate];
}
//自定义时区与格林威治时间的时间差
-(NSInteger)customTimeOffset{
    return [self.customTimeZone secondsFromGMTForDate:self.currentDate];
}

@end
