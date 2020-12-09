//
//  TimeModel.h
//  JobsIM
//
//  Created by Jobs on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeModel : NSObject

/*
 *  为了防止溢出，基本上时间戳传给后台或者后台返回给我们的都是字符串类型的。
 *  时间戳定义：从1970年1月1日开始计时到现在所经过的时间
 */
#pragma mark —— 当前时间：来源iOS系统Api
@property(nonatomic,strong)NSDate *currentDate;
@property(nonatomic,strong)NSString *currentTimestampStr;//当前iOS时间戳（字符串格式）
@property(nonatomic,assign)NSTimeInterval currentTimestampSec;//当前时间戳秒数(基本数据类型)
@property(nonatomic,assign)NSTimeInterval currentTimestampInterval;// 实际是一个double ; interval得出的数会有6位小数，应该是精确到微秒
@property(nonatomic,assign)NSInteger currentEra;//当前年代
@property(nonatomic,assign)NSInteger currentYear;//当前年份
@property(nonatomic,assign)NSInteger currentMonth;//当前月份
@property(nonatomic,assign)NSInteger currentDay;//当前日
@property(nonatomic,assign)NSInteger currentHour;//当前小时
@property(nonatomic,assign)NSInteger currentMin;//当前分
@property(nonatomic,assign)NSInteger currentSec;//当前秒
@property(nonatomic,assign)NSInteger currentNanoSec;//当前纳秒
@property(nonatomic,assign)NSInteger currentWeekday;//当前星期几 表示周里面的天 1代表周日 2代表周一 7代表周六
@property(nonatomic,assign)NSInteger currentWeekdayOrdinal;//
@property(nonatomic,assign)NSInteger currentQuarter;
@property(nonatomic,assign)NSInteger currentWeekOfMonth;//该月份的第几周
@property(nonatomic,assign)NSInteger currentWeekOfYear;//该年份的第几周
@property(nonatomic,assign)NSInteger currentYearForWeekOfYear;//
#pragma mark —— 自定义某一个时间：来源比如说是服务器时间
@property(nonatomic,strong)NSDate *customDate;
@property(nonatomic,strong)NSString *customTimestampStr;//自定义某一个时间的时间戳（字符串格式）
@property(nonatomic,assign)NSTimeInterval customTimestampSec;//自定义某一个时间的时间戳秒数(基本数据类型)
@property(nonatomic,assign)NSTimeInterval customTimestampInterval;// 实际是一个double ; interval得出的数会有6位小数，应该是精确到微秒
@property(nonatomic,assign)NSInteger customEra;//当前年代
@property(nonatomic,assign)NSInteger customYear;//当前年份
@property(nonatomic,assign)NSInteger customMonth;//当前月份
@property(nonatomic,assign)NSInteger customDay;//当前日
@property(nonatomic,assign)NSInteger customHour;//当前小时
@property(nonatomic,assign)NSInteger customMin;//当前分
@property(nonatomic,assign)NSInteger customSec;//当前秒
@property(nonatomic,assign)NSInteger customNanoSec;//当前纳秒
@property(nonatomic,assign)NSInteger customWeekday;//当前星期几 表示周里面的天 1代表周日 2代表周一 7代表周六
@property(nonatomic,assign)NSInteger customWeekdayOrdinal;//
@property(nonatomic,assign)NSInteger customQuarter;
@property(nonatomic,assign)NSInteger customWeekOfMonth;//该月份的第几周
@property(nonatomic,assign)NSInteger customWeekOfYear;//该年份的第几周
@property(nonatomic,assign)NSInteger customYearForWeekOfYear;//
#pragma mark —— 时区
@property(nonatomic,strong)NSTimeZone *localTimeZone;//手机当前时区
@property(nonatomic,strong)NSString *customTimeZoneStr;//自定义时区名 默认北京时区
@property(nonatomic,strong)NSTimeZone *customTimeZone;//自定义时区
#pragma mark —— 时间格式化
@property(nonatomic,strong)NSString *dateFormatterStr;
@property(nonatomic,strong)NSDateFormatter *dateFormatter;
#pragma mark —— 结论部分  外层怎么用自己去拼接 内核只做重要工作
//特殊标注：星期是以周日开始的,1代表周日、2代表周一...7代表周六
@property(nonatomic,assign)NSInteger timeOffset;//当前时区与格林威治时间的时间差
@property(nonatomic,assign)NSInteger customTimeOffset;//自定义时区与格林威治时间的时间差

-(void)makeSpecificTime;//各个具体时间的拆解
//以当前手机系统时间（包含了时区）为基准，给定一个日期偏移值（正值代表未来，负值代表过去，0代表现在），返回字符串特定格式的“星期几”
+(NSString *)whatDayOfWeekDistanceNow:(NSInteger)offsetDay;
/// 获取一个格式化的字符串时间
/// @param date 传空则是当前iOS系统时间
/// @param dateFormatStr 传空则格式是@"yyyy-MM-dd HH:mm:ss zzz"
-(NSString *)getDayWithDate:(NSDate *_Nullable)date
              dateFormatStr:(NSString *_Nullable)dateFormatStr;

@end

NS_ASSUME_NONNULL_END
