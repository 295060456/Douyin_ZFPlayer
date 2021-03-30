//
//  DebugLogDescription.m
//  JobsComment
//
//  Created by Jobs on 2021/3/30.
//

#import "DebugLogDescription.h"
#import <objc/runtime.h>

#pragma mark ======================================== 日志打印 ========================================
//对NSLog
#if DEBUG
// 重写NSLog,Debug模式下打印日志和当前行数
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
//对DLog
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#ifdef DEBUG

static inline void sq_swizzleSelector(Class class,
                                      SEL originalSelector,
                                      SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
#pragma mark —— 打印model的内部属性内容
@implementation NSObject (DebugDescription)
/// debugDescription方法只会在调试po的时候调用，而在代码中打印不会调用
- (NSString *)debugDescription {
    //判断是否时NSArray 或者NSDictionary NSNumber 如果是的话直接返回 debugDescription
    if ([self isKindOfClass:NSArray.class] ||
        [self isKindOfClass:NSDictionary.class] ||
        [self isKindOfClass:NSString.class] ||
        [self isKindOfClass:NSNumber.class]) {
        return [self debugDescription];
    }
    //声明一个字典
    NSMutableDictionary *dictionary = NSMutableDictionary.dictionary;
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        [dictionary setObject:value forKey:name];//装载到字典里
    }
    //释放
    free(properties);
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}
/// 将obj转换成json字符串。如果失败则返回nil.
-(NSString *)convertToJsonString {
    //先判断是否能转化为JSON格式
    if (![NSJSONSerialization isValidJSONObject:self]) return nil;
    NSError *error = nil;
    NSJSONWritingOptions jsonOptions = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11.0, *)) {
        //11.0之后，可以将JSON按照key排列后输出，看起来会更舒服
        jsonOptions = NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys;
    }
    //核心代码，字典转化为有格式输出的JSON字符串
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error || !jsonData) return nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
#pragma mark —— 打印NSDictionary相关子类的内容
@implementation NSDictionary (DebugDescription)
//用此方法交换系统的 descriptionWithLocale: 方法。该方法在代码打印的时候调用。
- (NSString *)printlog_descriptionWithLocale:(id)locale{
    NSString *result = [self convertToJsonString];//转换成JSON格式字符串
    if (!result) {
        result = [self printlog_descriptionWithLocale:locale];//如果无法转换，就使用原先的格式
        return result;
    }return result;
}
//用此方法交换系统的 descriptionWithLocale:indent:方法。功能同上。
- (NSString *)printlog_descriptionWithLocale:(id)locale indent:(NSUInteger)level {

    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self printlog_descriptionWithLocale:locale indent:level];//如果无法转换，就使用原先的格式
        return result;
    }return result;
}
//用此方法交换系统的 debugDescription 方法。该方法在控制台使用po打印的时候调用。
- (NSString *)printlog_debugDescription{
    
    NSString *result = [self convertToJsonString];
    if (!result) return [self printlog_debugDescription];
    return result;
}
//在load方法中完成方法交换
+ (void)load {
    
    //方法交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        sq_swizzleSelector(class,
                           @selector(descriptionWithLocale:),
                           @selector(printlog_descriptionWithLocale:));
        sq_swizzleSelector(class,
                           @selector(descriptionWithLocale:indent:),
                           @selector(printlog_descriptionWithLocale:indent:));
        sq_swizzleSelector(class,
                           @selector(debugDescription),
                           @selector(printlog_debugDescription));
    });
}

@end
#pragma mark —— 打印NSArray相关子类的内容
@implementation NSArray (DebugDescription)
//在load方法中完成方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        sq_swizzleSelector(class,
                           @selector(descriptionWithLocale:),
                           @selector(printlog_descriptionWithLocale:));
        sq_swizzleSelector(class,
                           @selector(descriptionWithLocale:indent:),
                           @selector(printlog_descriptionWithLocale:indent:));
        sq_swizzleSelector(class,
                           @selector(debugDescription),
                           @selector(printlog_debugDescription));
    });
}
//用此方法交换系统的 descriptionWithLocale: 方法。该方法在代码打印的时候调用。
- (NSString *)printlog_descriptionWithLocale:(id)locale{
    NSString *result = [self convertToJsonString];//转换成JSON格式字符串
    if (!result) {
        result = [self printlog_descriptionWithLocale:locale];//如果无法转换，就使用原先的格式
        return result;
    }return result;
}
//用此方法交换系统的 descriptionWithLocale:indent:方法。功能同上。
- (NSString *)printlog_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *result = [self convertToJsonString];
    if (!result) {
        result = [self printlog_descriptionWithLocale:locale indent:level];//如果无法转换，就使用原先的格式
        return result;
    }return result;
}
//用此方法交换系统的 debugDescription 方法。该方法在控制台使用po打印的时候调用。
- (NSString *)printlog_debugDescription{
    NSString *result = [self convertToJsonString];
    if (!result) return [self printlog_debugDescription];
    return result;
}

@end

#endif


