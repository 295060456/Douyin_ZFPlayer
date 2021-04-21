//
//  TimeModel.h
//  JobsIM
//
//  Created by Jobs on 2020/11/11.
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

@interface TimeModel : NSObject

/*
 *  为了防止溢出，基本上时间戳传给后台或者后台返回给我们的都是字符串类型的。
 *  时间戳定义：从1970年1月1日开始计时到现在所经过的时间
 */
#pragma mark —— 当前时间：来源iOS系统Api
@property(nonatomic,strong)NSDate *currentDate;// 获取当前时间，始终有值，且每时每刻都在变化，也就是每次取值都不一样，所以不能用懒加载
@property(nonatomic,assign)CGFloat currentDateOffsetSec;// 距离当前时间的秒数 【正数为未来、负数为过去】
@property(nonatomic,strong)NSDate *currentOffsetDate;// 与currentDateOffsetSec发生作用，表示据当前时间的一个偏差时间的时间
@property(nonatomic,strong)NSString *currentTimestampStr;// 获取当前iOS时间戳（字符串格式）
@property(nonatomic,assign)NSTimeInterval currentTimestampOffsetSec;// 取当前时间sec秒后的时间戳秒数
@property(nonatomic,assign)NSTimeInterval currentTimestampSec;// 获取当前时间的时间戳秒数
@property(nonatomic,assign)NSTimeInterval currentTimestampOffsetMilliSec;// 获取当前时间sec秒后的时间戳毫秒数
@property(nonatomic,assign)NSTimeInterval currentTimestampMilliSec;// 获取当前时间的时间戳毫秒数
@property(nonatomic,assign)NSInteger currentEra;// 当前年代
@property(nonatomic,assign)NSInteger currentYear;// 当前年份
@property(nonatomic,assign)NSInteger currentMonth;// 当前月份
@property(nonatomic,assign)NSInteger currentDay;// 当前日
@property(nonatomic,assign)NSInteger currentHour;// 当前小时
@property(nonatomic,assign)NSInteger currentMin;// 当前分
@property(nonatomic,assign)NSInteger currentSec;// 当前秒
@property(nonatomic,assign)NSInteger currentNanoSec;// 当前纳秒
@property(nonatomic,assign)NSInteger currentWeekday;// 当前星期几 表示周里面的天 1代表周日 2代表周一 7代表周六
@property(nonatomic,assign)NSInteger currentWeekdayOrdinal;//
@property(nonatomic,assign)NSInteger currentQuarter;
@property(nonatomic,assign)NSInteger currentWeekOfMonth;// 该月份的第几周
@property(nonatomic,assign)NSInteger currentWeekOfYear;// 该年份的第几周
@property(nonatomic,assign)NSInteger currentYearForWeekOfYear;//
#pragma mark —— 自定义某一个时间：来源比如说是服务器时间
@property(nonatomic,strong)NSDate *customDate;
@property(nonatomic,strong)NSString *customTimestampStr;// 自定义某一个时间的时间戳（字符串格式）
@property(nonatomic,assign)NSTimeInterval customTimestampSec;// 自定义某一个时间的时间戳秒数
@property(nonatomic,assign)NSTimeInterval customTimestampMilliSec;// 自定义某一个时间的时间戳毫秒数
@property(nonatomic,assign)NSInteger customEra;// 当前年代
@property(nonatomic,assign)NSInteger customYear;// 当前年份
@property(nonatomic,assign)NSInteger customMonth;// 当前月份
@property(nonatomic,assign)NSInteger customDay;// 当前日
@property(nonatomic,assign)NSInteger customHour;// 当前小时
@property(nonatomic,assign)NSInteger customMin;// 当前分
@property(nonatomic,assign)NSInteger customSec;// 当前秒
@property(nonatomic,assign)NSInteger customNanoSec;// 当前纳秒
@property(nonatomic,assign)NSInteger customWeekday;// 当前星期几 表示周里面的天 1代表周日 2代表周一 7代表周六
@property(nonatomic,assign)NSInteger customWeekdayOrdinal;//
@property(nonatomic,assign)NSInteger customQuarter;
@property(nonatomic,assign)NSInteger customWeekOfMonth;// 该月份的第几周
@property(nonatomic,assign)NSInteger customWeekOfYear;// 该年份的第几周
@property(nonatomic,assign)NSInteger customYearForWeekOfYear;//
#pragma mark —— 时区
@property(nonatomic,strong)NSTimeZone *localTimeZone;// 手机当前时区
@property(nonatomic,strong)NSString *customTimeZoneStr;// 自定义时区名 默认北京时区
@property(nonatomic,strong)NSTimeZone *customTimeZone;// 自定义时区
#pragma mark —— 时间格式化
@property(nonatomic,strong)NSString *dateFormatterStr;
@property(nonatomic,strong)NSDateFormatter *dateFormatter;
#pragma mark —— 结论部分  外层怎么用自己去拼接 内核只做重要工作
// 特殊标注：星期是以周日开始的,1代表周日、2代表周一...7代表周六
@property(nonatomic,assign)NSInteger timeOffset;// 当前时区与格林威治时间的时间差
@property(nonatomic,assign)NSInteger customTimeOffset;// 自定义时区与格林威治时间的时间差


@end

NS_ASSUME_NONNULL_END
