//
//  NSString+ZBUTF8Encoding.m
//  ZBNetworkingDemo
//
//  Created by NQ UEC on 2018/5/21.
//  Copyright © 2018年 Suzhibin. All rights reserved.
//

#import "NSString+ZBUTF8Encoding.h"
#import <UIKit/UIKit.h>

@implementation NSString (ZBUTF8Encoding)

+(NSString *)zb_stringUTF8Encoding:(NSString *)urlString{
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0){
        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    }
}

+(NSString *)zb_urlString:(NSString *)urlString
      appendingParameters:(id)parameters{
    if (!parameters) {
        return urlString;
    }else{
        NSMutableArray *array = NSMutableArray.array;
        for (NSString *key in parameters) {
            id obj = [parameters objectForKey:key];
            NSString *str = [NSString stringWithFormat:@"%@=%@",key,obj];
            [array addObject:str];
        }
        
        NSString *parametersString = [array componentsJoinedByString:@"&"];
        return  [urlString stringByAppendingString:[NSString stringWithFormat:@"?%@",parametersString]];
    }
}

@end
