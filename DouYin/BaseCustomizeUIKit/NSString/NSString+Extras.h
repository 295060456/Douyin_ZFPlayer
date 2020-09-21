//
//  NSString+YBCodec.h
//  Aa
//
//  Created by Aalto on 2018/11/20.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extras)

+(NSString *)test:(NSArray <NSString *>*)arr;
/**
*  判断对象 / 数组是否为空
*  为空返回 YES
*  不为空返回 NO
*/
+(BOOL)isNullString:(NSString *)string;
#pragma mark —— 字符串替换
/**
*  有时候我们加载的URL中可能会出现中文,需要我们手动进行转码,但是同时又要保证URL中的特殊字符保持不变,那么我们就可以使用下面的方法
*/
+(NSURL *)Url_Chinese:(NSString *)urlStr;
//替换相关的字符为暂位符 example
+(NSString *)numberSuitScanf:(NSString*)number;
//我自己写的,服务器请求的数据为空值的时候进行替换本地默认值，因为json传输是通过对象包装来进行，所以其实归结起来就是2类，一类是基本数据类型被包装成Number、其他包装成String
+(NSString *)ensureNonnullString:(id)nullableStr
                      ReplaceStr:(NSString *)replaceStr;
#pragma mark —— 转化
//编码emoji
+(NSString *)emojiEncodeStr:(NSString *)str;
//解码emoji
+(NSString *)emojiDecodeStr:(NSString *)str;
//JSON 转 NSDictionary
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// NSDictionary 转 json字符串方法//==[dic mj_JSONString]
+(NSString *)convertToJsonData:(NSDictionary *)dict;
//NSDictionary 转 NSString
+ (NSString *)convertDictionaryToString:(NSMutableDictionary *)dict;
// 判断是否为纯整数
+(BOOL)judgeiphoneNumberInt:(NSString *)number;
//字符串中取数字
+(long long)getDigitsFromStr:(NSString *)str;
//是否包含空格
+(BOOL)isHaveWhiteSpace:(NSString *)text;
/// 给定某字符串，判断里面的组成char是否全部为某个char
/// @param originString 被判定的字符串
/// @param standardChar 需要被检出的标准
+ (BOOL)isAllSameCharInString:(NSString *)originString
                 standardChar:(char)standardChar;
#pragma mark —— 时间相关
/// 获取系统时间戳
+(NSString *)getSysTimeStamp;
//服务器时间转化为某固定格式
+(NSString *)getMMSSFromSS:(NSInteger)totalTime;
//将秒数转换为字符串格式
+(NSString *)timeWithSecond:(NSInteger)second;
/// 以固定格式解析并返回服务器时间戳
/// @param timeStampString 服务器返回的13位时间戳，毫秒
/// iOS 生成的时间戳是10位
+(NSString *)getTimeString:(NSString *)timeStampString;
#pragma mark -限宽计算AttributeString与String的高度
+(CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString
                                          withFontSize:(float)fontSize
                                 boundingRectWithWidth:(CGFloat)width;

+(CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing
                                         fontWithString:(NSString *)fontWithString
                                             fontOfSize:(CGFloat)fontOfSize
                                  boundingRectWithWidth:(CGFloat)width;

+(float)textHitWithStirng:(NSString*)stingS
                     font:(float)font
                     widt:(float)wid;

@end

NS_ASSUME_NONNULL_END
