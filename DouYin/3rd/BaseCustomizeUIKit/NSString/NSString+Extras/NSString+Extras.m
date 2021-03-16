//
//  NSString+YBCodec.m
//  Aa
//
//  Created by Aalto on 2018/11/20.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "NSString+Extras.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extras)

+(NSString *)test:(NSArray <NSString *>*)arr{
    NSString *resultStr;
    for (int i = 0; i < arr.count; i++) {
        NSString *tempStr = arr[i];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"/" withString:@""];//去除字符 /
        [resultStr stringByAppendingString:[NSString stringWithFormat:@"/%@",tempStr]];
    }return resultStr;
}
/**
*  判断对象 / 数组是否为空
*  为空返回 YES
*  不为空返回 NO
*/
+(BOOL)isNullString:(NSString *)string{
    if (string == nil ||
        string == NULL ||
        (NSNull *)string == NSNull.null ||
        [string isKindOfClass:NSNull.class] ||
        [string isEqualToString:@"(null)"]||
        [string isEqualToString:@"null"]||
        [string isEqualToString:@"<null>"]) {
        return YES;
    }

    string = StringFormat(@"%@",string);
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去掉两端的空格
    if (string.length == 0) {
        return YES;
    }return NO;
}
#pragma mark —— 字符串替换
/**
*  有时候我们加载的URL中可能会出现中文,需要我们手动进行转码,但是同时又要保证URL中的特殊字符保持不变,那么我们就可以使用下面的方法
*/
+(NSURL *)Url_Chinese:(NSString *)urlStr{
    SuppressWdeprecatedDeclarationsWarning(return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                                                             (CFStringRef)urlStr,
                                                                                                                                             (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                                                             NULL,kCFStringEncodingUTF8))]);
}
//替换相关的字符为暂位符 example
+(NSString *)numberSuitScanf:(NSString*)number{
    NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return numberString;
}
//我自己写的,服务器请求的数据为空值的时候进行替换本地默认值，因为json传输是通过对象包装来进行，所以其实归结起来就是2类，一类是基本数据类型被包装成Number、其他包装成String
+(NSString *)ensureNonnullString:(id)nullableStr
                      ReplaceStr:(NSString *)replaceStr{
    //只有NSNumber 和 NSString 这两种情况
    //过滤特殊字符：空格
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    replaceStr = [replaceStr stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
    if (replaceStr == nil ||
        replaceStr == Nil ||
        replaceStr.length == 0) {
        replaceStr = @"暂无数据";
    }
    if (nullableStr == nil ||
        nullableStr == NULL ||
        [nullableStr isKindOfClass:NSNull.class]) {//判断空 或者 空对象
        return replaceStr;
    }else if([nullableStr isKindOfClass:NSString.class]){
        NSString *str = (NSString *)nullableStr;
        str = [str stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
        return str.length == 0 ? replaceStr : str;
    }else if ([nullableStr isKindOfClass:NSNumber.class]){
        NSNumber *b = (NSNumber *)nullableStr;//longlong??
        if (strcmp([nullableStr objCType], @encode(BOOL)) == 0) {// Bool 类型
            return [NSString stringWithFormat:@"%d",b.boolValue];
        }else if (strcmp([nullableStr objCType], @encode(int)) == 0){// int 类型
            return [NSString stringWithFormat:@"%d",b.intValue];
        }else if (strcmp([nullableStr objCType], @encode(float)) == 0){// float 类型
            return [NSString stringWithFormat:@"%f",b.floatValue];
        }else if (strcmp([nullableStr objCType], @encode(double)) == 0){//double 类型
            return [NSString stringWithFormat:@"%f",b.doubleValue];
        }else if (strcmp([nullableStr objCType], @encode(char)) == 0){//char 类型
            return [NSString stringWithFormat:@"%c",b.charValue];
        }else if (strcmp([nullableStr objCType], @encode(u_char)) == 0){//unsigned char 类型
            return [NSString stringWithFormat:@"%c",b.charValue];
        }else if (strcmp([nullableStr objCType], @encode(short)) == 0){//short 类型
            return [NSString stringWithFormat:@"%c",b.shortValue];
        }else if (strcmp([nullableStr objCType], @encode(u_short)) == 0){//unsigned short 类型
            return [NSString stringWithFormat:@"%c",b.shortValue];
        }else if (strcmp([nullableStr objCType], @encode(long)) == 0){//long 类型
            return [NSString stringWithFormat:@"%ld",b.longValue];
        }else if (strcmp([nullableStr objCType], @encode(u_long)) == 0){//unsigned long 类型
            return [NSString stringWithFormat:@"%lu",b.unsignedLongValue];
        }else return replaceStr;
    }else return replaceStr;
}
#pragma mark —— 转化
//编码emoji
+(NSString *)emojiEncodeStr:(NSString *)str{
    NSString *uniStr = [NSString stringWithUTF8String:[str UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiText = [[NSString alloc] initWithData:uniData
                                                encoding:NSUTF8StringEncoding];
    return emojiText;
}
//解码emoji
+(NSString *)emojiDecodeStr:(NSString *)str{
    const char *jsonString = [str UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString
                                      length:strlen(jsonString)];
    NSString *emojiText = [[NSString alloc] initWithData:jsonData
                                                encoding:NSNonLossyASCIIStringEncoding];
    return emojiText;
}
// 读取本地JSON文件
+(NSDictionary *)readLocalFileWithName:(NSString *)name{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
//JSON 转 NSDictionary
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if ([NSString isNullString:jsonString]) {
        return nil;
    }
//  https://www.wynter.wang/2019/02/15/ios%20%20%E5%A4%84%E7%90%86%E5%AF%BC%E8%87%B4json%E8%A7%A3%E6%9E%90%E5%A4%B1%E8%B4%A5%E7%9A%84%E7%89%B9%E6%AE%8A%E5%AD%97%E7%AC%A6/
//  特殊字符会导致解析失败
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }return dic;
}
// NSDictionary 转 json字符串方法//==[dic mj_JSONString]
+(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" "
                            withString:@""
                               options:NSLiteralSearch
                                 range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n"
                            withString:@""
                               options:NSLiteralSearch
                                 range:range2];
    return mutStr;
}
//NSDictionary 转 NSString
+(NSString *)convertDictionaryToString:(NSMutableDictionary *)dict{
    NSError *error;
    NSDictionary *tempDict = dict.copy;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *nsJson=  [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return nsJson;
}
// 判断是否为纯整数
+(BOOL)judgeiphoneNumberInt:(NSString *)number{
    NSScanner *scan = [NSScanner scannerWithString:number];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//字符串中取数字
+(long long)getDigitsFromStr:(NSString *)str{
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int remainSecond = [[str stringByTrimmingCharactersInSet:nonDigits] intValue];
    return (long long)remainSecond;
}
//是否包含空格
+(BOOL)isHaveWhiteSpace:(NSString *)text{
    NSRange _range = [text rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return true;
    }else {
        //没有空格
        return false;
    }
}
/// 给定某字符串，判断里面的组成char是否全部为某个char
/// @param originString 被判定的字符串
/// @param standardChar 需要被检出的标准
+(BOOL)isAllSameCharInString:(NSString *)originString
                standardChar:(char)standardChar{
    if (originString.length > 0) {
        NSMutableArray* carries = [NSMutableArray array];
        for (int i=0; i < originString.length; i++) {
            char s = [originString characterAtIndex:i];
            if(s == standardChar){
                NSString *tempString = [NSString stringWithUTF8String:&s];
                [carries addObject:tempString];
            }
        }
        if (carries.count == originString.length) {
            return YES;
        }else{
            return NO;
        }
    }return NO;
}
/// 根据字符串以及其对应的行宽（行高）、行高和字体字号，计算该文本占用的高度（宽度）
/// @param lineSpacing 行与行之间的间距
/// @param calcLabelHeight_Width 计算的结论是宽或者高
/// @param effectString 影响的字符串
/// @param font 该字符串的字号和字体
/// @param Height_Width  文本的宽度
+(CGFloat)getContentHeightOrWidthWithParagraphStyleLineSpacing:(CGFloat)lineSpacing
                                         calcLabelHeight_Width:(CalcLabelHeight_Width)calcLabelHeight_Width
                                                  effectString:(NSString *_Nonnull)effectString
                                                          font:(UIFont *_Nullable)font
                                  boundingRectWithHeight_Width:(CGFloat)Height_Width{
    if(@available(iOS 7.0, *)){
        CGSize lableSize = CGSizeZero;
        if([effectString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
            NSMutableDictionary *attributesMutDic = NSMutableDictionary.dictionary;
            if (font) {
                [attributesMutDic setObject:font
                                     forKey:NSFontAttributeName];
            }
            if (lineSpacing) {
                NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
                paragraphStyle.lineSpacing = lineSpacing;
                [attributesMutDic setObject:paragraphStyle
                                     forKey:NSParagraphStyleAttributeName];
            }
            
            CGSize size;
            
            switch (calcLabelHeight_Width) {
                case CalcLabelHeight:{
                    size = CGSizeMake(Height_Width, MAXFLOAT);
                }break;
                case CalcLabelWidth:{
                    size = CGSizeMake(MAXFLOAT, Height_Width);
                }break;
                default:{
                    size = CGSizeZero;
                }break;
            }
            
            CGSize sizeTemp = [effectString boundingRectWithSize:size
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:attributesMutDic
                                                         context:nil].size;
            lableSize = CGSizeMake(ceilf(sizeTemp.width),
                                   ceilf(sizeTemp.height));
        }
        
        switch (calcLabelHeight_Width) {
            case CalcLabelHeight:{
                return lableSize.height;;
            }break;
            case CalcLabelWidth:{
                return lableSize.width;;
            }break;
            default:{
                return 0;
            }break;
        }
    }else{
        NSAssert(NO, @"系统版本低于iOS 7，不兼容Api，请升级系统");
        return 0;
    }
}
#warning —— 以下待考证真伪及其严谨性
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i = 0;i < len;i++){
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}
//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring,
                                         NSRange substringRange,
                                         NSRange enclosingRange,
                                         BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
                returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 ||
                hs == 0xae ||
                hs == 0x303d ||
                hs == 0x3030 ||
                hs == 0x2b55 ||
                hs == 0x2b1c ||
                hs == 0x2b1b ||
                hs == 0x2b50 ||
                hs == 0xd83e) {
                returnValue =YES;
            }
        }
    }];return returnValue;
}
//？？？
- (NSString *)formatDecimalNumber{
    if (!self || self.length == 0) {
        return self;
    }
    NSNumber *number = @([self doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}
/*
 分开来注释一下：
 ^ 匹配一行的开头位置
 (?![0-9]+$) 预测该位置后面不全是数字
 (?![a-zA-Z]+$) 预测该位置后面不全是字母
 [0-9A-Za-z] {8,16} 由8-16位数字或这字母组成
 $ 匹配行结尾位置
 
 注：(?!xxxx) 是正则表达式的负向零宽断言一种形式，标识预该位置后不是xxxx字符。
 https:blog.csdn.net/w6524587/article/details/56279494
密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：
 ^[a-zA-Z]\w{5,17}$
强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：
 ^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$

 */
+(BOOL)isContainAllCharType:(NSString*)originString{
    
    NSString * regex = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

//    NSString * regexLower = @"[a-z]+$";
//    NSPredicate *predLower = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexLower];
//
//    NSString * regexNumber = @"[^0-9]+$";
//    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNumber];
    
    BOOL isMatch = ([pred evaluateWithObject:originString]
                    );//&&[predLower evaluateWithObject:originString]
//    &&![predNumber evaluateWithObject:originString]
    return isMatch;
    
//    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z0-9]*" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSInteger count = [numberRegular numberOfMatchesInString:originString options:NSMatchingReportProgress range:NSMakeRange(0, originString.length)];//count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
//    if (count > 0) {
//        return YES;
//
//    }
//    return NO;
}

+ (NSString*)getAnonymousString:(NSString* )originString{
    if (originString.length < 2) {
        return originString;
    }
    NSMutableArray* carries = [NSMutableArray array];
    for (int i=1; i<originString.length - 1; i++) {
        char s = [originString characterAtIndex:i];
        s = '*';
        NSString *tempString = [NSString stringWithUTF8String:&s];
        [carries addObject:tempString];
    }
    NSString *string = [carries componentsJoinedByString:@""];
    NSString *anonymousString = [originString stringByReplacingCharactersInRange:NSMakeRange(1, originString.length - 2)
                                                                      withString:string];
    return anonymousString;
}
// 截取字符串方法封装// 截取字符串方法封装
- (NSString *)subStringFrom:(NSString *)startString
                         to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length,
                                endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}
// 如果字符串为null 那么不走isEqualToString，无法比较都是空的情况
+(BOOL)isEqualStrA:(NSString *)stringA
              strB:(NSString *)stringB{
    if ([NSString isNullString:stringA] && [NSString isNullString:stringB]) {//双方都是null
        return YES;
    }else{
        return [stringA isEqualToString:stringB];
    }
}

// 根据字体大小 和宽度计算文字的高
+(float)textHitWithStirng:(NSString*)stingS
                     font:(float)font
                     widt:(float)wid{
    if (!font) {
        font = 14.0;
    }
    if (!stingS) {
        stingS = @"";
    }
    if (!wid || wid == 0.0) {
        wid = 20;
    }
    CGRect rect=[stingS boundingRectWithSize:CGSizeMake(wid, MAXFLOAT)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font weight:UIFontWeightRegular]}
                                     context:nil];
    return rect.size.height;
}
/// 统计字符串中中英文的字数
/// @param statisticsAlphabetNumberType 统计模式
-(NSInteger)statisticsAlphabetNumberwithType:(StatisticsAlphabetNumberType)statisticsAlphabetNumberType{
    NSInteger chineseCount = 0;
    NSInteger EnglishCount = 0;
    for (NSInteger i = 0; i < self.length; i++){
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            chineseCount ++;
        }else{
            EnglishCount ++;
        }
    }
         
    NSLog(@"字符串:%@包含——> 汉字字数：%ld;字母字数%ld",self,(long)chineseCount,(long)EnglishCount);
    
    switch (statisticsAlphabetNumberType) {
        case StatisticsAlphabetNumberType_Chinese:{
            return chineseCount;
        }break;
        case StatisticsAlphabetNumberType_English:{
            return EnglishCount;
        }break;
        default:
            break;
    }
}
/// 该字符串是否含有空格
-(BOOL)isContainSpacing{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;//有空格
    }return NO;
}
/**
    过滤表情
    在这个方法中处理  - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 */
+(BOOL)isContainsTwoEmoji:(NSString *)string{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString * _Nullable substring,
                                         NSRange substringRange,
                                         NSRange enclosingRange,
                                         BOOL * _Nonnull stop) {
        const unichar hs = [substring characterAtIndex:0];
        NSLog(@"hs++++++++%04x",hs);
        if (0xd800 <= hs && hs <=  0xdbff){
            if (substring.length > 1){
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) *0xd400) + (ls -0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f){
                     isEomji = YES;
                }
                NSLog(@"uc++++++++%04x",uc);
            }else if(substring.length > 1){
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3|| ls ==0xfe0f){
                    isEomji = YES;
                }
                NSLog(@"ls++++++++%04x",ls);
            }else{
                if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b){
                    isEomji = YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07){
                    isEomji = YES;
                }else if (0x2934 <= hs && hs <= 0x2935){
                    isEomji = YES;
                }else if (0x3297 <= hs && hs <= 0x3299){
                    isEomji = YES;
                }else if (hs == 0xa9 ||
                          hs == 0xae ||
                          hs == 0x303d ||
                          hs == 0x3030 ||
                          hs == 0x2b55 ||
                          hs == 0x2b1c ||
                          hs == 0x2b1b ||
                          hs == 0x2b50||
                          hs == 0x231a){
                    isEomji = YES;
                 }
            }
        }
    }];return isEomji;
}

- (BOOL)isHaveAppleEomji:(NSString *)text{
    __block BOOL isEomji = NO;
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL * _Nonnull stop) {
//        if(substring.length ==  EmojiCharacterLength){
//            isEomji = YES;
//        }
    }];return isEomji;
}
/// 字符串是否包含URL
-(BOOL)isContainsUrl{
    return [self rangeOfString:@"https://"].location != NSNotFound || [self rangeOfString:@"http://"].location != NSNotFound;
}

@end
